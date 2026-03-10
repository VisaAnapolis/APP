/**
 * SIDEBAR.JS — Menu lateral compartilhado
 * VISA Anápolis — v2.4.3+
 *
 * Funções: toggleSidebar, closeSidebar, markActiveNavItem
 * Inclua no final do <body> de cada página que usa o layout com sidebar.
 *
 * Nas páginas SEM autenticação (legislacao, readme, check, etc.) este script
 * tenta ler o usuário logado via Firebase para exibir nome/e-mail/perfil no
 * rodapé do sidebar. Se não houver sessão ativa, exibe "Visitante".
 */

/* ── Abrir/fechar sidebar (mobile) ─────────────────────────────────────── */
function toggleSidebar() {
  var s = document.getElementById('sidebar');
  var o = document.getElementById('sidebarOverlay');
  var open = s.classList.toggle('open');
  o.classList.toggle('active', open);
  document.body.style.overflow  = open ? 'hidden' : '';
  document.body.style.position  = open ? 'fixed'  : '';
  document.body.style.width     = open ? '100%'   : '';

  // Ao abrir, rola até o item ativo para o usuário não perder a posição
  if (open) {
    var ativo = s.querySelector('.visa-nav-item.active');
    if (ativo) ativo.scrollIntoView({ block: 'center', behavior: 'smooth' });
  }
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

/* ── Marca item ativo no menu ───────────────────────────────────────────── */
function markActiveNavItem() {
  var current = window.location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('.sidebar .visa-nav-item').forEach(function(el) {
    el.classList.remove('active');
    var href = (el.getAttribute('href') || '').split('/').pop().split('?')[0];
    if (href === current) el.classList.add('active');
  });
}

/* ── Popula o bloco de usuário no rodapé do sidebar ────────────────────── */
function sidebarSetUser(nome, email, grupo) {
  var el = document.getElementById('userInfo');
  if (!el) return;

  var badgeColor = grupo === 'Administrador' ? '#2c5aa0'
                 : grupo === 'Fiscal'        ? '#16a34a'
                 : grupo === 'Administrativo'? '#7c3aed'
                 : '#64748b';
  var badgeHtml = grupo
    ? '<span style="display:inline-block;font-size:.65rem;font-weight:700;padding:1px 7px;border-radius:20px;background:' + badgeColor + '20;color:' + badgeColor + ';border:1px solid ' + badgeColor + '40;margin-top:3px">' + grupo + '</span>'
    : '';

  el.innerHTML =
    '<span class="user-name">' + (nome || 'Usuário') + '</span>' +
    '<span class="user-email">' + (email || '') + '</span>' +
    badgeHtml;
}

function sidebarSetUserLoading(email) {
  var el = document.getElementById('userInfo');
  if (!el) return;
  el.innerHTML =
    '<span class="user-name">Carregando...</span>' +
    (email ? '<span class="user-email">' + email + '</span>' : '');
}

function sidebarSetUserAnon() {
  var el = document.getElementById('userInfo');
  if (!el) return;
  el.innerHTML = '<span class="user-name" style="color:#94a3b8;font-style:italic">Não autenticado</span>';
}

/* ── Permissões de links por perfil ─────────────────────────────────────── */
// Links restritos por grupo (identificados pelo href, sem precisar de IDs)
var _RESTR_FISCAL_ADMIN = ['rmpf.html', 'inspecoes.html', 'comply.html'];
var _RESTR_APENAS_ADMIN  = ['admin.html', 'indicadores.html'];

function _sidebarLink(href) {
  return document.querySelector('.sidebar .visa-nav-item[href="' + href + '"]');
}
function _disableSidebarLink(href, motivo) {
  var a = _sidebarLink(href);
  if (!a) return;
  a.classList.add('is-disabled');
  a.setAttribute('aria-disabled', 'true');
  if (motivo) a.setAttribute('title', motivo);
}
function _enableSidebarLink(href) {
  var a = _sidebarLink(href);
  if (!a) return;
  a.classList.remove('is-disabled');
  a.removeAttribute('aria-disabled');
  a.removeAttribute('title');
}
function _bloquearLinksAtePerfil() {
  _RESTR_FISCAL_ADMIN.forEach(function(h) { _disableSidebarLink(h, 'Carregando perfil...'); });
  _RESTR_APENAS_ADMIN.forEach(function(h) { _disableSidebarLink(h, 'Carregando perfil...'); });
}
function sidebarAplicarPermissoes(grupo) {
  if (grupo === 'Fiscal' || grupo === 'Administrador') {
    _RESTR_FISCAL_ADMIN.forEach(function(h) { _enableSidebarLink(h); });
  } else {
    _RESTR_FISCAL_ADMIN.forEach(function(h) { _disableSidebarLink(h, 'Acesso conforme perfil'); });
  }
  if (grupo === 'Administrador') {
    _RESTR_APENAS_ADMIN.forEach(function(h) { _enableSidebarLink(h); });
  } else {
    _RESTR_APENAS_ADMIN.forEach(function(h) { _disableSidebarLink(h, 'Exclusivo para Administrador'); });
  }
}

/* ── Logout ─────────────────────────────────────────────────────────────── */
window.sidebarLogout = function() {
  if (window.__sidebarAuth) {
    import('https://www.gstatic.com/firebasejs/10.12.0/firebase-auth.js')
      .then(function(m) { m.signOut(window.__sidebarAuth).catch(console.error); })
      .catch(console.error);
  }
  // Redireciona para index em qualquer caso
  window.location.href = 'index.html';
};

/* ── Inicialização Firebase (leve, só Auth) ─────────────────────────────── */
(function initSidebarAuth() {
  // Evita dupla inicialização se a página já tem Firebase (páginas com guard)
  if (window.__sidebarAuthInitialized) return;
  window.__sidebarAuthInitialized = true;

  // Configuração Firebase — mesma do index.html
  var firebaseConfig = {
    apiKey: "AIzaSyDo473puJesZ9rr3IBoX5AWczCIMuKBTrg",
    authDomain: "visam-3a30b.firebaseapp.com",
    projectId: "visam-3a30b",
    messagingSenderId: "308899251430",
    appId: "1:308899251430:web:0053cdbd0bed7f0de76727"
  };

  Promise.all([
    import('https://www.gstatic.com/firebasejs/10.12.0/firebase-app.js'),
    import('https://www.gstatic.com/firebasejs/10.12.0/firebase-auth.js')
  ]).then(function(modules) {
    var firebaseApp = modules[0];
    var firebaseAuth = modules[1];

    // Reutiliza app já inicializado se existir (evita erro "already initialized")
    var app;
    try {
      app = firebaseApp.getApp();
    } catch(e) {
      app = firebaseApp.initializeApp(firebaseConfig);
    }

    var auth = firebaseAuth.getAuth(app);
    window.__sidebarAuth = auth;

    firebaseAuth.onAuthStateChanged(auth, function(user) {
      var managed = !!window.__sidebarUserManaged;
      if (!user) {
        if (!managed) sidebarSetUserAnon();
        return;
      }
      // Usuário logado: exibe imediatamente com dados básicos (só se a página não gerencia)
      if (!managed) sidebarSetUserLoading(user.email);

      // Tenta buscar perfil no Firestore para exibir nome e grupo
      // Sempre aplica permissões, mesmo quando a página gerencia o #userInfo
      import('https://www.gstatic.com/firebasejs/10.12.0/firebase-firestore.js')
        .then(function(fs) {
          var db = fs.getFirestore(app);
          var emailNorm = (user.email || '').toLowerCase().trim();
          return fs.getDoc(fs.doc(db, 'usuarios', emailNorm));
        })
        .then(function(snap) {
          var perfil = snap.exists() ? snap.data() : null;
          var grupo = (perfil && perfil.grupo) || '';
          if (!managed) {
            var nome = (perfil && perfil.nome) || user.displayName || 'Usuário';
            sidebarSetUser(nome, user.email, grupo);
          }
          sidebarAplicarPermissoes(grupo);
        })
        .catch(function() {
          // Firestore falhou — libera todos os links como fallback
          if (!managed) sidebarSetUser(user.displayName || 'Usuário', user.email, '');
          sidebarAplicarPermissoes('');
        });
    });
  }).catch(function(err) {
    console.warn('[sidebar.js] Firebase não carregou:', err);
    sidebarSetUserAnon();
  });
})();

/* ── DOMContentLoaded ───────────────────────────────────────────────────── */
document.addEventListener('DOMContentLoaded', function () {
  // Bloqueia links restritos imediatamente enquanto o perfil não carrega
  _bloquearLinksAtePerfil();

  // Fecha sidebar ao clicar em item (mobile)
  document.querySelectorAll('.sidebar .visa-nav-item').forEach(function(el) {
    el.addEventListener('click', function () {
      if (window.innerWidth <= 768) closeSidebar();
    });
  });

  // Marca item ativo e rola sidebar até ele (desktop: sidebar sempre visível)
  markActiveNavItem();
  var sEl = document.getElementById('sidebar');
  var itemAtivo = sEl && sEl.querySelector('.visa-nav-item.active');
  if (sEl && itemAtivo) itemAtivo.scrollIntoView({ block: 'center' });
});
