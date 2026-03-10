#!/usr/bin/env python3
"""
apply_sidebar_auth.py
Transforma as páginas COM autenticação Firebase para o layout com sidebar.

Diferenças em relação ao apply_sidebar.py (páginas sem auth):
- O #userInfo já existe na página e é populado pelo guard/guard1 — não criamos novo
- O botão de logout usa window.logout() que cada página já define, ou sidebarLogout()
- Não adicionamos o bloco de init Firebase do sidebar.js (guard já faz isso)
- Preservamos o mainContent/authOverlay existentes
"""
import os, re

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# ── Template do sidebar ───────────────────────────────────────────────────────
def make_sidebar(active_key):
    items = [
        ('dashboard',   'index.html',                    '📊', 'Dashboard',           ''),
        ('os',          'os.html',                       '📋', 'OS',                  'Operacional'),
        ('alvara',      'alvara.html',                   '🏦', 'Alvarás',             ''),
        ('cvs',         'cvs.html',                      '🏪', 'Regulados',           ''),
        ('rmpf',        'rmpf.html',                     '📚', 'RMPF',                'Relatórios'),
        ('inspecoes',   'inspecoes.html',                '👁️', 'Inspeções',           ''),
        ('relatorio',   'relatorio_plantao_fiscal.html', '📈', 'Ocorrências',         ''),
        ('indicadores', 'indicadores.html',              '📊', 'Indicadores',         ''),
        ('plantao',     'plantao.html',                  '📅', 'Plantão Fiscal',      'Escala'),
        ('veiculos',    'veiculos.html',                 '🚗', 'Veículos',            ''),
        ('ferias',      'ferias.html',                   '🏖️', 'Férias',              ''),
        ('legislacao',  'legislacao.html',               '📜', 'Legislação',          'Referência'),
        ('pop',         'pop.html',                      '🎯', 'POPs da VISA',        ''),
        ('check',       'check.html',                    '✅', 'Check Lists',         ''),
        ('areas',       'areas.html',                    '🧩', 'Áreas',               'Distribuição'),
        ('cnae',        'cnae.html',                     '👥', 'CNAEs',               ''),
        ('total',       'total.html',                    '🧮', 'Totalização',         ''),
        ('admin',       'admin.html',                    '⚙️', 'Painel Admin',        'Sistema'),
        ('sugestoes',   'mailto:visa@anapolis.go.gov.br','💡', 'Sugestões',           ''),
        ('changelog',   'changelog.html',                '📌', 'Novidades da versão', ''),
        ('readme',      'readme.html',                   '📄', 'Aviso Institucional', ''),
    ]
    nav_html = ''
    for key, href, icon, label, section in items:
        if section:
            nav_html += f'\n        <div class="nav-section-label">{section}</div>'
        active_cls = ' active' if key == active_key else ''
        nav_html += f'\n        <a class="visa-nav-item{active_cls}" href="{href}"><span class="nav-icon">{icon}</span> {label}</a>'

    return f'''    <!-- ════════════ SIDEBAR ════════════ -->
    <aside class="sidebar" id="sidebar" role="navigation" aria-label="Menu principal">
      <a class="sidebar__header" href="index.html">
        <div class="sidebar__logo" style="background:none;">
          <img src="icons/visa.png" style="width:36px;height:36px;border-radius:8px;object-fit:cover;" alt="VISA">
        </div>
        <div>
          <div class="sidebar__app-name">Vigilância Sanitária</div>
          <div class="sidebar__app-sub">Anápolis – GO</div>
        </div>
      </a>
      <nav class="sidebar__nav">{nav_html}
      </nav>
      <div class="sidebar__footer">
        <div class="sidebar__version">
          <span class="version-badge">v2.4.3</span>
          <span class="version-date">fev/2026</span>
        </div>
        <div id="userInfo" class="user-info-bar" style="padding:6px 0 8px;background:none;border:none;"></div>
        <button class="btn-logout-text" onclick="sidebarLogout()">↩ Encerrar sessão</button>
      </div>
    </aside>
    <!-- ════ FIM SIDEBAR ════ -->
    <div class="sidebar-overlay" id="sidebarOverlay" onclick="closeSidebar()"></div>'''

def make_topbar(title):
    return f'''      <!-- TOPBAR (mobile only) -->
      <header class="topbar">
        <button class="btn-hamburger" onclick="toggleSidebar()" aria-label="Abrir menu">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round">
            <line x1="3" y1="6"  x2="21" y2="6"/>
            <line x1="3" y1="12" x2="21" y2="12"/>
            <line x1="3" y1="18" x2="21" y2="18"/>
          </svg>
        </button>
        <span class="topbar__title">{title}</span>
      </header>'''

def make_page_header(title, subtitle):
    return f'''        <div class="page-header">
          <h1 class="page-title">{title}</h1>
          <p class="page-subtitle">{subtitle}</p>
        </div>'''

CSS_LINK   = '  <link rel="stylesheet" href="./css/sidebar.css">'
SIDEBAR_JS = '  <script src="./js/sidebar.js"></script>'

# Logout genérico: chama window.logout() se existir (guard/guard1 definem),
# senão usa sidebarLogout() do sidebar.js
LOGOUT_BRIDGE = '''  <script>
    // Ponte de logout: usa window.logout() da página se disponível,
    // senão usa sidebarLogout() do sidebar.js
    window.sidebarLogout = function() {
      if (typeof window.logout === 'function') {
        window.logout();
      } else {
        window.location.href = 'index.html';
      }
    };
  </script>'''

def transform_auth(filename, cfg):
    """
    Transforma uma página com autenticação para o layout com sidebar.
    Estratégia:
    1. Remove o <header class="app-header"> original
    2. Remove o <div id="userInfo" class="user-info-bar"> que estava fora do sidebar
       (o novo userInfo está dentro do sidebar__footer)
    3. Envolve o conteúdo no app-layout com sidebar
    4. Adiciona sidebar.css e sidebar.js
    5. Adiciona ponte de logout (sidebarLogout -> logout da página)
    """
    path = os.path.join(BASE, filename)
    with open(path, encoding='utf-8') as f:
        html = f.read()

    # 1. Adiciona class="with-sidebar" ao body
    html = re.sub(
        r'<body([^>]*)>',
        lambda m: f'<body{m.group(1)} class="with-sidebar">' if 'with-sidebar' not in m.group(1) else m.group(0),
        html, count=1
    )

    # 2. Adiciona link do sidebar.css antes de </head>
    if 'sidebar.css' not in html:
        html = html.replace('</head>', f'{CSS_LINK}\n</head>', 1)

    # 3. Remove o <header class="app-header">...</header> original
    html = re.sub(r'<header class="app-header">.*?</header>\s*', '', html, flags=re.DOTALL)

    # 4. Remove o <div id="userInfo" class="user-info-bar"...> que estava fora do sidebar
    #    (pode ter variações de atributos e conteúdo)
    html = re.sub(r'<div\s+id="userInfo"[^>]*>.*?</div>\s*', '', html, flags=re.DOTALL, count=1)

    # 5. Encontra o início do conteúdo após <body ...>
    body_match = re.search(r'<body[^>]*>', html)
    if not body_match:
        print(f"  ERRO: <body> não encontrado em {filename}")
        return

    body_end = body_match.end()

    # 6. Encontra o </body>
    body_close = html.rfind('</body>')
    if body_close == -1:
        print(f"  ERRO: </body> não encontrado em {filename}")
        return

    # 7. Extrai o conteúdo interno do body
    inner = html[body_end:body_close].strip()

    # 8. Monta o novo body
    sidebar = make_sidebar(cfg['active'])
    topbar  = make_topbar(cfg['topbar'])
    ph      = make_page_header(cfg['title'], cfg['sub'])

    new_body = f"""
  <div class="app-layout">

{sidebar}

    <!-- ════════════ MAIN AREA ════════════ -->
    <div class="main-area">

{topbar}

      <main class="page-content">
{ph}

{inner}

      </main><!-- /.page-content -->
    </div><!-- /.main-area -->
  </div><!-- /.app-layout -->

{SIDEBAR_JS}
{LOGOUT_BRIDGE}
"""

    # 9. Reconstrói o HTML
    new_html = html[:body_end] + new_body + '\n</body>\n</html>\n'

    # Remove </body></html> duplicado se existir
    new_html = re.sub(r'</body>\s*</html>\s*</body>\s*</html>', '</body>\n</html>', new_html)

    with open(path, 'w', encoding='utf-8') as f:
        f.write(new_html)

    print(f"  OK: {filename}")


# ── Configuração de cada página com autenticação ──────────────────────────────
PAGES_AUTH = {
    'os.html': {
        'active': 'os',
        'topbar': 'Ordens de Serviço',
        'title':  '📋 Consulta de Ordens de Serviço',
        'sub':    'Pesquisa e acompanhamento das ordens de serviço da Vigilância Sanitária.',
    },
    'cvs.html': {
        'active': 'cvs',
        'topbar': 'Histórico dos Regulados',
        'title':  '🏪 Histórico dos Regulados',
        'sub':    'Consulta do histórico de inspeções e ocorrências por estabelecimento regulado.',
    },
    'inspecoes.html': {
        'active': 'inspecoes',
        'topbar': 'Relatório de Inspeções',
        'title':  '👁️ Relatório de Inspeções',
        'sub':    'Consolidado de inspeções realizadas por fiscal e período.',
    },
    'rmpf.html': {
        'active': 'rmpf',
        'topbar': 'Relatório de Produção Fiscal',
        'title':  '📚 Relatório de Produção Fiscal',
        'sub':    'Indicadores de produção dos fiscais sanitários por período.',
    },
    'indicadores.html': {
        'active': 'indicadores',
        'topbar': 'Indicadores do Mês',
        'title':  '📊 Indicadores do Mês',
        'sub':    'Painel de indicadores mensais da Vigilância Sanitária de Anápolis.',
    },
    'areas.html': {
        'active': 'areas',
        'topbar': 'Áreas de Atuação',
        'title':  '🧩 Áreas de Atuação por Bairro',
        'sub':    'Distribuição dos bairros de Anápolis por equipe de fiscalização.',
    },
    'admin.html': {
        'active': 'admin',
        'topbar': 'Painel Administrativo',
        'title':  '⚙️ Painel Administrativo',
        'sub':    'Gerenciamento de usuários, perfis e configurações do sistema VISA.',
    },
}

if __name__ == '__main__':
    print("Aplicando layout sidebar nas páginas COM autenticação...")
    for fname, cfg in PAGES_AUTH.items():
        print(f"Processando {fname}...")
        try:
            transform_auth(fname, cfg)
        except Exception as e:
            import traceback
            print(f"  ERRO em {fname}: {e}")
            traceback.print_exc()
    print("\nConcluído!")
