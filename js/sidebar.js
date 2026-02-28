/**
 * SIDEBAR.JS — Menu lateral compartilhado
 * VISA Anápolis — v2.4.3+
 *
 * Funções: toggleSidebar, closeSidebar, markActiveNavItem
 * Inclua no final do <body> de cada página que usa o layout com sidebar.
 */

function toggleSidebar() {
  var s = document.getElementById('sidebar');
  var o = document.getElementById('sidebarOverlay');
  var open = s.classList.toggle('open');
  o.classList.toggle('active', open);
  document.body.style.overflow  = open ? 'hidden' : '';
  document.body.style.position  = open ? 'fixed'  : '';
  document.body.style.width     = open ? '100%'   : '';
}

function closeSidebar() {
  var s = document.getElementById('sidebar');
  var o = document.getElementById('sidebarOverlay');
  if (!s || !o) return;
  s.classList.remove('open');
  o.classList.remove('active');
  document.body.style.overflow = '';
  document.body.style.position = '';
  document.body.style.width    = '';
}

/**
 * Marca o item ativo no menu com base na URL atual.
 * Chame após o DOM carregar, ou deixe o DOMContentLoaded abaixo cuidar disso.
 */
function markActiveNavItem() {
  var current = window.location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('.sidebar .visa-nav-item').forEach(function(el) {
    el.classList.remove('active');
    var href = (el.getAttribute('href') || '').split('/').pop().split('?')[0];
    if (href === current) {
      el.classList.add('active');
    }
  });
}

document.addEventListener('DOMContentLoaded', function () {
  // Fecha sidebar ao clicar em item (mobile)
  document.querySelectorAll('.sidebar .visa-nav-item').forEach(function(el) {
    el.addEventListener('click', function () {
      if (window.innerWidth <= 768) closeSidebar();
    });
  });

  // Marca item ativo automaticamente
  markActiveNavItem();
});
