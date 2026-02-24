const admin = require("firebase-admin");
const serviceAccount = require("../firebase-service-account.json");
const { getFirestore } = require("firebase-admin/firestore");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = getFirestore();

async function listUsersWithFcmTokens() {
  console.log("Buscando usuários com tokens FCM...");

  try {
    const usersRef = db.collection("usuarios");
    const snapshot = await usersRef.get();

    if (snapshot.empty) {
      console.log("Nenhum usuário encontrado no Firestore.");
      return;
    }

    const usersWithTokens = [];
    snapshot.forEach((doc) => {
      const userData = doc.data();
      if (userData.fcmTokens && Array.isArray(userData.fcmTokens) && userData.fcmTokens.length > 0) {
        usersWithTokens.push({ nome: userData.nome, email: userData.email, tokenCount: userData.fcmTokens.length });
      }
    });

    if (usersWithTokens.length === 0) {
      console.log("Nenhum usuário com tokens FCM ativos encontrado.");
    } else {
      console.log("Usuários com tokens FCM ativos:");
      usersWithTokens.forEach((user) => {
        console.log(`- Nome: ${user.nome || 'N/A'}, Email: ${user.email || 'N/A'}, Tokens: ${user.tokenCount}`);
      });
    }
  } catch (error) {
    console.error("Erro ao listar usuários com tokens FCM:", error);
  }
}

listUsersWithFcmTokens();
