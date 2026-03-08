// ============================================================
// notify-os.js  —  GitHub Actions Script
// Detecta OSs com prazo vencendo e envia notificações push via FCM
// e e-mail HTML rico consolidado por fiscal.
//
// Lógica:
//   1. Lê os 5 CSVs de OS (requerimento, oficio, denuncia, protocolo, tramitacao)
//   2. Lê regulados.csv, bairros.csv e cnae.csv para enriquecer os dados
//   3. Compara com o snapshot anterior (data/os_snapshot.json)
//   4. Calcula dias para o prazo de cada OS
//   5. Identifica OSs nos gatilhos de prazo:
//        - VENCE_HOJE  : prazo = 0 dias — dispara 1x/dia pela manhã
//        - AMANHA      : prazo = 1 dia
//        - RECUPERACAO : prazo 2-4 dias (cobre finais de semana)
//        - PRAZO_5D    : prazo = 5 dias
//   6. Agrupa OSs alertadas por fiscal
//   7. Envia notificação push FCM (curta) para cada dispositivo do fiscal
//   8. Envia e-mail HTML rico consolidado para o endereço do fiscal no Firestore
//   9. Atualiza flags no snapshot para evitar duplicidade
//  10. Salva novo snapshot para a próxima comparação
// ============================================================

const fs   = require('fs');
const path = require('path');

// Firebase Admin SDK
const admin = require('firebase-admin');

// Nodemailer para envio de e-mail
const nodemailer = require('nodemailer');

// ── Inicialização do Firebase Admin ──────────────────────────
const serviceAccountPath = process.env.FIREBASE_SERVICE_ACCOUNT_PATH
  || path.join(__dirname, 'service-account.json');

const serviceAccount = JSON.parse(fs.readFileSync(serviceAccountPath, 'utf8'));

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db        = admin.firestore();
const messaging = admin.messaging();

// ── Configuração do e-mail (via secrets do GitHub Actions) ───
// Secrets esperados:
//   EMAIL_USER  — remetente (ex.: visa.anapolis.notif@gmail.com)
//   EMAIL_PASS  — senha de app do Gmail (App Password)
//   EMAIL_FROM  — nome exibido (ex.: "VISA Anápolis")
const EMAIL_USER = process.env.EMAIL_USER || '';
const EMAIL_PASS = process.env.EMAIL_PASS || '';
const EMAIL_FROM = process.env.EMAIL_FROM || 'VISA Anápolis <visa.notif@anapolis.go.gov.br>';
const EMAIL_ENABLED = !!(EMAIL_USER && EMAIL_PASS);

let transporter = null;
if (EMAIL_ENABLED) {
  transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: { user: EMAIL_USER, pass: EMAIL_PASS }
  });
}

// ── Caminhos dos arquivos ────────────────────────────────────
const ROOT          = path.join(__dirname, '..', '..');   // raiz do repo
const SNAPSHOT_FILE = path.join(ROOT, 'data', 'os_snapshot.json');

// ── Lista oficial de fiscais ─────────────────────────────────
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
const CSV_CONFIGS = [
  { tipo: 'Requerimento', arquivo: 'data/requerimento.csv', campoNumero: 'OS',       campoFiscal: 'Fiscal_Encaminha', campoMotivo: 'Motivo',  campoPrazo: 'Prazo', campoAtendida: 'Atendimento', campoCancelada: 'Cancelado' },
  { tipo: 'Ofício',       arquivo: 'data/oficio.csv',       campoNumero: 'Oficio',   campoFiscal: 'Fiscalencaminha',  campoMotivo: 'Motivo',  campoPrazo: 'Prazo', campoAtendida: 'Archive',     campoCancelada: 'Cancela'   },
  { tipo: 'Denúncia',     arquivo: 'data/denuncia.csv',     campoNumero: 'Denuncia', campoFiscal: 'FiscalEncaminha',  campoMotivo: 'Objeto1', campoPrazo: 'Prazo', campoAtendida: 'Archive',     campoCancelada: null        },
];

// ── Parser CSV simples (sem dependências externas) ───────────
function parseCSV(conteudo) {
  const linhas = conteudo.split('\n').filter(l => l.trim());
  if (linhas.length < 2) return [];
  const primeiraLinha = linhas[0].replace(/^\uFEFF/, '');
  const cabecalho = primeiraLinha.split(';').map(c => c.replace(/^"|"$/g, '').trim());
  const registros = [];
  for (let i = 1; i < linhas.length; i++) {
    const linha = linhas[i];
    if (!linha.trim()) continue;
    const campos = [];
    let atual = '';
    let dentroAspas = false;
    for (let j = 0; j < linha.length; j++) {
      const c = linha[j];
      if (c === '"') { dentroAspas = !dentroAspas; }
      else if (c === ';' && !dentroAspas) { campos.push(atual.trim()); atual = ''; }
      else { atual += c; }
    }
    campos.push(atual.trim());
    const obj = {};
    cabecalho.forEach((col, idx) => { obj[col] = campos[idx] || ''; });
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

// ── Converte data para string YYYY-MM-DD ──────────────────────
function dataParaISO(dataStr) {
  const d = converterData(dataStr);
  if (!d) return '';
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  return `${y}-${m}-${day}`;
}

// ── Formata data ISO para DD/MM/YYYY ─────────────────────────
function formatarDataBR(isoStr) {
  if (!isoStr || isoStr.length < 10) return '—';
  const [y, m, d] = isoStr.split('-');
  return `${d}/${m}/${y}`;
}

// ── Converte hora AM/PM para 24h ─────────────────────────────
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
  if (periodo) { if (periodo === 'PM' && h !== 12) h += 12; if (periodo === 'AM' && h === 12) h = 0; }
  h = Math.min(Math.max(h, 0), 23);
  m = Math.min(Math.max(m, 0), 59);
  sec = Math.min(Math.max(sec, 0), 59);
  return `${String(h).padStart(2, '0')}:${String(m).padStart(2, '0')}:${String(sec).padStart(2, '0')}`;
}

// ── Adiciona N dias úteis a uma data ISO ──────────────────────
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
  return `${d}/${m}/${y}`;
}

// ── Calcula dias até a data (negativo = vencido) ──────────────
function calcularDiasAte(dataStr) {
  const data = converterData(dataStr);
  if (!data) return null;
  const hoje = new Date();
  hoje.setHours(0, 0, 0, 0);
  data.setHours(0, 0, 0, 0);
  return Math.floor((data - hoje) / (1000 * 60 * 60 * 24));
}

// ── Carrega e indexa regulados.csv por CODIGO ────────────────
function carregarRegulados() {
  const arq = path.join(ROOT, 'data', 'regulados.csv');
  if (!fs.existsSync(arq)) { console.warn('⚠️  regulados.csv não encontrado'); return {}; }
  const registros = parseCSV(fs.readFileSync(arq, 'utf8'));
  const idx = {};
  for (const r of registros) {
    const cod = (r['CODIGO'] || r['Codigo'] || '').trim();
    if (cod) idx[cod] = r;
  }
  console.log(`📦 regulados.csv: ${Object.keys(idx).length} registros indexados`);
  return idx;
}

// ── Carrega e indexa bairros.csv por CODIGO ──────────────────
function carregarBairros() {
  const arq = path.join(ROOT, 'data', 'bairros.csv');
  if (!fs.existsSync(arq)) { console.warn('⚠️  bairros.csv não encontrado'); return {}; }
  const registros = parseCSV(fs.readFileSync(arq, 'utf8'));
  const idx = {};
  for (const r of registros) {
    const cod = (r['CODIGO'] || r['Codigo'] || '').trim();
    if (cod) idx[cod] = r;
  }
  console.log(`📦 bairros.csv: ${Object.keys(idx).length} registros indexados`);
  return idx;
}

// ── Carrega e indexa cnae.csv por Subclasse ──────────────────
function carregarCnae() {
  const arq = path.join(ROOT, 'data', 'cnae.csv');
  if (!fs.existsSync(arq)) { console.warn('⚠️  cnae.csv não encontrado'); return {}; }
  const registros = parseCSV(fs.readFileSync(arq, 'utf8'));
  const idx = {};
  for (const r of registros) {
    const sub = (r['Subclasse'] || r['SUBCLASSE'] || r['subclasse'] || '').trim();
    if (sub) idx[sub] = r;
  }
  console.log(`📦 cnae.csv: ${Object.keys(idx).length} registros indexados`);
  return idx;
}

// ── Resolve nome do bairro a partir do código ────────────────
function nomeBairro(cdbai, idxBairros) {
  if (!cdbai || !idxBairros) return '';
  const b = idxBairros[String(cdbai).trim()];
  return b ? (b['NOME'] || b['Nome'] || '').trim() : '';
}

// ── Resolve descrição do CNAE a partir da subclasse ──────────
function descCnae(subclasse, idxCnae) {
  if (!subclasse || !idxCnae) return '';
  const c = idxCnae[String(subclasse).trim()];
  return c ? (c['Atividade'] || c['ATIVIDADE'] || c['atividade'] || c['Denominacao'] || c['DENOMINACAO'] || '').trim() : '';
}

// ── Carrega e indexa tramitações por protocolo ───────────────
function carregarTramitacoes() {
  const arq = path.join(ROOT, 'data', 'tramitacao.csv');
  if (!fs.existsSync(arq)) { console.warn('⚠️  tramitacao.csv não encontrado'); return {}; }
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
    const hora24  = converterHora12para24(t['HORA'] || '');
    return { ...t, _chave: dataISO + 'T' + hora24 };
  });
  comChave.sort((a, b) => (a._chave > b._chave ? 1 : a._chave < b._chave ? -1 : 0));
  for (let i = comChave.length - 1; i >= 0; i--) {
    const destino = (comChave[i]['DESTINO'] || '').trim();
    if (fiscalValido(destino)) {
      return { fiscal: destino, dataEncaminha: dataParaISO(comChave[i]['DATA'] || '') };
    }
  }
  return { fiscal: null, dataEncaminha: null };
}

// ── Lê todas as OSs e enriquece com dados do estabelecimento ──
function lerTodasOSs(idxReg, idxBai, idxCnae) {
  const todas = {};

  // ── Requerimento, Ofício, Denúncia ─────────────────────────
  for (const cfg of CSV_CONFIGS) {
    const caminhoArquivo = path.join(ROOT, cfg.arquivo);
    if (!fs.existsSync(caminhoArquivo)) { console.warn(`⚠️  Arquivo não encontrado: ${cfg.arquivo}`); continue; }
    const registros = parseCSV(fs.readFileSync(caminhoArquivo, 'utf8'));

    for (const r of registros) {
      const numero = (r[cfg.campoNumero] || '').trim();
      if (!numero) continue;
      const atendida  = cfg.campoAtendida  ? (r[cfg.campoAtendida]  || '').toLowerCase() === 'sim' : false;
      const cancelada = cfg.campoCancelada ? (r[cfg.campoCancelada] || '').toLowerCase() === 'sim' : false;
      if (atendida || cancelada) continue;

      const fiscal = (r[cfg.campoFiscal] || '').trim();

      // ─ Campos comuns ─────────────────────────────────────────
      let razao       = '';
      let fantasia    = '';
      let logradouro  = '';
      let complemento = '';
      let bairro      = '';
      let cnpj        = '';
      let cpf         = '';
      let complexidade = '';
      let cnaeCode    = '';
      let cnaeDesc    = '';
      let dataReq     = '';
      let descricao   = '';  // campo extra (Descrição da Denúncia)

      if (cfg.tipo === 'Requerimento') {
        // Razão social e demais vêm via regulados.csv
        const codReg = (r['Codigo'] || r['CODIGO'] || r['Cd_Regulado'] || r['CD_REGULADO'] || '').trim();
        const reg = codReg ? idxReg[codReg] : null;
        razao       = reg ? (reg['RAZAO']     || reg['Razao']     || '').trim() : '';
        fantasia    = reg ? (reg['FANTASIA']   || reg['Fantasia']  || '').trim() : '';
        logradouro  = reg ? (reg['LOGRADOURO'] || reg['Logradouro'] || '').trim() : '';
        complemento = reg ? (reg['COMPLEMENT'] || reg['Complement'] || '').trim() : '';
        cnpj        = reg ? (reg['CGC']        || reg['Cgc']       || '').trim() : '';
        cpf         = reg ? (reg['CPF']        || reg['Cpf']       || '').trim() : '';
        const cdbai = reg ? (reg['CDBAI']      || reg['Cdbai']     || '').trim() : '';
        bairro      = nomeBairro(cdbai, idxBai);
        complexidade = (r['Complexidade'] || '').trim();
        cnaeCode    = (r['Area'] || '').trim();
        cnaeDesc    = cnaeCode ? descCnae(cnaeCode, idxCnae) : '';
        dataReq     = dataParaISO(r['Dt_Req'] || '');

      } else if (cfg.tipo === 'Ofício') {
        // Razão social e fantasia vêm dos próprios campos do CSV
        razao       = (r['Regulado']    || '').trim();
        fantasia    = (r['Fantasia']    || '').trim();
        logradouro  = (r['Logradouro'] || '').trim();
        complemento = (r['Complemento'] || '').trim();
        cnpj        = (r['Cnpj']       || '').trim();
        cpf         = (r['Cpf']        || '').trim();
        const cdbai = (r['Cdbai']      || '').trim();
        bairro      = nomeBairro(cdbai, idxBai);
        // Ofício não tem Complexidade nem CNAE
        dataReq     = dataParaISO(r['Data'] || '');

      } else if (cfg.tipo === 'Denúncia') {
        // "Reclamado" é nome livre, não há ligação com regulados.csv
        razao       = (r['Reclamado']   || '').trim();
        // Denúncia não tem fantasia
        logradouro  = (r['Logradouro'] || '').trim();
        complemento = (r['Referencia'] || '').trim();
        cnpj        = (r['Cnpj']       || '').trim();
        cpf         = (r['Cpf']        || '').trim();
        const cdbai = (r['Cdbai']      || '').trim();
        bairro      = nomeBairro(cdbai, idxBai);
        descricao   = (r['Descricao']  || '').trim();
        dataReq     = dataParaISO(r['Data'] || '');
        // Denúncia não tem Complexidade nem CNAE descritivo
      }

      todas[numero] = {
        tipo:        cfg.tipo,
        fiscal,
        motivo:      (r[cfg.campoMotivo] || '').trim(),
        prazo:       cfg.campoPrazo ? (r[cfg.campoPrazo] || '').trim() : null,
        dataReq,
        razao,
        fantasia,
        logradouro,
        complemento,
        bairro,
        cnpj,
        cpf,
        complexidade,
        cnaeCode,
        cnaeDesc,
        descricao,
        atendida,
        cancelada
      };
    }
  }

  // ── Protocolo ────────────────────────────────────────────────
  const protocoloArq = path.join(ROOT, 'data', 'protocolo.csv');
  if (fs.existsSync(protocoloArq)) {
    const registrosProto = parseCSV(fs.readFileSync(protocoloArq, 'utf8'));
    const tramitacoes    = carregarTramitacoes();

    for (const r of registrosProto) {
      const numero = (r['Protocolo'] || '').trim();
      if (!numero) continue;
      const { fiscal, dataEncaminha } = buscarFiscalTramitacao(tramitacoes[numero]);
      if (!fiscal || !dataEncaminha) continue;
      const prazo = adicionarDiasUteis(dataEncaminha, 15);

      const codReg = (r['Codigo'] || r['CODIGO'] || r['Cd_Regulado'] || '').trim();
      const reg = codReg ? idxReg[codReg] : null;
      const razao       = reg ? (reg['RAZAO']     || reg['Razao']     || '').trim() : '';
      const fantasia    = reg ? (reg['FANTASIA']   || reg['Fantasia']  || '').trim() : '';
      const logradouro  = reg ? (reg['LOGRADOURO'] || reg['Logradouro'] || '').trim() : '';
      const complemento = reg ? (reg['COMPLEMENT'] || reg['Complement'] || '').trim() : '';
      const cnpj        = reg ? (reg['CGC']        || reg['Cgc']       || '').trim() : '';
      const cpf         = reg ? (reg['CPF']        || reg['Cpf']       || '').trim() : '';
      const cdbai       = reg ? (reg['CDBAI']      || reg['Cdbai']     || '').trim() : '';
      const bairro      = nomeBairro(cdbai, idxBai);
      const dataReq     = dataParaISO(r['Data'] || '');

      todas[numero] = {
        tipo:        'Protocolo',
        fiscal,
        motivo:      (r['Assunto']     || '').trim(),
        prazo,
        dataReq,
        dataEncaminha,        // data da última tramitação (usado no e-mail)
        observacao:  (r['Complemento'] || '').trim(),
        razao,
        fantasia,
        logradouro,
        complemento,
        bairro,
        cnpj,
        cpf,
        complexidade: '',
        cnaeCode:     '',
        cnaeDesc:     '',
        descricao:    '',
        atendida:     false,
        cancelada:    false
      };
    }
  } else {
    console.warn('⚠️  Arquivo não encontrado: data/protocolo.csv');
  }

  return todas;
}

// ── Carrega snapshot anterior ────────────────────────────────
function carregarSnapshot() {
  if (!fs.existsSync(SNAPSHOT_FILE)) { console.log('📋 Snapshot não encontrado — primeira execução.'); return null; }
  try { return JSON.parse(fs.readFileSync(SNAPSHOT_FILE, 'utf8')); }
  catch (e) { console.warn('⚠️  Erro ao ler snapshot:', e.message); return null; }
}

// ── Salva novo snapshot ──────────────────────────────────────
function salvarSnapshot(dados) {
  fs.writeFileSync(SNAPSHOT_FILE, JSON.stringify(dados, null, 2), 'utf8');
  console.log(`✅ Snapshot salvo: ${Object.keys(dados).length} OSs registradas.`);
}

// ── Busca dados dos usuários no Firestore ────────────────────
// Retorna: { "NOME FISCAL": { tokens: [...], email: "..." } }
async function buscarDadosFiscais() {
  const dadosPorFiscal = {};
  try {
    const snap = await db.collection('usuarios').get();
    snap.forEach(docSnap => {
      const data = docSnap.data();
      if (data.ativo === false || data.notificationOptIn === false) return;
      const nome = (data.nome || '').toUpperCase().trim();
      if (!nome) return;
      const fcmTokens    = (data.fcmTokens || []).filter(t => t && typeof t === 'string' && t.length > 20);
      const emailFiscal  = (data.email || '').trim();
      dadosPorFiscal[nome] = { tokens: fcmTokens, email: emailFiscal };
    });
  } catch (err) {
    console.error('❌ Erro ao buscar dados dos fiscais:', err.message);
  }
  const totalTokens = Object.values(dadosPorFiscal).reduce((s, v) => s + v.tokens.length, 0);
  console.log(`📱 ${totalTokens} token(s) FCM | ${Object.keys(dadosPorFiscal).length} fiscal(is) com opt-in.`);
  return dadosPorFiscal;
}

// ── Envia notificação FCM para um fiscal ─────────────────────
async function enviarNotificacaoFiscal(tokens, numero, tipo, motivo, diasParaPrazo) {
  if (!tokens || tokens.length === 0) return { enviados: 0, erros: 0 };
  let texto = '';
  if      (diasParaPrazo === 0)                          texto = `OS ${numero} — ${motivo}, VENCE HOJE`;
  else if (diasParaPrazo === 1)                          texto = `OS ${numero} — ${motivo}, prazo amanhã`;
  else if (diasParaPrazo >= 2 && diasParaPrazo <= 5)     texto = `OS ${numero} — ${motivo}, prazo ${diasParaPrazo} dias`;
  else return { enviados: 0, erros: 0 };

  const mensagem = {
    data: {
      title: '🔔 Alerta de Prazo — VISA Anápolis',
      body:  texto,
      url:   'https://garrado.github.io/VISA/index.html',
      tipo:  'prazo-alerta',
      osNum: numero
    },
    webpush: {
      headers: { Urgency: 'high' },
      fcmOptions: { link: 'https://garrado.github.io/VISA/index.html' }
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
      if (resp.failureCount > 0) {
        const invalidos = [];
        resp.responses.forEach((r, idx) => {
          if (!r.success) {
            const code = r.error?.code || '';
            if (code === 'messaging/registration-token-not-registered' || code === 'messaging/invalid-registration-token') invalidos.push(lote[idx]);
          }
        });
        if (invalidos.length > 0) await removerTokensInvalidos(invalidos);
      }
    } catch (err) {
      console.error(`❌ Erro ao enviar lote FCM:`, err.message);
      erros += lote.length;
    }
  }
  return { enviados, erros };
}

// ── Remove tokens FCM inválidos do Firestore ─────────────────
async function removerTokensInvalidos(tokensInvalidos) {
  try {
    const snap = await db.collection('usuarios').get();
    const batch = db.batch();
    let alteracoes = 0;
    snap.forEach(docSnap => {
      const data = docSnap.data();
      const tokens = data.fcmTokens || [];
      const filtrados = tokens.filter(t => !tokensInvalidos.includes(t));
      if (filtrados.length !== tokens.length) {
        const update = { fcmTokens: filtrados };
        const dispositivos = data.dispositivos || {};
        for (const chave of Object.keys(dispositivos)) {
          if (tokensInvalidos.includes(dispositivos[chave]?.fcmToken)) update[`dispositivos.${chave}.fcmToken`] = null;
        }
        batch.update(docSnap.ref, update);
        alteracoes++;
      }
    });
    if (alteracoes > 0) { await batch.commit(); console.log(`🧹 ${tokensInvalidos.length} token(s) removido(s) de ${alteracoes} usuário(s).`); }
  } catch (err) { console.warn('⚠️  Erro ao remover tokens:', err.message); }
}

// ────────────────────────────────────────────────────────────
// ── Geração do e-mail HTML rico ──────────────────────────────
// ────────────────────────────────────────────────────────────

/**
 * Retorna o emoji/cor/label de acordo com os dias para o prazo.
 */
function labelPrazo(dias) {
  if (dias === 0)              return { emoji: '🔴', label: 'VENCE HOJE',      cor: '#c0392b', bgCor: '#fdecea' };
  if (dias === 1)              return { emoji: '🟠', label: 'VENCE AMANHÃ',    cor: '#e67e22', bgCor: '#fef3e2' };
  if (dias >= 2 && dias <= 4) return { emoji: '⚠️',  label: `${dias} DIAS`,    cor: '#d4a000', bgCor: '#fffbea' };
  if (dias === 5)              return { emoji: '🔵', label: '5 DIAS',           cor: '#2980b9', bgCor: '#eaf4fb' };
  return                              { emoji: '📅', label: `${dias} DIAS`,    cor: '#555',    bgCor: '#f5f5f5' };
}

/**
 * Gera uma linha de detalhe no card da OS.
 * Se `valor` for vazio, não renderiza a linha (evita linhas "—" desnecessárias).
 */
function linhaDetalhe(icone, label, valor, destaque = false) {
  if (!valor || valor.trim() === '') return '';
  const corValor  = destaque ? '#c0392b' : '#1a1a2e';
  const fontWeight = destaque ? '700' : '400';
  return `
    <tr>
      <td style="padding:5px 10px 5px 0;color:#666;font-size:13px;white-space:nowrap;vertical-align:top;">
        ${icone} <strong>${label}</strong>
      </td>
      <td style="padding:5px 0;color:${corValor};font-size:13px;font-weight:${fontWeight};vertical-align:top;">
        ${valor}
      </td>
    </tr>`;
}

/**
 * Monta o bloco HTML de um único card de OS.
 * Cada tipo tem suas particularidades:
 *   Requerimento → todos os campos
 *   Ofício       → sem Complexidade, sem CNAE
 *   Denúncia     → sem Fantasia, sem Complexidade, sem CNAE descritivo; tem Descrição
 *   Protocolo    → sem Complexidade, sem CNAE; tem Data Tramitação e Prazo calculado
 */
function htmlCardOS(os, numero, dias) {
  const { emoji, label, cor, bgCor } = labelPrazo(dias);

  // ── Badge do tipo ─────────────────────────────────────────
  const coresTipo = {
    'Requerimento': { bg: '#2980b9', fg: '#fff' },
    'Ofício':       { bg: '#27ae60', fg: '#fff' },
    'Denúncia':     { bg: '#c0392b', fg: '#fff' },
    'Protocolo':    { bg: '#8e44ad', fg: '#fff' }
  };
  const ct = coresTipo[os.tipo] || { bg: '#555', fg: '#fff' };

  // ── Montar endereço completo ──────────────────────────────
  const endPartes = [os.logradouro, os.complemento].filter(Boolean);
  const endCompleto = endPartes.join(', ');

  // ── CNAE para Requerimento ────────────────────────────────
  const cnaeTexto = os.cnaeCode
    ? `${os.cnaeCode}${os.cnaeDesc ? ' – ' + os.cnaeDesc : ''}`
    : '';

  // ── Google Maps link ──────────────────────────────────────
  const mapsQuery = [endCompleto, os.bairro, 'Anápolis GO'].filter(Boolean).join(', ');
  const mapsLink  = mapsQuery
    ? `https://www.google.com/maps/dir/?api=1&destination=${encodeURIComponent(mapsQuery)}&travelmode=driving`
    : '';

  // ── Prazo formatado ───────────────────────────────────────
  const prazoFormatado = os.prazo ? (os.prazo.includes('/') ? os.prazo : formatarDataBR(os.prazo)) : '—';

  // ── Nota específica por tipo ──────────────────────────────
  let notaTipo = '';
  if (os.tipo === 'Protocolo') {
    notaTipo = `<tr><td colspan="2" style="padding:4px 0;font-size:11px;color:#888;">
      ℹ️ Prazo calculado: data da última tramitação + 15 dias úteis
      ${os.dataEncaminha ? `(tram. em ${formatarDataBR(os.dataEncaminha)})` : ''}
    </td></tr>`;
  } else if (os.tipo === 'Denúncia') {
    notaTipo = `<tr><td colspan="2" style="padding:4px 0;font-size:11px;color:#888;">
      ℹ️ Denúncia: dados do reclamado conforme cadastro da ocorrência (sem vínculo com regulados)
    </td></tr>`;
  }

  return `
  <!-- ═══ OS ${numero} ═══ -->
  <table width="100%" cellpadding="0" cellspacing="0" style="
      margin-bottom:20px;
      border-radius:10px;
      border:1px solid #ddd;
      border-left:5px solid ${cor};
      background:#fff;
      box-shadow:0 2px 6px rgba(0,0,0,0.06);
      font-family:Arial,sans-serif;
    ">
    <!-- Cabeçalho do card -->
    <tr>
      <td style="padding:14px 16px;background:${bgCor};border-radius:9px 9px 0 0;">
        <table width="100%" cellpadding="0" cellspacing="0">
          <tr>
            <td>
              <span style="font-size:17px;font-weight:700;color:${cor};">
                ${emoji} OS ${numero}
              </span>
              &nbsp;
              <span style="
                display:inline-block;padding:3px 10px;border-radius:20px;
                background:${ct.bg};color:${ct.fg};font-size:12px;font-weight:700;">
                ${os.tipo}
              </span>
            </td>
            <td align="right">
              <span style="
                display:inline-block;padding:4px 14px;border-radius:20px;
                background:${cor};color:#fff;font-size:13px;font-weight:700;">
                ${emoji} ${label}
              </span>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <!-- Corpo do card -->
    <tr>
      <td style="padding:14px 16px;">
        <table cellpadding="0" cellspacing="0" style="width:100%;border-collapse:collapse;">
          ${linhaDetalhe('🏢', 'Razão Social',    os.razao       || os.reclamado || '')}
          ${os.tipo !== 'Denúncia' ? linhaDetalhe('🪟', 'Nome Fantasia', os.fantasia || '') : ''}
          ${os.tipo === 'Requerimento' && os.complexidade ? linhaDetalhe('⚙️',  'Complexidade',  os.complexidade) : ''}
          ${cnaeTexto ? linhaDetalhe('🏷️', 'CNAE', cnaeTexto) : ''}
          ${linhaDetalhe('📍', 'Endereço',        endCompleto)}
          ${linhaDetalhe('🏘️', 'Bairro',          os.bairro || '')}
          ${mapsLink  ? `<tr><td style="padding:5px 10px 5px 0;font-size:13px;white-space:nowrap;vertical-align:top;color:#666;">📡 <strong>Rota</strong></td><td style="padding:5px 0;font-size:13px;vertical-align:top;"><a href="${mapsLink}" style="color:#1a73e8;text-decoration:none;font-weight:600;">🧭 Traçar rota no Google Maps</a></td></tr>` : ''}
          ${linhaDetalhe('📋', 'Motivo / Assunto', os.motivo || '')}
          ${os.tipo === 'Denúncia' && os.descricao ? linhaDetalhe('📝', 'Descrição', os.descricao) : ''}
          ${os.tipo === 'Protocolo' && os.observacao ? linhaDetalhe('📝', 'Complemento', os.observacao) : ''}
          ${linhaDetalhe('📅', 'Data Abertura',   os.dataReq ? formatarDataBR(os.dataReq) : '')}
          ${linhaDetalhe('⏰', 'Prazo Final',      prazoFormatado, true)}
          ${notaTipo}
        </table>
      </td>
    </tr>
  </table>`;
}

/**
 * Gera o corpo HTML completo do e-mail para um fiscal,
 * recebendo um array de { os, numero, dias }.
 */
function gerarEmailHTML(nomeFiscal, alertasFiscal) {
  const hoje    = new Date().toLocaleDateString('pt-BR', { timeZone: 'America/Sao_Paulo', weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
  const qtd     = alertasFiscal.length;
  const temHoje = alertasFiscal.some(a => a.dias === 0);
  const corHeader = temHoje ? '#c0392b' : '#1a3a6b';

  // Ordena: vence hoje → amanhã → menor prazo
  alertasFiscal.sort((a, b) => a.dias - b.dias);

  const cardsHTML = alertasFiscal.map(a => htmlCardOS(a.os, a.numero, a.dias)).join('');

  // Nome formatado (Title Case)
  const nomeFormatado = nomeFiscal.split(' ').map(p => p.charAt(0).toUpperCase() + p.slice(1).toLowerCase()).join(' ');

  return `<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>Alerta de Prazo — VISA Anápolis</title>
</head>
<body style="margin:0;padding:0;background:#f0f2f5;font-family:Arial,Helvetica,sans-serif;">

  <!-- Wrapper -->
  <table width="100%" cellpadding="0" cellspacing="0" style="background:#f0f2f5;padding:30px 10px;">
    <tr><td align="center">

      <!-- Container principal -->
      <table width="640" cellpadding="0" cellspacing="0" style="max-width:640px;width:100%;">

        <!-- ══ CABEÇALHO ══ -->
        <tr>
          <td style="
              background:${corHeader};
              padding:28px 32px;
              border-radius:12px 12px 0 0;
            ">
            <table width="100%" cellpadding="0" cellspacing="0">
              <tr>
                <td>
                  <div style="font-size:22px;font-weight:700;color:#fff;margin-bottom:6px;">
                    ⚠️ Alerta de Prazo — VISA Anápolis
                  </div>
                  <div style="font-size:13px;color:rgba(255,255,255,0.80);">
                    Gerência de Vigilância Sanitária · Anápolis – GO
                  </div>
                </td>
                <td align="right" valign="middle">
                  <span style="
                    display:inline-block;
                    background:rgba(255,255,255,0.18);
                    color:#fff;
                    padding:8px 16px;
                    border-radius:20px;
                    font-size:13px;
                    font-weight:700;
                  ">${qtd} OS${qtd > 1 ? 's' : ''}</span>
                </td>
              </tr>
            </table>
          </td>
        </tr>

        <!-- ══ CORPO ══ -->
        <tr>
          <td style="background:#fff;padding:28px 32px;">

            <!-- Saudação -->
            <p style="margin:0 0 6px 0;font-size:16px;color:#1a1a2e;font-weight:700;">
              Prezado(a) ${nomeFormatado},
            </p>
            <p style="margin:0 0 20px 0;font-size:14px;color:#555;line-height:1.6;">
              Você possui <strong>${qtd} Ordem${qtd > 1 ? 'ns' : ''} de Serviço</strong> com prazo de
              vencimento se aproximando. Verifique cada OS abaixo e tome as providências
              cabíveis no sistema CVS dentro do prazo legal.
            </p>

            <!-- Data -->
            <p style="margin:0 0 24px 0;font-size:12px;color:#888;">
              📅 ${hoje.charAt(0).toUpperCase() + hoje.slice(1)}
            </p>

            <!-- Cards das OSs -->
            ${cardsHTML}

            <!-- Botão de acesso ao sistema -->
            <table width="100%" cellpadding="0" cellspacing="0" style="margin-top:10px;">
              <tr>
                <td align="center">
                  <a href="https://garrado.github.io/VISA/os.html"
                     style="
                       display:inline-block;
                       background:#1a3a6b;
                       color:#fff;
                       text-decoration:none;
                       padding:14px 36px;
                       border-radius:8px;
                       font-size:15px;
                       font-weight:700;
                       margin-top:8px;
                     ">
                    📋 Abrir Consulta de OS
                  </a>
                </td>
              </tr>
            </table>

          </td>
        </tr>

        <!-- ══ RODAPÉ ══ -->
        <tr>
          <td style="
              background:#1a3a6b;
              padding:18px 32px;
              border-radius:0 0 12px 12px;
              text-align:center;
            ">
            <p style="margin:0 0 4px 0;font-size:12px;color:rgba(255,255,255,0.7);">
              Mensagem automática — Sistema VISA · Gerência de Vigilância Sanitária de Anápolis
            </p>
            <p style="margin:0;font-size:11px;color:rgba(255,255,255,0.5);">
              Não responda este e-mail. Para dúvidas, entre em contato com a chefia administrativa.
            </p>
          </td>
        </tr>

      </table>
    </td></tr>
  </table>

</body>
</html>`;
}

// ── Envia e-mail para um fiscal ──────────────────────────────
async function enviarEmail(emailDestino, nomeFiscal, alertasFiscal) {
  if (!EMAIL_ENABLED) {
    console.log(`📧 [E-mail desabilitado] Destinatário: ${emailDestino} | ${alertasFiscal.length} OS(s)`);
    return;
  }
  if (!emailDestino) {
    console.warn(`⚠️  Fiscal "${nomeFiscal}" sem e-mail cadastrado no Firestore — pulando envio`);
    return;
  }

  const temHoje = alertasFiscal.some(a => a.dias === 0);
  const temAmanha = alertasFiscal.some(a => a.dias === 1);
  let assunto = '';
  if (temHoje)       assunto = `🔴 VENCE HOJE — ${alertasFiscal.length} OS(s) | VISA Anápolis`;
  else if (temAmanha) assunto = `🟠 VENCE AMANHÃ — ${alertasFiscal.length} OS(s) | VISA Anápolis`;
  else                assunto = `⚠️ ${alertasFiscal.length} OS(s) com prazo vencendo | VISA Anápolis`;

  const html = gerarEmailHTML(nomeFiscal, alertasFiscal);

  try {
    await transporter.sendMail({
      from:    EMAIL_FROM,
      to:      emailDestino,
      subject: assunto,
      html
    });
    console.log(`📧 E-mail enviado para ${nomeFiscal} <${emailDestino}> — ${alertasFiscal.length} OS(s)`);
  } catch (err) {
    console.error(`❌ Falha ao enviar e-mail para ${emailDestino}:`, err.message);
  }
}

// ── Função principal ─────────────────────────────────────────
async function main() {
  console.log('🚀 VISA Notifier — verificando prazos...');
  const agora = new Date().toLocaleString('pt-BR', { timeZone: 'America/Sao_Paulo' });
  console.log(`📅 ${agora}`);

  // 1. Carrega tabelas auxiliares
  const idxReg = carregarRegulados();
  const idxBai = carregarBairros();
  const idxCnae = carregarCnae();

  // 2. Lê e enriquece todas as OSs
  const osAtuais = lerTodasOSs(idxReg, idxBai, idxCnae);
  console.log(`📊 Total de OSs nos CSVs: ${Object.keys(osAtuais).length}`);

  // 3. Carrega snapshot anterior
  const snapshot = carregarSnapshot();
  if (!snapshot) {
    salvarSnapshot(osAtuais);
    console.log('ℹ️  Primeira execução: baseline criado.');
    process.exit(0);
  }

  // 4. Busca tokens FCM e e-mails por fiscal
  const dadosFiscais = await buscarDadosFiscais();

  // 5. Detecta OSs nos gatilhos de prazo e agrupa por fiscal
  const alertas     = { VENCE_HOJE: 0, PRAZO_5D: 0, RECUPERACAO: 0, AMANHA: 0 };
  const novoSnapshot = {};

  // alertasPorFiscal: { "NOME FISCAL": [ { os, numero, dias }, ... ] }
  const alertasPorFiscal = {};

  let totalEnviadosFCM = 0, totalErrosFCM = 0;

  for (const [numero, osAtual] of Object.entries(osAtuais)) {
    const osAnterior     = snapshot[numero] || {};
    const diasParaPrazo  = osAtual.prazo ? calcularDiasAte(osAtual.prazo) : null;

    novoSnapshot[numero] = {
      ...osAtual,
      notif_5d:          osAnterior.notif_5d          || false,
      notif_recuperacao: osAnterior.notif_recuperacao || false,
      notif_amanha:      osAnterior.notif_amanha      || false,
      notif_hoje:        osAnterior.notif_hoje        || false
    };

    if (diasParaPrazo === null || !osAtual.fiscal) continue;

    const fiscalUpper = osAtual.fiscal.toUpperCase().trim();
    const fiscalInfo  = dadosFiscais[fiscalUpper] || { tokens: [], email: '' };
    const tokens      = fiscalInfo.tokens;

    // Determina se esta OS entra em algum gatilho
    let disparar = false;
    let gatilho  = '';

    if (diasParaPrazo === 0 && !osAnterior.notif_hoje) {
      disparar = true; gatilho = 'VENCE_HOJE'; alertas.VENCE_HOJE++;
    } else if (diasParaPrazo === 5 && !osAnterior.notif_5d) {
      disparar = true; gatilho = 'PRAZO_5D'; alertas.PRAZO_5D++;
    } else if (diasParaPrazo >= 2 && diasParaPrazo <= 4 && !osAnterior.notif_5d && !osAnterior.notif_recuperacao) {
      disparar = true; gatilho = 'RECUPERACAO'; alertas.RECUPERACAO++;
    } else if (diasParaPrazo === 1 && !osAnterior.notif_amanha) {
      disparar = true; gatilho = 'AMANHA'; alertas.AMANHA++;
    }

    if (!disparar) continue;

    // ── Envia notificação FCM individual (push curto) ─────────
    if (tokens.length === 0) {
      console.log(`⚠️  [${gatilho}] OS ${numero}: sem token FCM para "${osAtual.fiscal}"`);
    } else {
      const { enviados, erros } = await enviarNotificacaoFiscal(tokens, numero, osAtual.tipo, osAtual.motivo, diasParaPrazo);
      totalEnviadosFCM += enviados;
      totalErrosFCM    += erros;
      if (enviados > 0) {
        console.log(`✅ FCM [${gatilho}] OS ${numero}: ${enviados} push → "${osAtual.fiscal}"`);
      }
    }

    // ── Atualiza flag no snapshot ─────────────────────────────
    if (gatilho === 'VENCE_HOJE')   novoSnapshot[numero].notif_hoje        = true;
    if (gatilho === 'PRAZO_5D')     novoSnapshot[numero].notif_5d          = true;
    if (gatilho === 'RECUPERACAO')  novoSnapshot[numero].notif_recuperacao = true;
    if (gatilho === 'AMANHA')       novoSnapshot[numero].notif_amanha      = true;

    // ── Acumula para o e-mail rico consolidado ────────────────
    if (!alertasPorFiscal[fiscalUpper]) alertasPorFiscal[fiscalUpper] = [];
    alertasPorFiscal[fiscalUpper].push({ os: osAtual, numero, dias: diasParaPrazo });
  }

  // 6. Envia e-mail HTML consolidado por fiscal
  console.log(`\n📧 Enviando e-mails para ${Object.keys(alertasPorFiscal).length} fiscal(is)...`);
  for (const [fiscalUpper, listaOS] of Object.entries(alertasPorFiscal)) {
    const emailFiscal = (dadosFiscais[fiscalUpper] || {}).email || '';
    await enviarEmail(emailFiscal, fiscalUpper, listaOS);
  }

  // 7. Log dos resultados
  const totalAlertas = alertas.VENCE_HOJE + alertas.PRAZO_5D + alertas.RECUPERACAO + alertas.AMANHA;
  console.log(`\n🔔 Alertas detectados: ${totalAlertas}`);
  console.log(`   VENCE_HOJE:  ${alertas.VENCE_HOJE}`);
  console.log(`   AMANHA:      ${alertas.AMANHA}`);
  console.log(`   RECUPERACAO: ${alertas.RECUPERACAO}`);
  console.log(`   PRAZO_5D:    ${alertas.PRAZO_5D}`);
  console.log(`📤 FCM: ${totalEnviadosFCM} enviado(s), ${totalErrosFCM} erro(s).`);

  // 8. Salva novo snapshot
  salvarSnapshot(novoSnapshot);
  console.log('✅ Processo concluído.');
  process.exit(0);
}

main().catch(err => {
  console.error('❌ Erro fatal:', err);
  process.exit(1);
});
