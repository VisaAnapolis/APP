// ============================================================
// notify-os.js  —  GitHub Actions Script
// Detecta novas OSs nos CSVs e envia notificações push via FCM
//
// Lógica:
//   1. Lê os 4 CSVs de OS (requerimento, oficio, denuncia, protocolo)
//   2. Compara com o snapshot anterior (data/os_snapshot.json)
//   3. Identifica OSs novas (número não existia no snapshot anterior)
//   4. Busca todos os tokens FCM dos usuários ativos no Firestore
//   5. Envia notificação multicast para todos os tokens
//   6. Salva novo snapshot para a próxima comparação
// ============================================================

const fs   = require('fs');
const path = require('path');

// Firebase Admin SDK
const admin = require('firebase-admin');

// ── Inicialização do Firebase Admin ──────────────────────────
const serviceAccountPath = process.env.FIREBASE_SERVICE_ACCOUNT_PATH
  || path.join(__dirname, 'service-account.json');

const serviceAccount = JSON.parse(fs.readFileSync(serviceAccountPath, 'utf8'));

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db        = admin.firestore();
const messaging = admin.messaging();

// ── Caminhos dos arquivos ────────────────────────────────────
const ROOT          = path.join(__dirname, '..', '..');   // raiz do repo
const SNAPSHOT_FILE = path.join(ROOT, 'data', 'os_snapshot.json');

// Mapeamento: tipo → arquivo CSV → campo número
const CSV_CONFIGS = [
  { tipo: 'Requerimento', arquivo: 'data/requerimento.csv', campoNumero: 'OS',       campoFiscal: 'Fiscal_Sugere', campoMotivo: 'Motivo' },
  { tipo: 'Ofício',       arquivo: 'data/oficio.csv',       campoNumero: 'Oficio',   campoFiscal: 'Fiscalencaminha', campoMotivo: 'Motivo' },
  { tipo: 'Denúncia',     arquivo: 'data/denuncia.csv',     campoNumero: 'Denuncia', campoFiscal: 'FiscalEncaminha', campoMotivo: 'Objeto1' },
  { tipo: 'Protocolo',    arquivo: 'data/protocolo.csv',    campoNumero: 'Protocolo', campoFiscal: 'Usuario',        campoMotivo: 'Assunto' }
];

// ── Parser CSV simples (sem dependências externas) ───────────
function parseCSV(conteudo) {
  const linhas = conteudo.split('\n').filter(l => l.trim());
  if (linhas.length < 2) return [];

  // Remove BOM UTF-8 se presente
  const primeiraLinha = linhas[0].replace(/^\uFEFF/, '');
  const cabecalho = primeiraLinha.split(';').map(c => c.replace(/^"|"$/g, '').trim());

  const registros = [];
  for (let i = 1; i < linhas.length; i++) {
    const linha = linhas[i];
    if (!linha.trim()) continue;

    // Parser simples para CSV com delimitador ";" e campos entre aspas
    const campos = [];
    let atual = '';
    let dentroAspas = false;
    for (let j = 0; j < linha.length; j++) {
      const c = linha[j];
      if (c === '"') {
        dentroAspas = !dentroAspas;
      } else if (c === ';' && !dentroAspas) {
        campos.push(atual.trim());
        atual = '';
      } else {
        atual += c;
      }
    }
    campos.push(atual.trim());

    const obj = {};
    cabecalho.forEach((col, idx) => {
      obj[col] = campos[idx] || '';
    });
    registros.push(obj);
  }
  return registros;
}

// ── Lê todos os números de OS dos CSVs ──────────────────────
function lerTodasOSs() {
  const todas = {};   // { "20260589": { tipo, fiscal, motivo } }

  for (const cfg of CSV_CONFIGS) {
    const caminhoArquivo = path.join(ROOT, cfg.arquivo);
    if (!fs.existsSync(caminhoArquivo)) {
      console.warn(`⚠️  Arquivo não encontrado: ${cfg.arquivo}`);
      continue;
    }

    const conteudo = fs.readFileSync(caminhoArquivo, 'utf8');
    const registros = parseCSV(conteudo);

    for (const r of registros) {
      const numero = (r[cfg.campoNumero] || '').trim();
      if (!numero) continue;

      todas[numero] = {
        tipo:   cfg.tipo,
        fiscal: (r[cfg.campoFiscal] || '').trim(),
        motivo: (r[cfg.campoMotivo] || '').trim()
      };
    }
  }

  return todas;
}

// ── Carrega snapshot anterior ────────────────────────────────
function carregarSnapshot() {
  if (!fs.existsSync(SNAPSHOT_FILE)) {
    console.log('📋 Snapshot não encontrado — primeira execução, criando baseline.');
    return null;
  }
  try {
    return JSON.parse(fs.readFileSync(SNAPSHOT_FILE, 'utf8'));
  } catch (e) {
    console.warn('⚠️  Erro ao ler snapshot:', e.message);
    return null;
  }
}

// ── Salva novo snapshot ──────────────────────────────────────
function salvarSnapshot(dados) {
  fs.writeFileSync(SNAPSHOT_FILE, JSON.stringify(dados, null, 2), 'utf8');
  console.log(`✅ Snapshot salvo: ${Object.keys(dados).length} OSs registradas.`);
}

// ── Busca tokens FCM de usuários ativos no Firestore ─────────
async function buscarTokensFCM() {
  const tokens = [];
  try {
    const snap = await db.collection('usuarios').get();
    snap.forEach(docSnap => {
      const data = docSnap.data();
      // Só envia para usuários ativos (ou sem campo ativo — compatibilidade)
      if (data.ativo === false) return;
      const fcmTokens = data.fcmTokens || [];
      fcmTokens.forEach(t => {
        if (t && typeof t === 'string' && t.length > 20) {
          tokens.push(t);
        }
      });
    });
  } catch (err) {
    console.error('❌ Erro ao buscar tokens FCM:', err.message);
  }
  console.log(`📱 ${tokens.length} token(s) FCM encontrado(s).`);
  return tokens;
}

// ── Envia notificação multicast ──────────────────────────────
async function enviarNotificacoes(tokens, novasOSs) {
  if (tokens.length === 0) {
    console.warn('⚠️  Nenhum token FCM disponível. Notificações não enviadas.');
    return;
  }

  const qtd = novasOSs.length;
  const primeiras = novasOSs.slice(0, 3);

  // Monta corpo da notificação
  let corpo = '';
  if (qtd === 1) {
    const os = primeiras[0];
    corpo = `OS ${os.numero} (${os.tipo})`;
    if (os.fiscal) corpo += ` — Fiscal: ${os.fiscal}`;
  } else if (qtd <= 3) {
    corpo = primeiras.map(o => `${o.tipo} ${o.numero}`).join(', ');
  } else {
    corpo = `${primeiras.map(o => `${o.tipo} ${o.numero}`).join(', ')} e mais ${qtd - 3}`;
  }

  const titulo  = `🔔 ${qtd} nova${qtd > 1 ? 's' : ''} OS${qtd > 1 ? 's' : ''} — VISA Anápolis`;
  const mensagem = {
    notification: {
      title: titulo,
      body:  corpo
    },
    data: {
      url:    'https://garrado.github.io/VISA/os.html',
      qtdOSs: String(qtd),
      tipo:   'os-update'
    },
    webpush: {
      notification: {
        icon:  'https://garrado.github.io/VISA/icons/visa-192.png',
        badge: 'https://garrado.github.io/VISA/icons/visa-192.png',
        tag:   'visa-os-update',
        renotify: true,
        requireInteraction: false
      },
      fcmOptions: {
        link: 'https://garrado.github.io/VISA/os.html'
      }
    }
  };

  // FCM aceita no máximo 500 tokens por chamada multicast
  const LOTE = 500;
  let enviados = 0, erros = 0;

  for (let i = 0; i < tokens.length; i += LOTE) {
    const lote = tokens.slice(i, i + LOTE);
    try {
      const resp = await messaging.sendEachForMulticast({ ...mensagem, tokens: lote });
      enviados += resp.successCount;
      erros    += resp.failureCount;

      // Remove tokens inválidos do Firestore
      if (resp.failureCount > 0) {
        const tokensInvalidos = [];
        resp.responses.forEach((r, idx) => {
          if (!r.success) {
            const code = r.error?.code || '';
            if (
              code === 'messaging/registration-token-not-registered' ||
              code === 'messaging/invalid-registration-token'
            ) {
              tokensInvalidos.push(lote[idx]);
            }
          }
        });
        if (tokensInvalidos.length > 0) {
          await removerTokensInvalidos(tokensInvalidos);
        }
      }
    } catch (err) {
      console.error(`❌ Erro ao enviar lote ${i / LOTE + 1}:`, err.message);
      erros += lote.length;
    }
  }

  console.log(`📤 Notificações: ${enviados} enviadas, ${erros} erros.`);
}

// ── Remove tokens inválidos do Firestore ─────────────────────
async function removerTokensInvalidos(tokensInvalidos) {
  const { FieldValue } = admin.firestore;
  try {
    const snap = await db.collection('usuarios').get();
    const batch = db.batch();
    let alteracoes = 0;

    snap.forEach(docSnap => {
      const data = docSnap.data();
      const tokens = data.fcmTokens || [];
      const tokensFiltrados = tokens.filter(t => !tokensInvalidos.includes(t));
      if (tokensFiltrados.length !== tokens.length) {
        batch.update(docSnap.ref, { fcmTokens: tokensFiltrados });
        alteracoes++;
      }
    });

    if (alteracoes > 0) {
      await batch.commit();
      console.log(`🧹 ${tokensInvalidos.length} token(s) inválido(s) removido(s) de ${alteracoes} usuário(s).`);
    }
  } catch (err) {
    console.warn('⚠️  Erro ao remover tokens inválidos:', err.message);
  }
}

// ── Função principal ─────────────────────────────────────────
async function main() {
  console.log('🚀 VISA Notifier — iniciando verificação de novas OSs...');
  console.log(`📅 ${new Date().toLocaleString('pt-BR', { timeZone: 'America/Sao_Paulo' })}`);

  // 1. Lê estado atual dos CSVs
  const osAtuais = lerTodasOSs();
  console.log(`📊 Total de OSs nos CSVs: ${Object.keys(osAtuais).length}`);

  // 2. Carrega snapshot anterior
  const snapshot = carregarSnapshot();

  // 3. Se não há snapshot, apenas cria o baseline (primeira execução)
  if (!snapshot) {
    salvarSnapshot(osAtuais);
    console.log('ℹ️  Primeira execução: baseline criado. Notificações serão enviadas na próxima atualização.');
    process.exit(0);
  }

  // 4. Detecta OSs novas (presentes agora mas não no snapshot)
  const novasOSs = [];
  for (const [numero, info] of Object.entries(osAtuais)) {
    if (!snapshot[numero]) {
      novasOSs.push({ numero, ...info });
    }
  }

  console.log(`🆕 Novas OSs detectadas: ${novasOSs.length}`);

  if (novasOSs.length === 0) {
    console.log('✅ Nenhuma OS nova. Nenhuma notificação enviada.');
    // Atualiza snapshot mesmo assim (pode ter mudanças em outros campos)
    salvarSnapshot(osAtuais);
    process.exit(0);
  }

  // Log das novas OSs
  novasOSs.slice(0, 10).forEach(os => {
    console.log(`  → ${os.tipo} ${os.numero} | Fiscal: ${os.fiscal || 'N/A'} | ${os.motivo || ''}`);
  });
  if (novasOSs.length > 10) {
    console.log(`  ... e mais ${novasOSs.length - 10} OS(s).`);
  }

  // 5. Busca tokens FCM
  const tokens = await buscarTokensFCM();

  // 6. Envia notificações
  await enviarNotificacoes(tokens, novasOSs);

  // 7. Salva novo snapshot
  salvarSnapshot(osAtuais);

  console.log('✅ Processo concluído.');
  process.exit(0);
}

main().catch(err => {
  console.error('❌ Erro fatal:', err);
  process.exit(1);
});
