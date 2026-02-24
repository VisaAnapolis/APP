const admin = require('firebase-admin');
const serviceAccount = require('../firebase-service-account.json');
const { getFirestore } = require('firebase-admin/firestore');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = getFirestore();

async function sendTestNotification() {
  console.log('Iniciando envio de notificação de teste...');

  try {
    const usersRef = db.collection('usuarios');
    const snapshot = await usersRef.get();

    if (snapshot.empty) {
      console.log('Nenhum usuário encontrado no Firestore.');
      return;
    }

    let tokens = [];
    snapshot.forEach(doc => {
      const userData = doc.data();
      if (userData.fcmTokens && Array.isArray(userData.fcmTokens)) {
        tokens = tokens.concat(userData.fcmTokens);
      }
    });

    if (tokens.length === 0) {
      console.log('Nenhum token FCM encontrado para os usuários.');
      return;
    }

    console.log(`Total de ${tokens.length} tokens encontrados. Enviando notificação...`);

    const message = {
      notification: {
        title: '🔔 Notificação de Teste VISA',
        body: 'Esta é uma notificação de teste enviada pelo sistema VISA.'
      },
      webpush: {
        headers: {
          Urgency: 'high'
        },
        notification: {
          icon: 'https://garrado.github.io/VISA/icons/visa-192.png',
          badge: 'https://garrado.github.io/VISA/icons/badge.png'
        }
      },
      tokens: tokens
    };

    const response = await admin.messaging().sendEachForMulticast(message);

    console.log('Notificação de teste enviada com sucesso:');
    console.log(`  Sucesso: ${response.successCount}`);
    console.log(`  Falha: ${response.failureCount}`);

    if (response.failureCount > 0) {
      response.responses.forEach((resp, idx) => {
        if (!resp.success) {
          console.error(`  Falha no token ${tokens[idx]}: ${resp.exception.message}`);
        }
      });
    }

    // Limpar tokens inválidos (opcional, mas boa prática)
    const invalidTokens = response.responses
      .filter(resp => !resp.success && resp.exception.message.includes('messaging/registration-token-not-registered'))
      .map((_, idx) => tokens[idx]);

    if (invalidTokens.length > 0) {
      console.log(`Removendo ${invalidTokens.length} tokens inválidos do Firestore...`);
      // Implementar lógica para remover tokens inválidos do Firestore, se necessário
      // Exemplo: iterar sobre usuários e remover o token específico
    }

  } catch (error) {
    console.error('Erro ao enviar notificação de teste:', error);
  }
}

sendTestNotification();
