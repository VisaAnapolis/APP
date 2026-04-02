/**
 * ─────────────────────────────────────────────────────────────
 * VISA APP - GERENCIAMENTO CENTRALIZADO DE VERSÃO *
 * ─────────────────────────────────────────────────────────────
 *
 * Arquivo único de verdade para versionamento da aplicação.
 * Altere aqui e a versão será refletida em TODAS as páginas.
 *
 * ⚠️  IMPORTANTE: Ao atualizar a versão aqui, atualize também:
 *    - changelog.html (adicione entrada da nova versão)
 *    - README ou documentação se necessário
 */

const APP_VERSION = '2.6.0';

// Preenche a versão e a data no sidebar de qualquer página
document.addEventListener('DOMContentLoaded', function() {
  const versionSpan = document.getElementById('appVersion');
  if (versionSpan) {
    versionSpan.textContent = APP_VERSION;
  }

  const meses = ['jan','fev','mar','abr','mai','jun','jul','ago','set','out','nov','dez'];
  const now = new Date();
  const dataFormatada = meses[now.getMonth()] + '/' + now.getFullYear();

  document.querySelectorAll('.version-date').forEach(function(el) {
    el.textContent = dataFormatada;
  });
});
