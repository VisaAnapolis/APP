#!/usr/bin/env node
/**
 * Script ONE-SHOT: corrige usuários com notificationOptIn === true mas SEM token FCM.
 * Esses usuários ficaram nesse estado por bug antigo (opt-in era gravado antes do getToken).
 *
 * Ação: seta notificationOptIn = false nesses documentos.
 * Efeito: no próximo login o modal de opt-in volta a aparecer; ao clicar "Sim", o token
 * será obtido e gravado junto com o opt-in (lógica corrigida na v2.3.2).
 *
 * Quem JÁ tem fcmTokens não é alterado.
 *
 * Uso:
 *   node scripts/fix-optin-without-token.js          # apenas lista (dry-run)
 *   node scripts/fix-optin-without-token.js --apply  # aplica as correções
 */

const admin = require("firebase-admin");
const path = require("path");

const serviceAccountPath = path.join(__dirname, "..", "firebase-service-account.json");
const serviceAccount = require(serviceAccountPath);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

async function main() {
  const apply = process.argv.includes("--apply");

  console.log("Buscando usuários com notificationOptIn === true e sem fcmTokens...\n");

  const usersRef = db.collection("usuarios");
  const snapshot = await usersRef.get();

  const toFix = [];
  snapshot.forEach((doc) => {
    const data = doc.data();
    const optIn = data.notificationOptIn;
    const tokens = data.fcmTokens;
    const hasTokens = Array.isArray(tokens) && tokens.length > 0;

    if (optIn === true && !hasTokens) {
      toFix.push({
        id: doc.id,
        nome: data.nome || "(sem nome)",
        email: data.email || doc.id,
      });
    }
  });

  if (toFix.length === 0) {
    console.log("Nenhum usuário inconsistente encontrado. Nada a fazer.");
    process.exit(0);
    return;
  }

  console.log(`Encontrados ${toFix.length} usuário(s) com opt-in true e sem token:\n`);
  toFix.forEach((u) => console.log(`  - ${u.email} (${u.nome})`));
  console.log("");

  if (!apply) {
    console.log("Modo dry-run. Para aplicar as correções, execute:");
    console.log("  node scripts/fix-optin-without-token.js --apply\n");
    process.exit(0);
    return;
  }

  console.log("Aplicando notificationOptIn = false nos documentos acima...\n");
  const batch = db.batch();
  for (const u of toFix) {
    const ref = usersRef.doc(u.id);
    batch.update(ref, { notificationOptIn: false });
  }
  await batch.commit();
  console.log(`Pronto. ${toFix.length} documento(s) atualizado(s).`);
  console.log("No próximo login, o modal de notificações será exibido novamente para esses usuários.\n");
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
