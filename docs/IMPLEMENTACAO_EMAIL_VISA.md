# 📧 Relatório de Implementação — Notificador de OS por E-mail
### Sistema VISA · Diretoria de Vigilância em Saúde — Anápolis/GO
**Data:** 07/03/2026 | **Repositório:** [garrado/VISA](https://github.com/garrado/VISA)

---

## 1. Objetivo

Implementar um segundo canal de notificação de vencimento de Ordens de Serviço,
complementar ao sistema FCM (push) já existente, utilizando **e-mail via SMTP Gmail**.

O novo sistema é **totalmente independente** do workflow FCM (`notify-os.yml`),
porém compartilha a mesma fonte de dados (CSVs) e o mesmo snapshot
(`data/os_snapshot.json`), usando flags exclusivas prefixadas com `email_notif_*`
para controle de duplicidade sem conflito com as flags FCM.

---

## 2. Análise do Sistema Existente (FCM)

| Elemento | Implementação atual |
|---|---|
| Arquivo workflow | `.github/workflows/notify-os.yml` |
| Script principal | `.github/scripts/notify-os.js` |
| CSVs monitorados | `requerimento.csv`, `oficio.csv`, `denuncia.csv`, `protocolo.csv`, `tramitacao.csv` |
| Delimitador CSV | `;` com suporte a BOM UTF-8 e aspas duplas |
| Prazo Protocolo | 15 dias úteis a partir do último encaminhamento em `tramitacao.csv` |
| Gatilhos de prazo | `0d` (hoje), `1d` (amanhã), `2-4d` (recuperação), `5d` |
| Schedule | 08:30 / 12:30 / 16:30 BRT — seg a sex |
| Snapshot | `data/os_snapshot.json` |
| Dependências | `firebase-admin ^12.0.0` |
| Secrets utilizados | `FIREBASE_SERVICE_ACCOUNT` |

---

## 3. Arquitetura da Solução

```
CSVs no repositório (requerimento / oficio / denuncia / protocolo / tramitacao)
        │
        ▼
notify-email-os.js  (GitHub Actions — ubuntu-latest)
        │
        ├─► Firestore (usuarios) → busca campo "email" de cada fiscal
        │
        ├─► Verifica gatilhos de prazo (0d / 1d / 2-4d / 5d)
        │
        ├─► Checa flags email_notif_* no snapshot (anti-duplicidade)
        │
        └─► SMTP Gmail (smtp.gmail.com:465) → e-mail HTML ao fiscal
                │
                └─► Atualiza os_snapshot.json com novas flags email_notif_*
```

---

## 4. Pré-requisitos Externos

### 4.1 Gmail — Configuração pelo Administrador do Domínio

O envio requer uma **Senha de App (App Password)** vinculada à conta remetente.
O administrador do domínio Google Workspace deve:

1. Acessar `admin.google.com`
2. Navegar em **Segurança → Autenticação → Verificação em duas etapas**
3. Definir a política como **"Permitido"** para a Unidade Organizacional da conta remetente
4. Salvar (propagação em até 24h)

Após liberação pelo admin, o **proprietário da conta remetente** executa:

1. Acessar `myaccount.google.com/security`
2. Ativar **Verificação em duas etapas**
3. Buscar **Senhas de app** → Gerar → Copiar os 16 caracteres gerados
4. Guardar a senha — ela será usada como secret `SMTP_PASSWORD`

> ⚠️ Sem 2FA ativo na conta, a opção "Senhas de app" não aparece.
> ⚠️ A senha de app não expira, mas é revogada se o 2FA for desativado.

### 4.2 Firestore — Campo `email` nos Documentos de Usuário

O script busca o e-mail de cada fiscal na coleção `usuarios` do Firestore.
Cada documento deve conter o campo:

```json
{
  "nome":  "NOME DO FISCAL EM MAIÚSCULAS",
  "email": "fiscal@dominio.gov.br",
  "ativo": true
}
```

Se o campo `email` ainda não existe, deve ser adicionado no cadastro do usuário
no app — sem necessidade de nova coleção ou estrutura.

### 4.3 Secrets no Repositório GitHub

`Settings → Secrets and variables → Actions → New repository secret`

| Secret | Valor |
|---|---|
| `SMTP_USER` | E-mail remetente completo (ex: `dvs@anapolis.go.gov.br`) |
| `SMTP_PASSWORD` | Senha de App de 16 dígitos gerada no Gmail |

---

## 5. Arquivos a Criar

### 5.1 `.github/scripts/package.json` — Atualização

Adicionar `nodemailer` às dependências existentes:

```json
{
  "name": "visa-os-notifier",
  "version": "1.0.0",
  "description": "Script de notificações push para novas OSs — VISA Anápolis",
  "main": "notify-os.js",
  "scripts": {
    "notify": "node notify-os.js"
  },
  "dependencies": {
    "firebase-admin": "^12.0.0",
    "nodemailer": "^6.9.0"
  },
  "engines": {
    "node": ">=18"
  }
}
```

> Após editar, executar `npm install` localmente e commitar o
> `package-lock.json` atualizado.

---

### 5.2 `.github/workflows/notify-email-os.yml` — Criar

```yaml
# ============================================================
# notify-email-os.yml  —  GitHub Actions Workflow
# Detecta OSs com prazo vencendo e envia notificações por E-MAIL
# usando SMTP do Gmail (App Password).
#
# Dispara:
#   - Automaticamente 3x ao dia nos dias úteis (cron):
#       8:30, 12:30 e 16:30 (Horário de Brasília, UTC-3)
#   - Manualmente pelo painel do GitHub Actions
#
# NÃO interfere no workflow FCM (notify-os.yml).
# Usa o mesmo os_snapshot.json mas com flags independentes
# (email_notif_*) para controle de duplicidade sem conflito.
# ============================================================

name: 📧 Notificar OSs por E-mail

on:
  schedule:
    - cron: '30 11 * * 1-5'   # 08:30 BRT (dias úteis)
    - cron: '30 15 * * 1-5'   # 12:30 BRT (dias úteis)
    - cron: '30 19 * * 1-5'   # 16:30 BRT (dias úteis)

  workflow_dispatch:

jobs:
  notify-email:
    name: Detectar e Notificar OSs por E-mail
    runs-on: ubuntu-latest
    permissions:
      contents: write

    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
          cache-dependency-path: '.github/scripts/package.json'

      - name: Instalar dependências
        working-directory: .github/scripts
        run: npm ci

      - name: Criar Service Account
        run: |
          echo '${{ secrets.FIREBASE_SERVICE_ACCOUNT }}' > .github/scripts/service-account.json

      - name: Executar notificador de e-mail
        working-directory: .github/scripts
        env:
          SMTP_USER:                    ${{ secrets.SMTP_USER }}
          SMTP_PASSWORD:                ${{ secrets.SMTP_PASSWORD }}
          FIREBASE_SERVICE_ACCOUNT_PATH: service-account.json
        run: node notify-email-os.js

      - name: Remover Service Account
        if: always()
        run: rm -f .github/scripts/service-account.json

      - name: Salvar snapshot atualizado
        run: |
          git config user.name  "VISA Bot"
          git config user.email "visa-bot@anapolis.go.gov.br"
          git add data/os_snapshot.json || true
          git diff --staged --quiet || git commit -m "Auto-update OS snapshot (email) [skip ci]"
          git push || true
```

---

### 5.3 `.github/scripts/notify-email-os.js` — Criar

```javascript
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

const fs    = require('fs');
const path  = require('path');
const admin = require('firebase-admin');

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
async function enviarEmail(para, fiscal, numero, tipo, motivo, dias, prazoStr) {
  const nodemailer  = require('nodemailer');
  const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com', port: 465, secure: true,
    auth: { user: SMTP_USER, pass: SMTP_PASS }
  });

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
        await enviarEmail(emailFiscal, os.fiscal, numero, os.tipo, os.motivo, dias, os.prazo);
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
```

---

## 6. Estrutura de Flags no Snapshot

O `os_snapshot.json` passa a conter, por OS, tanto as flags FCM quanto as de e-mail:

```json
{
  "12345": {
    "tipo": "Requerimento",
    "fiscal": "JOÃO BATISTA LUCAS DA SILVA REIS",
    "motivo": "Fiscalização periódica",
    "prazo": "10.03.2026",
    "notif_5d":          true,
    "notif_recuperacao": false,
    "notif_amanha":      false,
    "notif_hoje":        false,
    "email_notif_5d":          true,
    "email_notif_recuperacao": false,
    "email_notif_amanha":      false,
    "email_notif_hoje":        false
  }
}
```

Flags FCM (`notif_*`) e flags de e-mail (`email_notif_*`) são **completamente independentes**.
Cada canal controla seu próprio ciclo de notificação.

---

## 7. Gatilhos de Prazo

| Gatilho | Dias restantes | Flag de controle | Comportamento |
|---|---|---|---|
| `PRAZO_5D` | Exatamente 5 dias | `email_notif_5d` | 1 disparo |
| `RECUPERACAO` | Entre 2 e 4 dias | `email_notif_recuperacao` | 1 disparo (cobre fds sem notif 5d) |
| `AMANHA` | Exatamente 1 dia | `email_notif_amanha` | 1 disparo |
| `VENCE_HOJE` | 0 dias | `email_notif_hoje` | 1 disparo/dia (bloqueado nas rodadas seguintes do mesmo dia) |

---

## 8. Modelo do E-mail Enviado

```
Assunto: 🔴 VENCE HOJE — OS 12345 (Requerimento) | VISA Anápolis

┌─────────────────────────────────────────────────┐
│  ⚠️ Alerta de Prazo — DVS Anápolis/GO           │  ← fundo vermelho/laranja/azul
├─────────────────────────────────────────────────┤
│ Prezado(a) JOÃO BATISTA LUCAS DA SILVA REIS,    │
│                                                  │
│ Sua OS está próxima do vencimento:              │
│                                                  │
│  Nº OS / Tipo    │ 12345 — Requerimento         │
│  Assunto         │ Fiscalização periódica        │
│  Data Vencimento │ 07/03/2026  (em vermelho)     │
│  Dias Restantes  │ VENCE HOJE  (em vermelho)     │
│                                                  │
│ Acesse o sistema CVS e providencie a            │
│ regularização.                                  │
│                                                  │
│ Mensagem automática — DVS Anápolis/GO           │
└─────────────────────────────────────────────────┘
```

Cor do cabeçalho por urgência:
- 🔴 **Vermelho** (`#c0392b`) — vence hoje
- 🟡 **Laranja** (`#e67e22`) — vence amanhã
- 🔵 **Azul** (`#2980b9`) — 2 a 5 dias

---

## 9. Checklist de Deploy

- [ ] **1. package.json** — Adicionar `"nodemailer": "^6.9.0"` e rodar `npm install`
- [ ] **2. package-lock.json** — Commitar versão atualizada
- [ ] **3. Firestore** — Confirmar campo `email` nos documentos de `usuarios`
- [ ] **4. Gmail/Admin** — Habilitar 2FA + gerar App Password de 16 dígitos
- [ ] **5. Secrets GitHub** — Cadastrar `SMTP_USER` e `SMTP_PASSWORD`
- [ ] **6. Criar arquivo** — `.github/scripts/notify-email-os.js`
- [ ] **7. Criar arquivo** — `.github/workflows/notify-email-os.yml`
- [ ] **8. Teste manual** — Executar via `workflow_dispatch` no painel Actions
- [ ] **9. Verificar logs** — OSs sem e-mail aparecem como `⚠️ Sem e-mail no Firestore`
- [ ] **10. Validar e-mail** — Confirmar recebimento na caixa do fiscal de teste

---

## 10. Alternativas se o Gmail Corporativo Não for Liberado

| Serviço | Plano gratuito | Integração | Observação |
|---|---|---|---|
| **Gmail pessoal dedicado** | Ilimitado | Idêntica (App Password) | Criar `notificador.visa.anapolis@gmail.com` |
| **Resend.com** | 3.000/mês | API REST simples | Setup em 10 min, domínio próprio |
| **SendGrid** | 100/dia | SMTP ou API REST | Mais robusto, requer DNS (SPF/DKIM) |

Para Gmail pessoal: alterar apenas `SMTP_USER` e `SMTP_PASSWORD` nos secrets.
O código do script permanece **idêntico**.

---

*Gerado automaticamente pelo assistente VISA · DVS Anápolis/GO · 07/03/2026*
