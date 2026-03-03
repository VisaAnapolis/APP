// ============================================================
// reset-optin-sem-token.js  —  Script de manutenção pontual
//
// Finalidade:
//   Localiza usuários com notificationOptIn=true mas sem nenhum
//   fcmToken válido e apaga o campo notificationOptIn deles.
//   Efeito: na próxima vez que abrirem o app o modal de opt-in
//   reaparece, dando nova chance de gerar o token corretamente.
//
// Uso:
//   cd .github/scripts
//   FIREBASE_SERVICE_ACCOUNT_PATH=./service-account.json node reset-optin-sem-token.js
//
// Flags:
//   --dry-run   Apenas lista quem seria afetado, sem gravar nada.
// ============================================================

const fs   = require('fs');
const path = require('path');

const admin = require('firebase-admin');

// ── Inicialização ────────────────────────────────────────────
const serviceAccountPath = process.env.FIREBASE_SERVICE_ACCOUNT_PATH
  || path.join(__dirname, 'service-account.json');

const serviceAccount = JSON.parse(fs.readFileSync(serviceAccountPath, 'utf8'));

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db     = admin.firestore();
const DRY_RUN = process.argv.includes('--dry-run');

// ── Função auxiliar ──────────────────────────────────────────
function tokenValido(t) {
  return t && typeof t === 'string' && t.length > 20;
}

// ── Main ─────────────────────────────────────────────────────
async function main() {
  console.log('='.repeat(60));
  console.log('reset-optin-sem-token.js');
  console.log(DRY_RUN ? '  MODO DRY-RUN — nada será gravado' : '  MODO REAL — Firestore será atualizado');
  console.log('='.repeat(60));

  const snapshot = await db.collection('usuarios').get();

  const afetados  = [];
  const ignorados = [];

  snapshot.forEach(doc => {
    const data = doc.data();
    const email = doc.id;

    // Interessa apenas quem tem optIn=true
    if (data.notificationOptIn !== true) return;

    const tokens = (data.fcmTokens || []).filter(tokenValido);

    if (tokens.length === 0) {
      afetados.push({ email, nome: data.nome || '—', ativo: data.ativo !== false });
    } else {
      ignorados.push({ email, tokens: tokens.length });
    }
  });

  // ── Relatório ────────────────────────────────────────────────
  console.log('\n--- Usuários com optIn=true e tokens válidos (serão IGNORADOS) ---');
  if (ignorados.length === 0) {
    console.log('  Nenhum.');
  } else {
    ignorados.forEach(u => console.log(`  OK  ${u.email}  (${u.tokens} token(s))`));
  }

  console.log(`\n--- Usuários com optIn=true e SEM token (${afetados.length} afetados) ---`);
  if (afetados.length === 0) {
    console.log('  Nenhum. Nada a fazer.');
    process.exit(0);
  }

  afetados.forEach(u => {
    const status = u.ativo ? 'ativo' : 'INATIVO';
    console.log(`  RESET  ${u.email}  (${u.nome}, ${status})`);
  });

  if (DRY_RUN) {
    console.log('\n[DRY-RUN] Nenhuma alteração foi gravada.');
    console.log('          Execute sem --dry-run para aplicar.');
    process.exit(0);
  }

  // ── Aplicar reset ────────────────────────────────────────────
  console.log('\nAplicando reset...');
  let ok = 0;
  let erros = 0;

  for (const u of afetados) {
    try {
      await db.collection('usuarios').doc(u.email).update({
        notificationOptIn: admin.firestore.FieldValue.delete()
      });
      console.log(`  [OK]    ${u.email}`);
      ok++;
    } catch (e) {
      console.error(`  [ERRO]  ${u.email}: ${e.message}`);
      erros++;
    }
  }

  console.log('\n' + '='.repeat(60));
  console.log(`Concluído: ${ok} resetados, ${erros} erros.`);
  console.log('Na próxima abertura do app o modal de opt-in reaparecerá');
  console.log('para esses usuários.');
  console.log('='.repeat(60));
}

main().catch(e => {
  console.error('Erro fatal:', e.message);
  process.exit(1);
});
