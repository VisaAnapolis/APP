// ============================================================
// test-notify.js — Envia notificação de teste para todos os
// usuários com token FCM registrado no Firestore.
//
// Usa apenas o campo "data" (sem "notification") para forçar
// o Service Worker a exibir a notificação — mesmo padrão do
// notify-os.js, evitando a mensagem genérica do Android.
// ============================================================

const fs    = require('fs');
const path  = require('path');
const admin = require('firebase-admin');

// Aceita service account via variável de ambiente (GitHub Actions)
// ou arquivo local (execução manual)
const serviceAccountPath = process.env.FIREBASE_SERVICE_ACCOUNT_PATH
  || path.join(__dirname, '..', 'firebase-service-account.json');

const serviceAccount = JSON.parse(fs.readFileSync(serviceAccountPath, 'utf8'));

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db        = admin.firestore();
const messaging = admin.messaging();

async function enviarNotificacaoTeste() {
  console.log('🚀 VISA Test Notifier — iniciando...');

  try {
    const snap = await db.collection('usuarios').get();

    if (snap.empty) {
      console.log('Nenhum usuário encontrado no Firestore.');
      return;
    }

    // Coleta todos os tokens (envia para todos, independente de opt-in)
    const tokensPorUsuario = [];
    snap.forEach(doc => {
      const data = doc.data();
      const tokens = (data.fcmTokens || []).filter(t => t && typeof t === 'string' && t.length > 20);
      if (tokens.length > 0) {
        tokensPorUsuario.push({ email: doc.id, nome: data.nome || doc.id, tokens });
      }
    });

    const totalTokens = tokensPorUsuario.reduce((s, u) => s + u.tokens.length, 0);

    if (totalTokens === 0) {
      console.log('Nenhum token FCM encontrado.');
      return;
    }

    console.log(`📱 ${totalTokens} token(s) em ${tokensPorUsuario.length} usuário(s). Enviando...\n`);

    // Mostra detalhe por usuário
    tokensPorUsuario.forEach(u => {
      console.log(`  👤 ${u.email} — ${u.tokens.length} token(s)`);
    });

    console.log('');

    // Usa apenas campo "data" — o Service Worker (firebase-messaging-sw.js)
    // é responsável por exibir a notificação, evitando mensagem genérica do Android.
    const mensagem = {
      data: {
        title: '🔔 Notificação de Teste VISA',
        body:  'Esta é uma notificação de teste enviada pelo sistema VISA.',
        url:   'https://garrado.github.io/VISA/index.html',
        tipo:  'teste'
      },
      webpush: {
        headers: { Urgency: 'high' },
        fcmOptions: {
          link: 'https://garrado.github.io/VISA/index.html'
        }
      }
    };

    // Junta todos os tokens em um único multicast (máx 500 por lote)
    const todosTokens = tokensPorUsuario.flatMap(u => u.tokens);
    const LOTE = 500;
    let totalSucesso = 0, totalFalha = 0;
    const tokensInvalidos = [];

    for (let i = 0; i < todosTokens.length; i += LOTE) {
      const lote = todosTokens.slice(i, i + LOTE);
      const resp = await messaging.sendEachForMulticast({ ...mensagem, tokens: lote });
      totalSucesso += resp.successCount;
      totalFalha   += resp.failureCount;

      resp.responses.forEach((r, idx) => {
        if (!r.success) {
          const code = r.error?.code || '';
          console.warn(`  ❌ Token inválido [${code}]: ${lote[idx].substring(0, 20)}...`);
          if (
            code === 'messaging/registration-token-not-registered' ||
            code === 'messaging/invalid-registration-token'
          ) {
            tokensInvalidos.push(lote[idx]);
          }
        }
      });
    }

    console.log(`\n📤 Resultado:`);
    console.log(`  ✅ Enviados com sucesso: ${totalSucesso}`);
    console.log(`  ❌ Falhas: ${totalFalha}`);

    // Remove tokens inválidos do Firestore
    if (tokensInvalidos.length > 0) {
      console.log(`\n🧹 Removendo ${tokensInvalidos.length} token(s) inválido(s)...`);
      const batch = db.batch();
      let alteracoes = 0;
      snap.forEach(doc => {
        const tokens = doc.data().fcmTokens || [];
        const filtrados = tokens.filter(t => !tokensInvalidos.includes(t));
        if (filtrados.length !== tokens.length) {
          batch.update(doc.ref, { fcmTokens: filtrados });
          alteracoes++;
        }
      });
      if (alteracoes > 0) {
        await batch.commit();
        console.log(`  ✅ Tokens inválidos removidos de ${alteracoes} usuário(s).`);
      }
    }

    console.log('\n✅ Processo concluído.');
  } catch (err) {
    console.error('❌ Erro:', err.message);
    process.exit(1);
  }
}

enviarNotificacaoTeste();
