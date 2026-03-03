/**
 * ─────────────────────────────────────────────────────────────
 * VISA APP - GERENCIAMENTO CENTRALIZADO DE VERSÃO
 * ─────────────────────────────────────────────────────────────
 *
 * Arquivo único de verdade para versionamento da aplicação.
 * Altere aqui e a versão será refletida em TODAS as páginas.
 *
 * ⚠️  IMPORTANTE: Ao atualizar a versão aqui, atualize também:
 *    - changelog.html (adicione entrada da nova versão)
 *    - README ou documentação se necessário
 */

const APP_VERSION = '2.4.6';

// Preenche a versão no sidebar de qualquer página
document.addEventListener('DOMContentLoaded', function() {
  const versionSpan = document.getElementById('appVersion');
  if (versionSpan) {
    versionSpan.textContent = APP_VERSION;
  }
});
