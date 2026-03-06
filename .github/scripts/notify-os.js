// ============================================================
// notify-os.js  —  GitHub Actions Script
// Detecta OSs com prazo vencendo e envia notificações push via FCM
//
// Lógica:
//   1. Lê os 5 CSVs de OS (requerimento, oficio, denuncia, protocolo, tramitacao)
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

// Lista oficial de fiscais (mesma do os.html) — usada para validar DESTINO da tramitação
const FISCAIS_OFICIAIS = [
  "ACADIA DE SOUZA VIEIRA SILVA",
  "ADRIANA CRHISTINA DE REZENDE CARNEIRO",
  "ADRIANE PEREIRA GUIMARÃES",
  "ALINE CASTRO DAMASIO",
  "ANA PAULA RODRIGUES CORRÊA GUIMARÃES",
  "ANGELA RIBEIRO NEVES",
  "ARIANNE FERREIRA VIEIRA",
  "CÉSIO MALAQUIAS",
  "CLÁUDIO NASCIMENTO SILVA",
  "CLÓVIS RAFAEL BORGES FERREIRA",
  "DANIEL SOARES BARBOSA",
  "DANIELA DE ALMEIDA CASTRO",
  "EDSON ARANTES FARIA FILHO",
  "EDUARDO LUCAS MAGALHÃES CASTRO",
  "FABÍOLA PEDROSA PEIXOTO MARQUES",
  "GERALDO EDSON ROSA",
  "GLEICIANE MARIA JOSÉ DA SILVA",
  "GÚBIO DIAS PEREIRA",
  "JOÃO BATISTA LUCAS DA SILVA REIS",
  "JOSE LUIZ RIBEIRO",
  "JULIANA FERREIRA VITURINO",
  "JULIANA KÊNIA MARTINS DA SILVA",
  "JULIO CÉSAR TELES SPINDOLA",
  "KAMILLA CHRYSTINE ROLIM D. SANTOS GARCÊS",
  "LIDIANE SIMÕES",
  "LIVIA BRITO",
  "LUCIANA CONSOLAÇÃO DOS SANTOS",
  "LUCIANA SANTANA DA ROCHA",
  "LUCIENE DE SOUZA BARBOSA GOMES SILVA",
  "MARCIO HENRIQUE GOMES RODOVALHO",
  "MARIA EDWIGES PINHEIRO DE SOUZA CHAVES",
  "MARINA PERILLO NAVARRETE LAVERS",
  "PATRÍCIA CORDEIRO DE MORAES E SOUZA",
  "PEDRO HENRIQUE AIRES RIBEIRO",
  "RODRIGO ALESSANDRO TÔGO SANTOS",
  "RÚBIA MARA DE FREITAS",
  "SILVIA MARQUES NAVES DA MOTA SOUZA",
  "SIMONE DUARTE GROSSI",
  "TATHIANE PESSOA DE SOUZA",
  "THIAGO GOMES GOBO",
  "VANESSA SANTANA",
  "VIVIANE MANOEL DA SILVA BORGES",
  "VIVIANE MIYADA",
  "WANESSA DE BRITO JORGE"
];

const FISCAIS_NORM = new Set(
  FISCAIS_OFICIAIS.map(f => f.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toUpperCase().trim())
);

function fiscalValido(nome) {
  if (!nome || nome.trim() === '') return false;
  const norm = nome.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toUpperCase().trim();
  return FISCAIS_NORM.has(norm);
}

// Mapeamento: tipo → arquivo CSV → campos
// Protocolo não entra aqui — tem lógica especial via tramitacao.csv
const CSV_CONFIGS = [
  { tipo: 'Requerimento', arquivo: 'data/requerimento.csv', campoNumero: 'OS',       campoFiscal: 'Fiscal_Encaminha', campoMotivo: 'Motivo', campoPrazo: 'Prazo', campoAtendida: 'Atendimento', campoCancelada: 'Cancelado' },
  { tipo: 'Ofício',       arquivo: 'data/oficio.csv',       campoNumero: 'Oficio',   campoFiscal: 'Fiscalencaminha',  campoMotivo: 'Motivo', campoPrazo: 'Prazo', campoAtendida: 'Archive',     campoCancelada: 'Cancela' },
  { tipo: 'Denúncia',     arquivo: 'data/denuncia.csv',     campoNumero: 'Denuncia', campoFiscal: 'FiscalEncaminha',  campoMotivo: 'Objeto1', campoPrazo: 'Prazo', campoAtendida: 'Archive',    campoCancelada: null },
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

// ── Converte data para string YYYY-MM-DD (para comparação) ────
function dataParaISO(dataStr) {
  const d = converterData(dataStr);
  if (!d) return '';
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  return `${y}-${m}-${day}`;
}

// ── Converte hora AM/PM para 24h (mesma lógica do os.html) ────
function converterHora12para24(horaStr) {
  if (!horaStr || horaStr.trim() === '') return '00:00:00';
  let s = horaStr.trim().toUpperCase();
  if (s.includes('.') && !s.includes(':')) s = s.replace(/\./g, ':');
  const mPeriodo = s.match(/\b(AM|PM)\b/);
  const periodo = mPeriodo ? mPeriodo[1] : null;
  s = s.replace(/\b(AM|PM)\b/g, '').trim().replace(/\s+/g, '');
  const partes = s.split(':').map(p => p.trim()).filter(Boolean);
  if (partes.length < 2) return '00:00:00';
  let h = parseInt(partes[0], 10);
  let m = parseInt(partes[1], 10);
  let sec = partes.length >= 3 ? parseInt(partes[2], 10) : 0;
  if ([h, m, sec].some(n => Number.isNaN(n))) return '00:00:00';
  if (periodo) {
    if (periodo === 'PM' && h !== 12) h += 12;
    if (periodo === 'AM' && h === 12) h = 0;
  }
  h = Math.min(Math.max(h, 0), 23);
  m = Math.min(Math.max(m, 0), 59);
  sec = Math.min(Math.max(sec, 0), 59);
  return `${String(h).padStart(2, '0')}:${String(m).padStart(2, '0')}:${String(sec).padStart(2, '0')}`;
}

// ── Adiciona N dias úteis a uma data ISO (YYYY-MM-DD) ─────────
function adicionarDiasUteis(dataISO, diasUteis) {
  if (!dataISO) return null;
  const data = new Date(dataISO + 'T00:00:00');
  let adicionados = 0;
  while (adicionados < diasUteis) {
    data.setDate(data.getDate() + 1);
    if (data.getDay() !== 0 && data.getDay() !== 6) adicionados++;
  }
  const y = data.getFullYear();
  const m = String(data.getMonth() + 1).padStart(2, '0');
  const d = String(data.getDate()).padStart(2, '0');
  return `${d}.${m}.${y}`;
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

// ── Carrega e indexa tramitações por número de protocolo ──────
function carregarTramitacoes() {
  const arq = path.join(ROOT, 'data', 'tramitacao.csv');
  if (!fs.existsSync(arq)) {
    console.warn('⚠️  tramitacao.csv não encontrado');
    return {};
  }
  const registros = parseCSV(fs.readFileSync(arq, 'utf8'));
  const mapa = {};
  for (const r of registros) {
    const proto = (r['PROTOCOLO'] || '').trim();
    if (!proto) continue;
    if (!mapa[proto]) mapa[proto] = [];
    mapa[proto].push(r);
  }
  return mapa;
}

// ── Busca o último fiscal válido na tramitação de um protocolo ─
function buscarFiscalTramitacao(tramitacoes) {
  if (!tramitacoes || tramitacoes.length === 0) return { fiscal: null, dataEncaminha: null };

  const comChave = tramitacoes.map(t => {
    const dataISO = dataParaISO(t['DATA'] || '');
    const hora24 = converterHora12para24(t['HORA'] || '');
    return { ...t, _chave: dataISO + 'T' + hora24 };
  });
  comChave.sort((a, b) => (a._chave > b._chave ? 1 : a._chave < b._chave ? -1 : 0));

  for (let i = comChave.length - 1; i >= 0; i--) {
    const destino = (comChave[i]['DESTINO'] || '').trim();
    if (fiscalValido(destino)) {
      return {
        fiscal: destino,
        dataEncaminha: dataParaISO(comChave[i]['DATA'] || '')
      };
    }
  }
  return { fiscal: null, dataEncaminha: null };
}

// ── Lê todos os números de OS dos CSVs com prazo ──────────────
function lerTodasOSs() {
  const todas = {};

  // ── Requerimento, Ofício, Denúncia ─────────────────────────
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

  // ── Protocolo (fiscal vem da tramitação, prazo = 15 dias úteis) ─
  const protocoloArq = path.join(ROOT, 'data', 'protocolo.csv');
  if (fs.existsSync(protocoloArq)) {
    const registrosProto = parseCSV(fs.readFileSync(protocoloArq, 'utf8'));
    const tramitacoes = carregarTramitacoes();

    for (const r of registrosProto) {
      const numero = (r['Protocolo'] || '').trim();
      if (!numero) continue;

      const { fiscal, dataEncaminha } = buscarFiscalTramitacao(tramitacoes[numero]);
      if (!fiscal || !dataEncaminha) continue;

      const prazo = adicionarDiasUteis(dataEncaminha, 15);

      todas[numero] = {
        tipo:      'Protocolo',
        fiscal:    fiscal,
        motivo:    (r['Assunto'] || '').trim(),
        prazo:     prazo,
        atendida:  false,
        cancelada: false
      };
    }
  } else {
    console.warn('⚠️  Arquivo não encontrado: data/protocolo.csv');
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
// Atualiza fcmTokens[] E zera dispositivos[chave].fcmToken para
// manter consistência entre o array de envio e o mapa de dispositivos.
async function removerTokensInvalidos(tokensInvalidos) {
  try {
    const snap = await db.collection('usuarios').get();
    const batch = db.batch();
    let alteracoes = 0;

    snap.forEach(docSnap => {
      const data = docSnap.data();
      const tokens = data.fcmTokens || [];
      const tokensFiltrados = tokens.filter(t => !tokensInvalidos.includes(t));
      if (tokensFiltrados.length !== tokens.length) {
        const update = { fcmTokens: tokensFiltrados };

        // Zera fcmToken em cada dispositivo que usava um dos tokens inválidos
        const dispositivos = data.dispositivos || {};
        for (const chave of Object.keys(dispositivos)) {
          if (tokensInvalidos.includes(dispositivos[chave]?.fcmToken)) {
            update[`dispositivos.${chave}.fcmToken`] = null;
          }
        }

        batch.update(docSnap.ref, update);
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
      alertas.VENCE_HOJE++;
      if (tokens.length === 0) {
        console.log(`⚠️  VENCE_HOJE ${numero}: sem token FCM para "${osAtual.fiscal}"`);
      } else {
        const { enviados, erros } = await enviarNotificacaoFiscal(tokens, numero, osAtual.tipo, osAtual.motivo, diasParaPrazo);
        totalEnviados += enviados;
        totalErros += erros;
        if (enviados > 0) {
          novoSnapshot[numero].notif_hoje = true;
          console.log(`✅ VENCE_HOJE ${numero}: ${enviados} notificação(ões) enviada(s) para "${osAtual.fiscal}"`);
        }
      }
    }

    // ── GATILHO 1: Prazo exatamente em 5 dias ────────────────
    if (diasParaPrazo === 5 && !osAnterior.notif_5d) {
      alertas.PRAZO_5D++;
      if (tokens.length === 0) {
        console.log(`⚠️  PRAZO_5D ${numero}: sem token FCM para "${osAtual.fiscal}"`);
      } else {
        const { enviados, erros } = await enviarNotificacaoFiscal(tokens, numero, osAtual.tipo, osAtual.motivo, diasParaPrazo);
        totalEnviados += enviados;
        totalErros += erros;
        if (enviados > 0) {
          novoSnapshot[numero].notif_5d = true;
          console.log(`✅ PRAZO_5D ${numero}: ${enviados} notificação(ões) enviada(s) para "${osAtual.fiscal}"`);
        }
      }
    }

    // ── GATILHO 2: "Janela de Recuperação" (2-4 dias) ────────
    if (diasParaPrazo >= 2 && diasParaPrazo <= 4 && !osAnterior.notif_5d && !osAnterior.notif_recuperacao) {
      alertas.RECUPERACAO++;
      if (tokens.length === 0) {
        console.log(`⚠️  RECUPERACAO ${numero}: sem token FCM para "${osAtual.fiscal}"`);
      } else {
        const { enviados, erros } = await enviarNotificacaoFiscal(tokens, numero, osAtual.tipo, osAtual.motivo, diasParaPrazo);
        totalEnviados += enviados;
        totalErros += erros;
        if (enviados > 0) {
          novoSnapshot[numero].notif_recuperacao = true;
          console.log(`✅ RECUPERACAO ${numero}: ${enviados} notificação(ões) enviada(s) para "${osAtual.fiscal}"`);
        }
      }
    }

    // ── GATILHO 3: Prazo exatamente amanhã (1 dia) ───────────
    if (diasParaPrazo === 1 && !osAnterior.notif_amanha) {
      alertas.AMANHA++;
      if (tokens.length === 0) {
        console.log(`⚠️  AMANHA ${numero}: sem token FCM para "${osAtual.fiscal}"`);
      } else {
        const { enviados, erros } = await enviarNotificacaoFiscal(tokens, numero, osAtual.tipo, osAtual.motivo, diasParaPrazo);
        totalEnviados += enviados;
        totalErros += erros;
        if (enviados > 0) {
          novoSnapshot[numero].notif_amanha = true;
          console.log(`✅ AMANHA ${numero}: ${enviados} notificação(ões) enviada(s) para "${osAtual.fiscal}"`);
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
