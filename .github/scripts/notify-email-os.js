// ============================================================
// notify-email-os.js  —  GitHub Actions Script
// Detecta OSs com prazo vencendo e envia notificações por E-MAIL
// rico (dados do regulado, endereço, bairro, CNAE, Google Maps)
//
// Lógica:
//   1. Lê os 5 CSVs de OS (requerimento, oficio, denuncia, protocolo, tramitacao)
//   2. Enriquece com regulados.csv, bairros.csv e cnae.csv
//   3. Compara com o snapshot anterior (data/os_snapshot.json)
//   4. Gatilhos: VENCE_HOJE(0d), AMANHA(1d), RECUPERACAO(2-4d), PRAZO_5D(5d)
//   5. Agrupa OSs por fiscal e envia e-mail HTML consolidado via SMTP Gmail
//   6. Atualiza flags email_notif_* no snapshot (independentes do FCM)
// ============================================================

const fs         = require('fs');
const path       = require('path');
const admin      = require('firebase-admin');
const nodemailer = require('nodemailer');

// ── Inicialização Firebase ───────────────────────────────────
const serviceAccountPath = process.env.FIREBASE_SERVICE_ACCOUNT_PATH
  || path.join(__dirname, 'service-account.json');
const serviceAccount = JSON.parse(fs.readFileSync(serviceAccountPath, 'utf8'));
admin.initializeApp({ credential: admin.credential.cert(serviceAccount) });
const db = admin.firestore();

// ── Configurações SMTP ─────────────────────────────────────
const SMTP_USER = process.env.SMTP_USER;
const SMTP_PASS = process.env.SMTP_PASSWORD;

// ── Caminhos ─────────────────────────────────────────────
const ROOT          = path.join(__dirname, '..', '..');
const SNAPSHOT_FILE = path.join(ROOT, 'data', 'os_snapshot.json');

// ── Lista oficial de fiscais ───────────────────────────────
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
  FISCAIS_OFICIAIS.map(f =>
    f.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toUpperCase().trim()
  )
);

function fiscalValido(nome) {
  if (!nome || nome.trim() === '') return false;
  return FISCAIS_NORM.has(
    nome.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toUpperCase().trim()
  );
}

// ── Mapeamento CSVs ─────────────────────────────────────────
const CSV_CONFIGS = [
  { tipo: 'Requerimento', arquivo: 'data/requerimento.csv', campoNumero: 'OS',       campoFiscal: 'Fiscal_Encaminha', campoMotivo: 'Motivo',  campoPrazo: 'Prazo', campoAtendida: 'Atendimento', campoCancelada: 'Cancelado' },
  { tipo: 'Ofício',       arquivo: 'data/oficio.csv',       campoNumero: 'Oficio',   campoFiscal: 'Fiscalencaminha',  campoMotivo: 'Motivo',  campoPrazo: 'Prazo', campoAtendida: 'Archive',     campoCancelada: 'Cancela'   },
  { tipo: 'Denúncia',     arquivo: 'data/denuncia.csv',     campoNumero: 'Denuncia', campoFiscal: 'FiscalEncaminha',  campoMotivo: 'Objeto1', campoPrazo: 'Prazo', campoAtendida: 'Archive',     campoCancelada: null        },
];

// ── Parser CSV ──────────────────────────────────────────────
function parseCSV(conteudo) {
  const linhas = conteudo.split('\n').filter(l => l.trim());
  if (linhas.length < 2) return [];
  const cabecalho = linhas[0].replace(/^\uFEFF/, '').split(';').map(c => c.replace(/^"|"$/g, '').trim());
  const registros = [];
  for (let i = 1; i < linhas.length; i++) {
    if (!linhas[i].trim()) continue;
    const campos = [];
    let atual = '', dentroAspas = false;
    for (const c of linhas[i]) {
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

// ── Interpreta campo booleano (aceita True/False inglês e Sim/Não português) ──
function parseBool(valor) {
  if (!valor) return false;
  const v = String(valor).trim().toLowerCase();
  return v === 'true' || v === 'sim' || v === 't' || v === 's' || v === '1';
}

function converterData(dataStr) {
  if (!dataStr) return null;
  const m = dataStr.match(/(\d{1,2})[./](\d{1,2})[./](\d{4})/);
  if (!m) return null;
  return new Date(parseInt(m[3]), parseInt(m[2]) - 1, parseInt(m[1]));
}

function dataParaISO(dataStr) {
  const d = converterData(dataStr);
  if (!d) return '';
  return `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')}`;
}

function formatarDataBR(isoStr) {
  if (!isoStr || isoStr.length < 10) return '—';
  const [y, m, d] = isoStr.split('-');
  return `${d}/${m}/${y}`;
}

/**
 * Normaliza qualquer formato de data para exibição DD/MM/YYYY.
 * Aceita: DD/MM/YYYY, DD.MM.YYYY (BR) ou YYYY-MM-DD (ISO).
 */
function normalizarPrazoExibicao(prazo) {
  if (!prazo || prazo.trim() === '') return '—';
  // Já está em formato BR com barras: DD/MM/YYYY
  if (/^\d{1,2}\/\d{1,2}\/\d{4}$/.test(prazo.trim())) return prazo.trim();
  // Formato BR com pontos: DD.MM.YYYY → DD/MM/YYYY
  if (/^\d{1,2}\.\d{1,2}\.\d{4}$/.test(prazo.trim())) return prazo.trim().replace(/\./g, '/');
  // Formato ISO: YYYY-MM-DD → DD/MM/YYYY
  if (/^\d{4}-\d{2}-\d{2}$/.test(prazo.trim())) return formatarDataBR(prazo.trim());
  // Fallback: tenta converter via converterData
  const d = converterData(prazo);
  if (d) return `${String(d.getDate()).padStart(2,'0')}/${String(d.getMonth()+1).padStart(2,'0')}/${d.getFullYear()}`;
  return prazo; // retorna como veio se não reconhecer
}

function converterHora12para24(horaStr) {
  if (!horaStr || !horaStr.trim()) return '00:00:00';
  let s = horaStr.trim().toUpperCase().replace(/\./g, ':');
  const per = (s.match(/\b(AM|PM)\b/) || [])[1];
  s = s.replace(/\b(AM|PM)\b/g, '').trim();
  const p = s.split(':').map(x => parseInt(x, 10));
  if (p.length < 2 || p.some(isNaN)) return '00:00:00';
  let [h, m, sec = 0] = p;
  if (per === 'PM' && h !== 12) h += 12;
  if (per === 'AM' && h === 12) h = 0;
  return `${String(h).padStart(2,'0')}:${String(m).padStart(2,'0')}:${String(sec).padStart(2,'0')}`;
}

function adicionarDiasUteis(dataISO, dias) {
  if (!dataISO) return null;
  const d = new Date(dataISO + 'T00:00:00');
  let add = 0;
  while (add < dias) {
    d.setDate(d.getDate() + 1);
    if (d.getDay() !== 0 && d.getDay() !== 6) add++;
  }
  return `${String(d.getDate()).padStart(2,'0')}/${String(d.getMonth()+1).padStart(2,'0')}/${d.getFullYear()}`;
}

function calcularDiasAte(dataStr) {
  const data = converterData(dataStr);
  if (!data) return null;
  const hoje = new Date(); hoje.setHours(0,0,0,0); data.setHours(0,0,0,0);
  return Math.floor((data - hoje) / 86400000);
}

// ── Carrega tabelas auxiliares ───────────────────────────────
function carregarCSVIndexado(nomeArq, campoCodigo) {
  const arq = path.join(ROOT, 'data', nomeArq);
  if (!fs.existsSync(arq)) { console.warn(`⚠️  ${nomeArq} não encontrado`); return {}; }
  const registros = parseCSV(fs.readFileSync(arq, 'utf8'));
  const idx = {};
  for (const r of registros) {
    const cod = (r[campoCodigo] || '').trim();
    if (cod) idx[cod] = r;
  }
  console.log(`📦 ${nomeArq}: ${Object.keys(idx).length} registros indexados`);
  return idx;
}

function nomeBairro(cdbai, idxBai) {
  if (!cdbai || !idxBai) return '';
  const b = idxBai[String(cdbai).trim()];
  return b ? (b['NOME'] || b['Nome'] || '').trim() : '';
}

function descCnae(subclasse, idxCnae) {
  if (!subclasse || !idxCnae) return '';
  const c = idxCnae[String(subclasse).trim()];
  return c ? (c['Atividade'] || c['ATIVIDADE'] || c['atividade'] || c['Denominacao'] || c['DENOMINACAO'] || '').trim() : '';
}

// ── Tramitações ───────────────────────────────────────────────
function carregarTramitacoes() {
  const arq = path.join(ROOT, 'data', 'tramitacao.csv');
  if (!fs.existsSync(arq)) { console.warn('⚠️  tramitacao.csv não encontrado'); return {}; }
  const mapa = {};
  for (const r of parseCSV(fs.readFileSync(arq, 'utf8'))) {
    const proto = (r['PROTOCOLO'] || '').trim();
    if (!proto) continue;
    if (!mapa[proto]) mapa[proto] = [];
    mapa[proto].push(r);
  }
  return mapa;
}

function buscarFiscalTramitacao(trams) {
  if (!trams || !trams.length) return { fiscal: null, dataEncaminha: null };
  const sorted = trams
    .map(t => ({ ...t, _k: dataParaISO(t['DATA']||'') + 'T' + converterHora12para24(t['HORA']||'') }))
    .sort((a, b) => a._k > b._k ? 1 : -1);
  for (let i = sorted.length - 1; i >= 0; i--) {
    const dest = (sorted[i]['DESTINO'] || '').trim();
    if (fiscalValido(dest))
      return { fiscal: dest, dataEncaminha: dataParaISO(sorted[i]['DATA'] || '') };
  }
  return { fiscal: null, dataEncaminha: null };
}

// ── Lê todas as OSs com dados enriquecidos ─────────────────────
function lerTodasOSs(idxReg, idxBai, idxCnae) {
  const todas = {};

  for (const cfg of CSV_CONFIGS) {
    const arq = path.join(ROOT, cfg.arquivo);
    if (!fs.existsSync(arq)) { console.warn(`⚠️  Não encontrado: ${cfg.arquivo}`); continue; }
    for (const r of parseCSV(fs.readFileSync(arq, 'utf8'))) {
      const num = (r[cfg.campoNumero] || '').trim(); if (!num) continue;
      if (parseBool(r[cfg.campoAtendida]))  continue;
      if (cfg.campoCancelada && parseBool(r[cfg.campoCancelada])) continue;

      const fiscal = (r[cfg.campoFiscal] || '').trim();
      let razao = '', fantasia = '', logradouro = '', complemento = '',
          bairro = '', cnpj = '', cpf = '', complexidade = '',
          cnaeCode = '', cnaeDesc = '', dataReq = '', descricao = '';

      if (cfg.tipo === 'Requerimento') {
        const codReg = (r['Codigo'] || r['CODIGO'] || r['Cd_Regulado'] || r['CD_REGULADO'] || '').trim();
        const reg    = codReg ? idxReg[codReg] : null;
        razao       = reg ? (reg['RAZAO']     || reg['Razao']      || '').trim() : '';
        fantasia    = reg ? (reg['FANTASIA']   || reg['Fantasia']   || '').trim() : '';
        logradouro  = reg ? (reg['LOGRADOURO'] || reg['Logradouro'] || '').trim() : '';
        complemento = reg ? (reg['COMPLEMENT'] || reg['Complement'] || '').trim() : '';
        cnpj        = reg ? (reg['CGC']        || reg['Cgc']        || '').trim() : '';
        cpf         = reg ? (reg['CPF']        || reg['Cpf']        || '').trim() : '';
        bairro      = nomeBairro(reg ? (reg['CDBAI'] || reg['Cdbai'] || '') : '', idxBai);
        complexidade = (r['Complexidade'] || '').trim();
        cnaeCode    = (r['Area'] || '').trim();
        cnaeDesc    = cnaeCode ? descCnae(cnaeCode, idxCnae) : '';
        dataReq     = dataParaISO(r['Dt_Req'] || '');

      } else if (cfg.tipo === 'Ofício') {
        razao       = (r['Regulado']    || '').trim();
        fantasia    = (r['Fantasia']    || '').trim();
        logradouro  = (r['Logradouro'] || '').trim();
        complemento = (r['Complemento'] || '').trim();
        cnpj        = (r['Cnpj']       || '').trim();
        cpf         = (r['Cpf']        || '').trim();
        bairro      = nomeBairro((r['Cdbai'] || '').trim(), idxBai);
        dataReq     = dataParaISO(r['Data'] || '');

      } else if (cfg.tipo === 'Denúncia') {
        razao       = (r['Reclamado']   || '').trim();
        logradouro  = (r['Logradouro'] || '').trim();
        complemento = (r['Referencia'] || '').trim();
        cnpj        = (r['Cnpj']       || '').trim();
        cpf         = (r['Cpf']        || '').trim();
        bairro      = nomeBairro((r['Cdbai'] || '').trim(), idxBai);
        descricao   = (r['Descricao']  || '').trim();
        dataReq     = dataParaISO(r['Data'] || '');
      }

      todas[num] = {
        tipo: cfg.tipo, fiscal, motivo: (r[cfg.campoMotivo] || '').trim(),
        prazo: (r[cfg.campoPrazo] || '').trim(), dataReq,
        razao, fantasia, logradouro, complemento, bairro,
        cnpj, cpf, complexidade, cnaeCode, cnaeDesc, descricao
      };
    }
  }

  // Protocolo
  const arqP = path.join(ROOT, 'data', 'protocolo.csv');
  if (fs.existsSync(arqP)) {
    const trams = carregarTramitacoes();
    for (const r of parseCSV(fs.readFileSync(arqP, 'utf8'))) {
      const num = (r['Protocolo'] || '').trim(); if (!num) continue;
      const { fiscal, dataEncaminha } = buscarFiscalTramitacao(trams[num]);
      if (!fiscal || !dataEncaminha) continue;
      const prazo   = adicionarDiasUteis(dataEncaminha, 15);
      const codReg  = (r['Codigo'] || r['CODIGO'] || r['Cd_Regulado'] || '').trim();
      const reg     = codReg ? idxReg[codReg] : null;
      const dataReq = dataParaISO(r['Data'] || '');
      todas[num] = {
        tipo: 'Protocolo', fiscal, motivo: (r['Assunto'] || '').trim(),
        prazo, dataReq, dataEncaminha,
        observacao:  (r['Complemento'] || '').trim(),
        razao:       reg ? (reg['RAZAO']     || reg['Razao']      || '').trim() : '',
        fantasia:    reg ? (reg['FANTASIA']   || reg['Fantasia']   || '').trim() : '',
        logradouro:  reg ? (reg['LOGRADOURO'] || reg['Logradouro'] || '').trim() : '',
        complemento: reg ? (reg['COMPLEMENT'] || reg['Complement'] || '').trim() : '',
        cnpj:        reg ? (reg['CGC']        || reg['Cgc']        || '').trim() : '',
        cpf:         reg ? (reg['CPF']        || reg['Cpf']        || '').trim() : '',
        bairro:      nomeBairro(reg ? (reg['CDBAI'] || reg['Cdbai'] || '') : '', idxBai),
        complexidade: '', cnaeCode: '', cnaeDesc: '', descricao: ''
      };
    }
  }
  return todas;
}

// ── Busca e-mails dos fiscais no Firestore ───────────────────
async function buscarEmailsPorFiscal() {
  const emails = {};
  try {
    const snap = await db.collection('usuarios').get();
    snap.forEach(doc => {
      const d = doc.data();
      if (d.ativo === false) return;
      const nome  = (d.nome  || '').toUpperCase().trim();
      const email = (d.email || '').trim();
      if (nome && email) emails[nome] = email;
    });
  } catch (err) {
    console.error('❌ Erro ao buscar e-mails no Firestore:', err.message);
  }
  console.log(`📬 ${Object.keys(emails).length} e-mail(s) encontrado(s) no Firestore.`);
  return emails;
}

// ────────────────────────────────────────────────────────────
// ── Geração do e-mail HTML rico ──────────────────────────────
// ────────────────────────────────────────────────────────────

function labelPrazo(dias) {
  if (dias < 0)               return { emoji: '❗', label: 'VENCEU NO FDS', cor: '#7d3c98', bgCor: '#f4ecf7' };
  if (dias === 0)              return { emoji: '🔴', label: 'VENCE HOJE',   cor: '#c0392b', bgCor: '#fdecea' };
  if (dias === 1)              return { emoji: '🟠', label: 'VENCE AMANHÃ', cor: '#e67e22', bgCor: '#fef3e2' };
  if (dias >= 2 && dias <= 4) return { emoji: '⚠️',  label: `${dias} DIAS`,  cor: '#d4a000', bgCor: '#fffbea' };
  if (dias === 5)              return { emoji: '🔵', label: '5 DIAS',        cor: '#2980b9', bgCor: '#eaf4fb' };
  return                              { emoji: '📅', label: `${dias} DIAS`,  cor: '#555',    bgCor: '#f5f5f5' };
}

function linhaDetalhe(icone, label, valor, destaque = false) {
  if (!valor || valor.trim() === '') return '';
  const corValor   = destaque ? '#c0392b' : '#1a1a2e';
  const fontWeight = destaque ? '700' : '400';
  return `
    <tr>
      <td style="padding:5px 10px 5px 0;color:#666;font-size:13px;white-space:nowrap;vertical-align:top;">${icone} <strong>${label}</strong></td>
      <td style="padding:5px 0;color:${corValor};font-size:13px;font-weight:${fontWeight};vertical-align:top;">${valor}</td>
    </tr>`;
}

function htmlCardOS(os, numero, dias) {
  const { emoji, label, cor, bgCor } = labelPrazo(dias);
  const coresTipo = {
    'Requerimento': { bg: '#2980b9', fg: '#fff' },
    'Ofício':       { bg: '#27ae60', fg: '#fff' },
    'Denúncia':     { bg: '#c0392b', fg: '#fff' },
    'Protocolo':    { bg: '#8e44ad', fg: '#fff' }
  };
  const ct = coresTipo[os.tipo] || { bg: '#555', fg: '#fff' };

  const endPartes   = [os.logradouro, os.complemento].filter(Boolean);
  const endCompleto = endPartes.join(', ');
  const cnaeTexto   = os.cnaeCode ? `${os.cnaeCode}${os.cnaeDesc ? ' – ' + os.cnaeDesc : ''}` : '';
  const mapsQuery   = [endCompleto, os.bairro, 'Anápolis GO'].filter(Boolean).join(', ');
  const mapsLink    = mapsQuery ? `https://www.google.com/maps/dir/?api=1&destination=${encodeURIComponent(mapsQuery)}&travelmode=driving` : '';

  // Normaliza prazo para exibição: aceita DD/MM/YYYY, DD.MM.YYYY ou YYYY-MM-DD
  const prazoFmt = normalizarPrazoExibicao(os.prazo);

  let notaTipo = '';
  if (os.tipo === 'Protocolo') {
    notaTipo = `<tr><td colspan="2" style="padding:4px 0;font-size:11px;color:#888;">ℹ️ Prazo calculado: data da última tramitação + 15 dias úteis${os.dataEncaminha ? ` (tram. em ${formatarDataBR(os.dataEncaminha)})` : ''}</td></tr>`;
  } else if (os.tipo === 'Denúncia') {
    notaTipo = `<tr><td colspan="2" style="padding:4px 0;font-size:11px;color:#888;">ℹ️ Denúncia: dados do reclamado conforme cadastro (sem vínculo com regulados)</td></tr>`;
  }

  return `
  <table width="100%" cellpadding="0" cellspacing="0" style="margin-bottom:20px;border-radius:10px;border:1px solid #ddd;border-left:5px solid ${cor};background:#fff;box-shadow:0 2px 6px rgba(0,0,0,0.06);font-family:Arial,sans-serif;">
    <tr>
      <td style="padding:14px 16px;background:${bgCor};border-radius:9px 9px 0 0;">
        <table width="100%" cellpadding="0" cellspacing="0"><tr>
          <td><span style="font-size:17px;font-weight:700;color:${cor};">${emoji} OS ${numero}</span>&nbsp;<span style="display:inline-block;padding:3px 10px;border-radius:20px;background:${ct.bg};color:${ct.fg};font-size:12px;font-weight:700;">${os.tipo}</span></td>
          <td align="right"><span style="display:inline-block;padding:4px 14px;border-radius:20px;background:${cor};color:#fff;font-size:13px;font-weight:700;">${emoji} ${label}</span></td>
        </tr></table>
      </td>
    </tr>
    <tr>
      <td style="padding:14px 16px;">
        <table cellpadding="0" cellspacing="0" style="width:100%;border-collapse:collapse;">
          ${linhaDetalhe('🏢', 'Razão Social',    os.razao || '')}
          ${os.tipo !== 'Denúncia' ? linhaDetalhe('🪟', 'Nome Fantasia', os.fantasia || '') : ''}
          ${os.tipo === 'Requerimento' && os.complexidade ? linhaDetalhe('⚙️', 'Complexidade', os.complexidade) : ''}
          ${cnaeTexto ? linhaDetalhe('🏷️', 'CNAE', cnaeTexto) : ''}
          ${linhaDetalhe('📍', 'Endereço',        endCompleto)}
          ${linhaDetalhe('🏘️', 'Bairro',          os.bairro || '')}
          ${mapsLink ? `<tr><td style="padding:5px 10px 5px 0;font-size:13px;white-space:nowrap;vertical-align:top;color:#666;">📡 <strong>Rota</strong></td><td style="padding:5px 0;font-size:13px;vertical-align:top;"><a href="${mapsLink}" style="color:#1a73e8;text-decoration:none;font-weight:600;">🧭 Traçar rota no Google Maps</a></td></tr>` : ''}
          ${linhaDetalhe('📋', 'Motivo / Assunto', os.motivo || '')}
          ${os.tipo === 'Denúncia' && os.descricao ? linhaDetalhe('📝', 'Descrição', os.descricao) : ''}
          ${os.tipo === 'Protocolo' && os.observacao ? linhaDetalhe('📝', 'Complemento', os.observacao) : ''}
          ${linhaDetalhe('📅', 'Data Abertura',   os.dataReq ? formatarDataBR(os.dataReq) : '')}
          ${linhaDetalhe('⏰', 'Prazo Final',      prazoFmt, true)}
          ${notaTipo}
        </table>
      </td>
    </tr>
  </table>`;
}

function gerarEmailHTML(nomeFiscal, alertasFiscal) {
  const hoje       = new Date().toLocaleDateString('pt-BR', { timeZone: 'America/Sao_Paulo', weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
  const qtd        = alertasFiscal.length;
  const temHoje    = alertasFiscal.some(a => a.dias === 0);
  const corHeader  = temHoje ? '#c0392b' : '#1a3a6b';
  alertasFiscal.sort((a, b) => a.dias - b.dias);
  const cardsHTML  = alertasFiscal.map(a => htmlCardOS(a.os, a.numero, a.dias)).join('');
  const nomeFmt    = nomeFiscal.split(' ').map(p => p.charAt(0).toUpperCase() + p.slice(1).toLowerCase()).join(' ');

  return `<!DOCTYPE html>
<html lang="pt-BR"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0"><title>Alerta de Prazo — VISA Anápolis</title></head>
<body style="margin:0;padding:0;background:#f0f2f5;font-family:Arial,Helvetica,sans-serif;">
<table width="100%" cellpadding="0" cellspacing="0" style="background:#f0f2f5;padding:30px 10px;"><tr><td align="center">
<table width="640" cellpadding="0" cellspacing="0" style="max-width:640px;width:100%;">

  <!-- Cabeçalho -->
  <tr><td style="background:${corHeader};padding:28px 32px;border-radius:12px 12px 0 0;">
    <table width="100%" cellpadding="0" cellspacing="0"><tr>
      <td><div style="font-size:22px;font-weight:700;color:#fff;margin-bottom:6px;">⚠️ Alerta de Prazo — VISA Anápolis</div><div style="font-size:13px;color:rgba(255,255,255,0.80);">Gerência de Vigilância Sanitária · Anápolis – GO</div></td>
      <td align="right" valign="middle"><span style="display:inline-block;background:rgba(255,255,255,0.18);color:#fff;padding:8px 16px;border-radius:20px;font-size:13px;font-weight:700;">${qtd} OS${qtd > 1 ? 's' : ''}</span></td>
    </tr></table>
  </td></tr>

  <!-- Corpo -->
  <tr><td style="background:#fff;padding:28px 32px;">
    <p style="margin:0 0 6px 0;font-size:16px;color:#1a1a2e;font-weight:700;">Prezado(a) ${nomeFmt},</p>
    <p style="margin:0 0 20px 0;font-size:14px;color:#555;line-height:1.6;">Você possui <strong>${qtd} Ordem${qtd > 1 ? 'ns' : ''} de Serviço</strong> com prazo de vencimento se aproximando. Verifique cada OS abaixo e tome as providências cabíveis no sistema CVS dentro do prazo legal.</p>
    <p style="margin:0 0 24px 0;font-size:12px;color:#888;">📅 ${hoje.charAt(0).toUpperCase() + hoje.slice(1)}</p>
    ${cardsHTML}
    <table width="100%" cellpadding="0" cellspacing="0" style="margin-top:10px;"><tr><td align="center">
      <a href="https://garrado.github.io/VISA/os.html" style="display:inline-block;background:#1a3a6b;color:#fff;text-decoration:none;padding:14px 36px;border-radius:8px;font-size:15px;font-weight:700;margin-top:8px;">📋 Abrir Consulta de OS</a>
    </td></tr></table>
  </td></tr>

  <!-- Rodapé -->
  <tr><td style="background:#1a3a6b;padding:18px 32px;border-radius:0 0 12px 12px;text-align:center;">
    <p style="margin:0 0 4px 0;font-size:12px;color:rgba(255,255,255,0.7);">Mensagem automática — Sistema VISA · Gerência de Vigilância Sanitária de Anápolis</p>
    <p style="margin:0;font-size:11px;color:rgba(255,255,255,0.5);">Não responda este e-mail. Para dúvidas, entre em contato com a chefia administrativa.</p>
  </td></tr>

</table>
</td></tr></table>
</body></html>`;
}

// ── Função principal ─────────────────────────────────────────
async function main() {
  console.log('🚀 VISA E-mail Notifier — verificando prazos...');
  console.log(`📅 ${new Date().toLocaleString('pt-BR', { timeZone: 'America/Sao_Paulo' })}`);

  if (!SMTP_USER || !SMTP_PASS) {
    console.error('❌ SMTP_USER ou SMTP_PASSWORD não configurados nos secrets.');
    process.exit(1);
  }

  const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com', port: 465, secure: true,
    auth: { user: SMTP_USER, pass: SMTP_PASS }
  });

  // 1. Carrega tabelas auxiliares
  const idxReg     = carregarCSVIndexado('regulados.csv', 'CODIGO');
  const idxBai     = carregarCSVIndexado('bairros.csv',   'CODIGO');
  const idxCnaeRaw = carregarCSVIndexado('cnae.csv', 'Subclasse');
  const idxCnae    = Object.keys(idxCnaeRaw).length ? idxCnaeRaw : carregarCSVIndexado('cnae.csv', 'SUBCLASSE');

  // 2. Lê OSs enriquecidas
  const osAtuais = lerTodasOSs(idxReg, idxBai, idxCnae);
  console.log(`📊 Total de OSs nos CSVs: ${Object.keys(osAtuais).length}`);

  // 3. Snapshot
  let snapshot = {};
  if (fs.existsSync(SNAPSHOT_FILE)) {
    try { snapshot = JSON.parse(fs.readFileSync(SNAPSHOT_FILE, 'utf8')); }
    catch (e) { console.warn('⚠️  Erro ao ler snapshot:', e.message); }
  }

  // 4. E-mails dos fiscais
  const emailsPorFiscal = await buscarEmailsPorFiscal();
  const novoSnapshot    = { ...snapshot };
  const alertas = { VENCE_HOJE: 0, PRAZO_5D: 0, RECUPERACAO: 0, AMANHA: 0, VENCEU_FDS: 0 };
  const alertasPorFiscal = {};

  for (const [numero, os] of Object.entries(osAtuais)) {
    const anterior = snapshot[numero] || {};
    const dias     = os.prazo ? calcularDiasAte(os.prazo) : null;
    if (!novoSnapshot[numero]) novoSnapshot[numero] = { ...os };
    if (dias === null || !os.fiscal) continue;

    const fiscalKey   = os.fiscal.toUpperCase().trim();
    const prazoData   = converterData(os.prazo);
    const diaSemana   = prazoData ? prazoData.getDay() : -1;
    const venceuNoFDS = diaSemana === 0 || diaSemana === 6;

    let gatilho = '', flagKey = '';
    if      (dias === 0 && !anterior.email_notif_hoje)                                                { gatilho = 'VENCE_HOJE';  flagKey = 'email_notif_hoje'; }
    else if (dias === 1 && !anterior.email_notif_amanha)                                              { gatilho = 'AMANHA';      flagKey = 'email_notif_amanha'; }
    else if (dias >= 2 && dias <= 4 && !anterior.email_notif_5d && !anterior.email_notif_recuperacao) { gatilho = 'RECUPERACAO'; flagKey = 'email_notif_recuperacao'; }
    else if (dias === 5 && !anterior.email_notif_5d)                                                  { gatilho = 'PRAZO_5D';    flagKey = 'email_notif_5d'; }
    else if (dias < 0 && dias >= -2 && venceuNoFDS && !anterior.email_notif_hoje && !anterior.email_notif_venceu_fds) { gatilho = 'VENCEU_FDS'; flagKey = 'email_notif_venceu_fds'; }

    if (!gatilho) continue;
    alertas[gatilho]++;

    if (!alertasPorFiscal[fiscalKey]) alertasPorFiscal[fiscalKey] = [];
    alertasPorFiscal[fiscalKey].push({ os, numero, dias, flagKey, gatilho });
  }

  // 5. Envia um e-mail consolidado por fiscal
  let totalEnviados = 0, totalErros = 0;

  for (const [fiscalKey, listaOS] of Object.entries(alertasPorFiscal)) {
    const emailFiscal = emailsPorFiscal[fiscalKey];
    if (!emailFiscal) {
      console.log(`⚠️  Sem e-mail no Firestore para "${fiscalKey}"`);
      continue;
    }

    const temHoje   = listaOS.some(a => a.dias === 0);
    const temAmanha = listaOS.some(a => a.dias === 1);
    let assunto = '';
    if      (temHoje)   assunto = `🔴 VENCE HOJE — ${listaOS.length} OS(s) | VISA Anápolis`;
    else if (temAmanha) assunto = `🟠 VENCE AMANHÃ — ${listaOS.length} OS(s) | VISA Anápolis`;
    else                assunto = `⚠️ ${listaOS.length} OS(s) com prazo vencendo | VISA Anápolis`;

    const html = gerarEmailHTML(fiscalKey, listaOS);

    try {
      await transporter.sendMail({
        from:    `"Gerência de Vigilância Sanitária" <${SMTP_USER}>`,
        to:      emailFiscal,
        subject: assunto,
        html
      });
      listaOS.forEach(a => { novoSnapshot[a.numero][a.flagKey] = true; });
      totalEnviados++;
      console.log(`✅ ${listaOS.map(a=>a.gatilho).join('/')} OS ${listaOS.map(a=>a.numero).join(',')} → ${emailFiscal}`);
    } catch (e) {
      totalErros++;
      console.error(`❌ Erro ao enviar para ${emailFiscal}:`, e.message);
    }
  }

  const total = Object.values(alertas).reduce((a, b) => a + b, 0);
  console.log(`\n🔔 Alertas detectados : ${total}`);
  console.log(`   VENCE_HOJE  : ${alertas.VENCE_HOJE}`);
  console.log(`   AMANHÃ      : ${alertas.AMANHA}`);
  console.log(`   RECUPERAÇÃO : ${alertas.RECUPERACAO}`);
  console.log(`   PRAZO_5D    : ${alertas.PRAZO_5D}`);
  console.log(`   VENCEU_FDS  : ${alertas.VENCEU_FDS}`);
  console.log(`📧 Enviados: ${totalEnviados} | Erros: ${totalErros}`);

  fs.writeFileSync(SNAPSHOT_FILE, JSON.stringify(novoSnapshot, null, 2), 'utf8');
  console.log('✅ Snapshot salvo. Processo concluído.');
  process.exit(0);
}

main().catch(err => { console.error('❌ Erro fatal:', err); process.exit(1); });
