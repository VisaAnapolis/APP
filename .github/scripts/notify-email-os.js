// ============================================================
// notify-email-os.js  —  GitHub Actions Script
// Detecta OSs com prazo vencendo e envia notificações por E-MAIL
//
// Lógica (idêntica ao notify-os.js, canal diferente):
//   1. Lê os 5 CSVs de OS (requerimento, oficio, denuncia, protocolo, tramitacao)
//   2. Compara com o snapshot anterior (data/os_snapshot.json)
//   3. Calcula dias para o prazo de cada OS
//   4. Gatilhos: VENCE_HOJE(0d), AMANHA(1d), RECUPERACAO(2-4d), PRAZO_5D(5d)
//   5. Busca e-mail do fiscal na coleção 'usuarios' do Firestore
//   6. Envia e-mail HTML via SMTP Gmail (App Password)
//   7. Atualiza flags email_notif_* no snapshot (independentes do FCM)
// ============================================================

const fs         = require('fs');
const path       = require('path');
const admin      = require('firebase-admin');
const nodemailer = require('nodemailer');

// ── Inicialização Firebase ────────────────────────────────────
const serviceAccountPath = process.env.FIREBASE_SERVICE_ACCOUNT_PATH
  || path.join(__dirname, 'service-account.json');

const serviceAccount = JSON.parse(fs.readFileSync(serviceAccountPath, 'utf8'));
admin.initializeApp({ credential: admin.credential.cert(serviceAccount) });
const db = admin.firestore();

// ── Configurações SMTP ────────────────────────────────────────
const SMTP_USER = process.env.SMTP_USER;
const SMTP_PASS = process.env.SMTP_PASSWORD;

// ── Caminhos ──────────────────────────────────────────────────
const ROOT          = path.join(__dirname, '..', '..');
const SNAPSHOT_FILE = path.join(ROOT, 'data', 'os_snapshot.json');

// ── Lista oficial de fiscais ──────────────────────────────────
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

// ── Mapeamento CSVs ───────────────────────────────────────────
const CSV_CONFIGS = [
  {
    tipo: 'Requerimento', arquivo: 'data/requerimento.csv',
    campoNumero: 'OS',       campoFiscal: 'Fiscal_Encaminha',
    campoMotivo: 'Motivo',   campoPrazo:  'Prazo',
    campoAtendida: 'Atendimento', campoCancelada: 'Cancelado'
  },
  {
    tipo: 'Ofício', arquivo: 'data/oficio.csv',
    campoNumero: 'Oficio',   campoFiscal: 'Fiscalencaminha',
    campoMotivo: 'Motivo',   campoPrazo:  'Prazo',
    campoAtendida: 'Archive', campoCancelada: 'Cancela'
  },
  {
    tipo: 'Denúncia', arquivo: 'data/denuncia.csv',
    campoNumero: 'Denuncia', campoFiscal: 'FiscalEncaminha',
    campoMotivo: 'Objeto1',  campoPrazo:  'Prazo',
    campoAtendida: 'Archive', campoCancelada: null
  },
];

// ── Parser CSV ────────────────────────────────────────────────
function parseCSV(conteudo) {
  const linhas = conteudo.split('\n').filter(l => l.trim());
  if (linhas.length < 2) return [];
  const cabecalho = linhas[0]
    .replace(/^\uFEFF/, '')
    .split(';')
    .map(c => c.replace(/^"|"$/g, '').trim());
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
  return `${String(d.getDate()).padStart(2,'0')}.${String(d.getMonth()+1).padStart(2,'0')}.${d.getFullYear()}`;
}

function calcularDiasAte(dataStr) {
  const data = converterData(dataStr);
  if (!data) return null;
  const hoje = new Date(); hoje.setHours(0,0,0,0); data.setHours(0,0,0,0);
  return Math.floor((data - hoje) / 86400000);
}

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

function lerTodasOSs() {
  const todas = {};
  for (const cfg of CSV_CONFIGS) {
    const arq = path.join(ROOT, cfg.arquivo);
    if (!fs.existsSync(arq)) { console.warn(`⚠️  Não encontrado: ${cfg.arquivo}`); continue; }
    for (const r of parseCSV(fs.readFileSync(arq, 'utf8'))) {
      const num = (r[cfg.campoNumero] || '').trim(); if (!num) continue;
      if ((r[cfg.campoAtendida]  || '').toLowerCase() === 'sim') continue;
      if (cfg.campoCancelada && (r[cfg.campoCancelada] || '').toLowerCase() === 'sim') continue;
      todas[num] = {
        tipo:   cfg.tipo,
        fiscal: (r[cfg.campoFiscal] || '').trim(),
        motivo: (r[cfg.campoMotivo] || '').trim(),
        prazo:  (r[cfg.campoPrazo]  || '').trim()
      };
    }
  }
  const trams = carregarTramitacoes();
  const arqP  = path.join(ROOT, 'data', 'protocolo.csv');
  if (fs.existsSync(arqP)) {
    for (const r of parseCSV(fs.readFileSync(arqP, 'utf8'))) {
      const num = (r['Protocolo'] || '').trim(); if (!num) continue;
      const { fiscal, dataEncaminha } = buscarFiscalTramitacao(trams[num]);
      if (!fiscal || !dataEncaminha) continue;
      todas[num] = {
        tipo:   'Protocolo',
        fiscal: fiscal,
        motivo: (r['Assunto'] || '').trim(),
        prazo:  adicionarDiasUteis(dataEncaminha, 15)
      };
    }
  }
  return todas;
}

// ── Busca e-mails dos fiscais no Firestore ────────────────────
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

// ── Envia e-mail HTML via SMTP Gmail ─────────────────────────
// transporter é criado uma vez em main() e reutilizado em todas as chamadas
async function enviarEmail(transporter, para, fiscal, numero, tipo, motivo, dias, prazoStr) {
  const cor      = dias === 0 ? '#c0392b' : dias === 1 ? '#e67e22' : '#2980b9';
  const urgencia = dias === 0 ? '🔴 VENCE HOJE' : dias === 1 ? '🟡 VENCE AMANHÃ' : `🔵 ${dias} DIAS`;

  await transporter.sendMail({
    from:    `"DVS Anápolis" <${SMTP_USER}>`,
    to:      para,
    subject: `${urgencia} — OS ${numero} (${tipo}) | VISA Anápolis`,
    html: `
<html><body style="font-family:Arial,sans-serif;max-width:620px;margin:0 auto">
  <div style="background:${cor};padding:14px 20px;border-radius:6px 6px 0 0">
    <h2 style="color:#fff;margin:0;font-size:18px">
      ⚠️ Alerta de Prazo — DVS Anápolis/GO
    </h2>
  </div>
  <div style="border:1px solid #ddd;border-top:none;padding:24px;border-radius:0 0 6px 6px">
    <p style="margin-top:0">Prezado(a) <strong>${fiscal}</strong>,</p>
    <p>Sua Ordem de Serviço está próxima do vencimento:</p>
    <table style="border-collapse:collapse;width:100%;margin:16px 0;font-size:14px">
      <tr style="background:#f7f7f7">
        <td style="padding:9px 12px;border:1px solid #ddd;font-weight:bold;width:40%">Nº OS / Tipo</td>
        <td style="padding:9px 12px;border:1px solid #ddd">${numero} — ${tipo}</td>
      </tr>
      <tr>
        <td style="padding:9px 12px;border:1px solid #ddd;font-weight:bold">Assunto / Motivo</td>
        <td style="padding:9px 12px;border:1px solid #ddd">${motivo || '—'}</td>
      </tr>
      <tr style="background:#f7f7f7">
        <td style="padding:9px 12px;border:1px solid #ddd;font-weight:bold">Data de Vencimento</td>
        <td style="padding:9px 12px;border:1px solid #ddd;color:${cor};font-weight:bold">
          ${prazoStr}
        </td>
      </tr>
      <tr>
        <td style="padding:9px 12px;border:1px solid #ddd;font-weight:bold">Dias Restantes</td>
        <td style="padding:9px 12px;border:1px solid #ddd;color:${cor};font-weight:bold">
          ${dias === 0 ? 'VENCE HOJE' : dias + ' dia(s)'}
        </td>
      </tr>
    </table>
    <p>Acesse o <strong>sistema CVS</strong> e providencie a regularização.</p>
    <hr style="border:none;border-top:1px solid #eee;margin:20px 0">
    <p style="color:#999;font-size:12px;margin:0">
      Mensagem automática — sistema VISA · DVS Anápolis/GO<br>
      Não responda este e-mail.
    </p>
  </div>
</body></html>`
  });
}

// ── Função principal ──────────────────────────────────────────
async function main() {
  console.log('🚀 VISA E-mail Notifier — verificando prazos...');
  console.log(`📅 ${new Date().toLocaleString('pt-BR', { timeZone: 'America/Sao_Paulo' })}`);

  if (!SMTP_USER || !SMTP_PASS) {
    console.error('❌ SMTP_USER ou SMTP_PASSWORD não configurados nos secrets.');
    process.exit(1);
  }

  // Transporter criado uma vez e reutilizado em todos os envios
  const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com', port: 465, secure: true,
    auth: { user: SMTP_USER, pass: SMTP_PASS }
  });

  const osAtuais = lerTodasOSs();
  console.log(`📊 Total de OSs nos CSVs: ${Object.keys(osAtuais).length}`);

  let snapshot = {};
  if (fs.existsSync(SNAPSHOT_FILE)) {
    try { snapshot = JSON.parse(fs.readFileSync(SNAPSHOT_FILE, 'utf8')); }
    catch (e) { console.warn('⚠️  Erro ao ler snapshot:', e.message); }
  }

  const emailsPorFiscal = await buscarEmailsPorFiscal();
  const novoSnapshot    = { ...snapshot };
  const alertas = { VENCE_HOJE: 0, PRAZO_5D: 0, RECUPERACAO: 0, AMANHA: 0 };
  let totalEnviados = 0, totalErros = 0;

  for (const [numero, os] of Object.entries(osAtuais)) {
    const anterior = snapshot[numero] || {};
    const dias     = os.prazo ? calcularDiasAte(os.prazo) : null;
    if (!novoSnapshot[numero]) novoSnapshot[numero] = { ...os };
    if (dias === null || !os.fiscal) continue;

    const fiscalKey   = os.fiscal.toUpperCase().trim();
    const emailFiscal = emailsPorFiscal[fiscalKey];
    if (!emailFiscal) {
      console.log(`⚠️  Sem e-mail no Firestore para "${os.fiscal}"`);
      continue;
    }

    // Função auxiliar para enviar e marcar flag
    const tentar = async (gatilho, flagKey) => {
      alertas[gatilho]++;
      try {
        await enviarEmail(transporter, emailFiscal, os.fiscal, numero, os.tipo, os.motivo, dias, os.prazo);
        novoSnapshot[numero][flagKey] = true;
        totalEnviados++;
        console.log(`✅ ${gatilho} OS ${numero} → ${emailFiscal}`);
      } catch (e) {
        totalErros++;
        console.error(`❌ ${gatilho} OS ${numero}:`, e.message);
      }
    };

    if (dias === 0 && !anterior.email_notif_hoje)
      await tentar('VENCE_HOJE', 'email_notif_hoje');

    if (dias === 1 && !anterior.email_notif_amanha)
      await tentar('AMANHA', 'email_notif_amanha');

    if (dias >= 2 && dias <= 4 && !anterior.email_notif_5d && !anterior.email_notif_recuperacao)
      await tentar('RECUPERACAO', 'email_notif_recuperacao');

    if (dias === 5 && !anterior.email_notif_5d)
      await tentar('PRAZO_5D', 'email_notif_5d');
  }

  const total = Object.values(alertas).reduce((a, b) => a + b, 0);
  console.log(`\n🔔 Alertas detectados : ${total}`);
  console.log(`   VENCE_HOJE  : ${alertas.VENCE_HOJE}`);
  console.log(`   AMANHÃ      : ${alertas.AMANHA}`);
  console.log(`   RECUPERAÇÃO : ${alertas.RECUPERACAO}`);
  console.log(`   PRAZO_5D    : ${alertas.PRAZO_5D}`);
  console.log(`📧 Enviados: ${totalEnviados} | Erros: ${totalErros}`);

  fs.writeFileSync(SNAPSHOT_FILE, JSON.stringify(novoSnapshot, null, 2), 'utf8');
  console.log('✅ Snapshot salvo. Processo concluído.');
  process.exit(0);
}

main().catch(err => { console.error('❌ Erro fatal:', err); process.exit(1); });
