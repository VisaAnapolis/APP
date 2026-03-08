// ============================================================
// test-email-notify.js — Envia e-mail de teste para todos os
// usuários ativos registrados no Firestore.
//
// Análogo ao test-notify.js (FCM), mas pelo canal SMTP Gmail.
// Uso: disparar manualmente via GitHub Actions (workflow_dispatch)
//      para validar conectividade SMTP e configuração de secrets.
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

// ── Função principal ──────────────────────────────────────────
async function enviarEmailTeste() {
  console.log('🚀 VISA Test E-mail Notifier — iniciando...');
  console.log(`📅 ${new Date().toLocaleString('pt-BR', { timeZone: 'America/Sao_Paulo' })}`);

  if (!SMTP_USER || !SMTP_PASS) {
    console.error('❌ SMTP_USER ou SMTP_PASSWORD não configurados nos secrets.');
    process.exit(1);
  }

  // Cria transporter SMTP
  const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com', port: 465, secure: true,
    auth: { user: SMTP_USER, pass: SMTP_PASS }
  });

  // Verifica conectividade SMTP antes de continuar
  try {
    await transporter.verify();
    console.log('✅ Conexão SMTP verificada com sucesso.');
  } catch (err) {
    console.error('❌ Falha na conexão SMTP:', err.message);
    process.exit(1);
  }

  // Busca todos os usuários ativos com e-mail
  let snap;
  try {
    snap = await db.collection('usuarios').get();
  } catch (err) {
    console.error('❌ Erro ao acessar Firestore:', err.message);
    process.exit(1);
  }

  if (snap.empty) {
    console.log('Nenhum usuário encontrado no Firestore.');
    return;
  }

  const destinatarios = [];
  snap.forEach(doc => {
    const d = doc.data();
    if (d.ativo === false) return;
    const email = (d.email || '').trim();
    const nome  = (d.nome  || doc.id).trim();
    if (email) destinatarios.push({ email, nome });
  });

  if (destinatarios.length === 0) {
    console.log('Nenhum usuário ativo com e-mail encontrado.');
    return;
  }

  console.log(`\n👥 ${destinatarios.length} destinatário(s) encontrado(s):`);
  destinatarios.forEach(d => console.log(`  📧 ${d.nome} — ${d.email}`));
  console.log('');

  const dataHora = new Date().toLocaleString('pt-BR', {
    timeZone: 'America/Sao_Paulo',
    day: '2-digit', month: '2-digit', year: 'numeric',
    hour: '2-digit', minute: '2-digit'
  });

  let totalSucesso = 0, totalErros = 0;

  for (const dest of destinatarios) {
    try {
      await transporter.sendMail({
        from:    `"DVS Anápolis" <${SMTP_USER}>`,
        to:      dest.email,
        subject: `🔔 E-mail de Teste — Sistema VISA | ${dataHora}`,
        html: `
<html><body style="font-family:Arial,sans-serif;max-width:620px;margin:0 auto">
  <div style="background:#004aad;padding:14px 20px;border-radius:6px 6px 0 0">
    <h2 style="color:#fff;margin:0;font-size:18px">
      🔔 Notificação de Teste — DVS Anápolis/GO
    </h2>
  </div>
  <div style="border:1px solid #ddd;border-top:none;padding:24px;border-radius:0 0 6px 6px">
    <p style="margin-top:0">Prezado(a) <strong>${dest.nome}</strong>,</p>
    <p>Este é um <strong>e-mail de teste</strong> enviado pelo sistema VISA para validar
    a configuração de notificações por e-mail.</p>
    <div style="background:#f0f7ff;border-left:4px solid #004aad;padding:12px 16px;margin:20px 0;border-radius:0 4px 4px 0">
      <p style="margin:0;color:#004aad;font-weight:bold">✅ Configuração verificada com sucesso</p>
      <p style="margin:6px 0 0;font-size:13px;color:#555">
        Enviado em: ${dataHora} (Horário de Brasília)
      </p>
    </div>
    <p>Se você está recebendo este e-mail, o sistema de notificações por e-mail
    está configurado corretamente e funcionando.</p>
    <hr style="border:none;border-top:1px solid #eee;margin:20px 0">
    <p style="color:#999;font-size:12px;margin:0">
      Mensagem automática — sistema VISA · DVS Anápolis/GO<br>
      Não responda este e-mail.
    </p>
  </div>
</body></html>`
      });

      totalSucesso++;
      console.log(`  ✅ Enviado → ${dest.email}`);
    } catch (err) {
      totalErros++;
      console.error(`  ❌ Falha → ${dest.email}: ${err.message}`);
    }
  }

  console.log(`\n📤 Resultado:`);
  console.log(`  ✅ Enviados com sucesso : ${totalSucesso}`);
  console.log(`  ❌ Falhas               : ${totalErros}`);
  console.log('\n✅ Processo concluído.');
}

enviarEmailTeste().catch(err => {
  console.error('❌ Erro fatal:', err);
  process.exit(1);
});
