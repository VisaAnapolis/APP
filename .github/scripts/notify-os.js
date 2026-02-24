// ============================================================
// notify-os.js  —  GitHub Actions Script
// Detecta OSs com prazo vencendo e envia notificações push via FCM
//
// Lógica:
//   1. Lê os 4 CSVs de OS (requerimento, oficio, denuncia, protocolo)
//   2. Compara com o snapshot anterior (data/os_snapshot.json)
//   3. Calcula dias para o prazo de cada OS
//   4. Identifica OSs nos gatilhos de prazo:
//        - VENCE_HOJE  : prazo = 0 dias (vence hoje) — dispara 1x/dia pela manhã
//        - AMANHA      : prazo = 1 dia
//        - RECUPERACAO : prazo 2-4 dias (cobre finais de semana)
//        - PRAZO_5D    : prazo = 5 dias
//   5. Busca todos os tokens FCM dos usuários ativos no Firestore
//   6. Envia notificação multicast para cada fiscal
//   7. Atualiza flags no snapshot para evitar duplicidade
//   8. Salva novo snapshot para a próxima comparação
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
  { tipo: 'Requerimento', arquivo: 'data/requerimento.csv', campoNumero: 'OS',       campoFiscal: 'Fiscal_Sugere', campoMotivo: 'Motivo', campoPrazo: 'Prazo', campoAtendida: 'Atendimento', campoCancelada: 'Cancelado' },
  { tipo: 'Ofício',       arquivo: 'data/oficio.csv',       campoNumero: 'Oficio',   campoFiscal: 'Fiscalencaminha', campoMotivo: 'Motivo', campoPrazo: 'Prazo', campoAtendida: 'Archive', campoCancelada: 'Cancela' },
  { tipo: 'Denúncia',     arquivo: 'data/denuncia.csv',     campoNumero: 'Denuncia', campoFiscal: 'FiscalEncaminha', campoMotivo: 'Objeto1', campoPrazo: 'Prazo', campoAtendida: 'Archive', campoCancelada: null },
  { tipo: 'Protocolo',    arquivo: 'data/protocolo.csv',    campoNumero: 'Protocolo', campoFiscal: 'Usuario',        campoMotivo: 'Assunto', campoPrazo: null, campoAtendida: null, campoCancelada: null }
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

// ── Converte data DD/MM/YYYY ou DD.MM.YYYY para objeto Date ──
function converterData(dataStr) {
  if (!dataStr) return null;
  const match = dataStr.match(/(\d{1,2})[./](\d{1,2})[./](\d{4})/);
  if (!match) return null;
  const [, dia, mes, ano] = match;
  return new Date(parseInt(ano), parseInt(mes) - 1, parseInt(dia));
}

// ── Calcula dias até a data (negativo = vencido) ──────────────
function calcularDiasAte(dataStr) {
  const data = converterData(dataStr);
  if (!data) return null;
  const hoje = new Date();
  hoje.setHours(0, 0, 0, 0);
  data.setHours(0, 0, 0, 0);
  const diff = data - hoje;
  return Math.floor(diff / (1000 * 60 * 60 * 24));
}

// ── Lê todos os números de OS dos CSVs com prazo ──────────────
function lerTodasOSs() {
  const todas = {};   // { "20260589": { tipo, fiscal, motivo, prazo, atendida, cancelada } }

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

      const atendida = cfg.campoAtendida ? (r[cfg.campoAtendida] || '').toLowerCase() === 'sim' : false;
      const cancelada = cfg.campoCancelada ? (r[cfg.campoCancelada] || '').toLowerCase() === 'sim' : false;

      // Só registra OSs pendentes (não atendidas e não canceladas)
      if (atendida || cancelada) continue;

      todas[numero] = {
        tipo:   cfg.tipo,
        fiscal: (r[cfg.campoFiscal] || '').trim(),
        motivo: (r[cfg.campoMotivo] || '').trim(),
        prazo:  cfg.campoPrazo ? (r[cfg.campoPrazo] || '').trim() : null,
        atendida,
        cancelada
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
async function buscarTokensFCMPorFiscal() {
  const tokensPorFiscal = {};  // { "NOME FISCAL": [token1, token2, ...] }
  try {
    const snap = await db.collection('usuarios').get();
    snap.forEach(docSnap => {
      const data = docSnap.data();
      // Só envia para usuários ativos (ou sem campo ativo — compatibilidade)
      if (data.ativo === false || data.notificationOptIn === false) return;
      const nome = (data.nome || '').toUpperCase().trim();
      const fcmTokens = data.fcmTokens || [];
      const tokensValidos = fcmTokens.filter(t => t && typeof t === 'string' && t.length > 20);
      if (tokensValidos.length > 0 && nome) {
        tokensPorFiscal[nome] = tokensValidos;
      }
    });
  } catch (err) {
    console.error('❌ Erro ao buscar tokens FCM:', err.message);
  }
  const totalTokens = Object.values(tokensPorFiscal).reduce((sum, arr) => sum + arr.length, 0);
  console.log(`📱 ${totalTokens} token(s) FCM encontrado(s) para ${Object.keys(tokensPorFiscal).length} fiscal(is) com opt-in.`);
  return tokensPorFiscal;
}

// ── Envia notificação para um fiscal específico ───────────────
async function enviarNotificacaoFiscal(tokens, numero, tipo, motivo, diasParaPrazo) {
  if (!tokens || tokens.length === 0) return { enviados: 0, erros: 0 };

  let mensagem_texto = '';
  if (diasParaPrazo === 0) {
    mensagem_texto = `OS ${numero} — ${motivo}, VENCE HOJE`;
  } else if (diasParaPrazo === 1) {
    mensagem_texto = `OS ${numero} — ${motivo}, prazo amanhã`;
  } else if (diasParaPrazo >= 2 && diasParaPrazo <= 5) {
    mensagem_texto = `OS ${numero} — ${motivo}, prazo ${diasParaPrazo} dias`;
  } else {
    console.log(`[Notificação] OS ${numero} ignorada: fora da janela de prazo (${diasParaPrazo} dias).`);
    return { enviados: 0, erros: 0 };  // Não envia se não estiver na "janela"
  }

  const titulo = `🔔 Alerta de Prazo — VISA Anápolis`;
  const corpo = mensagem_texto;

  // Enviamos APENAS o campo "data" (sem "notification").
  // Isso força o Service Worker (firebase-messaging-sw.js) a ser o
  // responsável exclusivo por exibir a notificação, evitando que o
  // Android exiba a mensagem padrão "Toque para copiar o URL desse app".
  const mensagem = {
    data: {
      title: titulo,
      body:  corpo,
      url:   'https://garrado.github.io/VISA/index.html',
      tipo:  'prazo-alerta',
      osNum: numero
    },
    webpush: {
      headers: {
        Urgency: 'high'
      },
      fcmOptions: {
        link: 'https://garrado.github.io/VISA/index.html'
      }
    }
  };

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

  return { enviados, erros };
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
  console.log('🚀 VISA Notifier — verificando prazos...');
  const agora = new Date().toLocaleString('pt-BR', { timeZone: 'America/Sao_Paulo' });
  console.log(`📅 ${agora}`);

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

  // 4. Busca tokens FCM por fiscal
  const tokensPorFiscal = await buscarTokensFCMPorFiscal();

  // 5. Detecta OSs nos gatilhos de prazo
  const alertas = { VENCE_HOJE: 0, PRAZO_5D: 0, RECUPERACAO: 0, AMANHA: 0 };
  const novoSnapshot = {};
  let totalEnviados = 0, totalErros = 0;

  for (const [numero, osAtual] of Object.entries(osAtuais)) {
    const osAnterior = snapshot[numero] || {};
    const diasParaPrazo = osAtual.prazo ? calcularDiasAte(osAtual.prazo) : null;

    // Copia dados atuais para o novo snapshot
    novoSnapshot[numero] = {
      ...osAtual,
      notif_5d: osAnterior.notif_5d || false,
      notif_recuperacao: osAnterior.notif_recuperacao || false,
      notif_amanha: osAnterior.notif_amanha || false,
      notif_hoje: osAnterior.notif_hoje || false
    };

    // Ignora OSs sem prazo ou sem fiscal
    if (diasParaPrazo === null || !osAtual.fiscal) continue;

    const fiscalUpper = osAtual.fiscal.toUpperCase().trim();
    const tokens = tokensPorFiscal[fiscalUpper] || [];

    // ── GATILHO 0: Vence HOJE (prazo = 0) ───────────────────
    // Dispara uma vez por dia pela manhã (cron 8:30).
    // A flag notif_hoje é resetada automaticamente quando a OS
    // muda de dia (o snapshot é recriado a cada execução).
    // IMPORTANTE: notif_hoje só bloqueia repetição no mesmo dia
    // (rodadas das 12:30 e 16:30). No dia seguinte, a OS já estará
    // vencida (diasParaPrazo < 0) e não entrará mais neste gatilho.
    if (diasParaPrazo === 0 && !osAnterior.notif_hoje) {
      console.log(`⚠️  VENCE_HOJE ${numero}: sem token FCM para "${osAtual.fiscal}"`);
      alertas.VENCE_HOJE++;
      if (tokens.length > 0) {
        const { enviados, erros } = await enviarNotificacaoFiscal(tokens, numero, osAtual.tipo, osAtual.motivo, diasParaPrazo);
        totalEnviados += enviados;
        totalErros += erros;
        if (enviados > 0) {
          novoSnapshot[numero].notif_hoje = true;
          console.log(`✅ VENCE_HOJE ${numero}: ${enviados} notificação(ões) enviada(s)`);
        }
      }
    }

    // ── GATILHO 1: Prazo exatamente em 5 dias ────────────────
    if (diasParaPrazo === 5 && !osAnterior.notif_5d) {
      console.log(`⚠️  PRAZO_5D ${numero}: sem token FCM para "${osAtual.fiscal}"`);
      alertas.PRAZO_5D++;
      if (tokens.length > 0) {
        const { enviados, erros } = await enviarNotificacaoFiscal(tokens, numero, osAtual.tipo, osAtual.motivo, diasParaPrazo);
        totalEnviados += enviados;
        totalErros += erros;
        if (enviados > 0) {
          novoSnapshot[numero].notif_5d = true;
          console.log(`✅ PRAZO_5D ${numero}: ${enviados} notificação(ões) enviada(s)`);
        }
      }
    }

    // ── GATILHO 2: "Janela de Recuperação" (2-4 dias) ────────
    if (diasParaPrazo >= 2 && diasParaPrazo <= 4 && !osAnterior.notif_5d && !osAnterior.notif_recuperacao) {
      console.log(`⚠️  RECUPERACAO ${numero}: sem token FCM para "${osAtual.fiscal}"`);
      alertas.RECUPERACAO++;
      if (tokens.length > 0) {
        const { enviados, erros } = await enviarNotificacaoFiscal(tokens, numero, osAtual.tipo, osAtual.motivo, diasParaPrazo);
        totalEnviados += enviados;
        totalErros += erros;
        if (enviados > 0) {
          novoSnapshot[numero].notif_recuperacao = true;
          console.log(`✅ RECUPERACAO ${numero}: ${enviados} notificação(ões) enviada(s)`);
        }
      }
    }

    // ── GATILHO 3: Prazo exatamente amanhã (1 dia) ───────────
    if (diasParaPrazo === 1 && !osAnterior.notif_amanha) {
      console.log(`⚠️  AMANHA ${numero}: sem token FCM para "${osAtual.fiscal}"`);
      alertas.AMANHA++;
      if (tokens.length > 0) {
        const { enviados, erros } = await enviarNotificacaoFiscal(tokens, numero, osAtual.tipo, osAtual.motivo, diasParaPrazo);
        totalEnviados += enviados;
        totalErros += erros;
        if (enviados > 0) {
          novoSnapshot[numero].notif_amanha = true;
          console.log(`✅ AMANHA ${numero}: ${enviados} notificação(ões) enviada(s)`);
        }
      }
    }
  }

  // 6. Log dos resultados
  const totalAlertas = alertas.VENCE_HOJE + alertas.PRAZO_5D + alertas.RECUPERACAO + alertas.AMANHA;
  console.log(`\n🔔 Alertas de prazo detectados: ${totalAlertas}`);
  console.log(`   VENCE_HOJE: ${alertas.VENCE_HOJE}`);
  console.log(`   AMANHA: ${alertas.AMANHA}`);
  console.log(`   RECUPERACAO: ${alertas.RECUPERACAO}`);
  console.log(`   PRAZO_5D: ${alertas.PRAZO_5D}`);
  console.log(`📤 Total: ${totalEnviados} notificação(ões) enviada(s), ${totalErros} erro(s).`);

  // 7. Salva novo snapshot
  salvarSnapshot(novoSnapshot);

  console.log('✅ Processo concluído.');
  process.exit(0);
}

main().catch(err => {
  console.error('❌ Erro fatal:', err);
  process.exit(1);
});
