#!/usr/bin/env python3
"""
build_sidebar_pages.py
Gera o bloco HTML do sidebar e substitui nas páginas sem autenticação.
Uso: python3 scripts/build_sidebar_pages.py
"""

import os
import re

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# ── Bloco do sidebar (igual em todas as páginas) ──────────────────────────────
SIDEBAR_BLOCK = '''
    <!-- ════════════ SIDEBAR ════════════ -->
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
      <nav class="sidebar__nav">
        <a class="visa-nav-item{active_dashboard}" href="index.html"><span class="nav-icon">📊</span> Dashboard</a>
        <div class="nav-section-label">Operacional</div>
        <a class="visa-nav-item{active_os}" href="os.html"><span class="nav-icon">📋</span> OS</a>
        <a class="visa-nav-item{active_alvara}" href="alvara.html"><span class="nav-icon">🏦</span> Alvarás</a>
        <a class="visa-nav-item{active_cvs}" href="cvs.html"><span class="nav-icon">🏪</span> Regulados</a>
        <div class="nav-section-label">Relatórios</div>
        <a class="visa-nav-item{active_rmpf}" href="rmpf.html"><span class="nav-icon">📚</span> RMPF</a>
        <a class="visa-nav-item{active_inspecoes}" href="inspecoes.html"><span class="nav-icon">👁️</span> Inspeções</a>
        <a class="visa-nav-item{active_relatorio}" href="relatorio_plantao_fiscal.html"><span class="nav-icon">📈</span> Ocorrências</a>
        <a class="visa-nav-item{active_indicadores}" href="indicadores.html"><span class="nav-icon">📊</span> Indicadores</a>
        <div class="nav-section-label">Escala</div>
        <a class="visa-nav-item{active_plantao}" href="plantao.html"><span class="nav-icon">📅</span> Plantão Fiscal</a>
        <a class="visa-nav-item{active_veiculos}" href="veiculos.html"><span class="nav-icon">🚗</span> Veículos</a>
        <a class="visa-nav-item{active_ferias}" href="ferias.html"><span class="nav-icon">🏖️</span> Férias</a>
        <div class="nav-section-label">Referência</div>
        <a class="visa-nav-item{active_legislacao}" href="legislacao.html"><span class="nav-icon">📜</span> Legislação</a>
        <a class="visa-nav-item{active_pop}" href="pop.html"><span class="nav-icon">🎯</span> POPs da VISA</a>
        <a class="visa-nav-item{active_check}" href="check.html"><span class="nav-icon">✅</span> Check Lists</a>
        <div class="nav-section-label">Distribuição</div>
        <a class="visa-nav-item{active_areas}" href="areas.html"><span class="nav-icon">🧩</span> Áreas</a>
        <a class="visa-nav-item{active_cnae}" href="cnae.html"><span class="nav-icon">👥</span> CNAEs</a>
        <a class="visa-nav-item{active_total}" href="total.html"><span class="nav-icon">🧮</span> Totalização</a>
        <div class="nav-section-label">Sistema</div>
        <a class="visa-nav-item{active_admin}" href="admin.html"><span class="nav-icon">⚙️</span> Painel Admin</a>
        <a class="visa-nav-item" href="mailto:visa@anapolis.go.gov.br"><span class="nav-icon">💡</span> Sugestões</a>
        <a class="visa-nav-item{active_changelog}" href="changelog.html"><span class="nav-icon">📌</span> Novidades da versão</a>
        <a class="visa-nav-item{active_readme}" href="readme.html"><span class="nav-icon">📄</span> Aviso Institucional</a>
      </nav>
      <div class="sidebar__footer">
        <div class="sidebar__version">
          <span class="version-badge">v2.4.3</span>
          <span class="version-date">fev/2026</span>
        </div>
      </div>
    </aside>
    <!-- ════ FIM SIDEBAR ════ -->
    <!-- Overlay mobile -->
    <div class="sidebar-overlay" id="sidebarOverlay" onclick="closeSidebar()"></div>'''

# ── Mapeamento página → chave ativa ──────────────────────────────────────────
PAGE_ACTIVE = {
    'index.html':                    'dashboard',
    'os.html':                       'os',
    'alvara.html':                   'alvara',
    'cvs.html':                      'cvs',
    'rmpf.html':                     'rmpf',
    'inspecoes.html':                'inspecoes',
    'relatorio_plantao_fiscal.html': 'relatorio',
    'indicadores.html':              'indicadores',
    'plantao.html':                  'plantao',
    'veiculos.html':                 'veiculos',
    'ferias.html':                   'ferias',
    'legislacao.html':               'legislacao',
    'pop.html':                      'pop',
    'check.html':                    'check',
    'areas.html':                    'areas',
    'cnae.html':                     'cnae',
    'total.html':                    'total',
    'admin.html':                    'admin',
    'changelog.html':                'changelog',
    'readme.html':                   'readme',
}

def make_sidebar(page_filename):
    active_key = PAGE_ACTIVE.get(page_filename, '')
    keys = ['dashboard','os','alvara','cvs','rmpf','inspecoes','relatorio',
            'indicadores','plantao','veiculos','ferias','legislacao','pop',
            'check','areas','cnae','total','admin','changelog','readme']
    replacements = {f'{{active_{k}}}': ' active' if k == active_key else '' for k in keys}
    block = SIDEBAR_BLOCK
    for placeholder, value in replacements.items():
        block = block.replace(placeholder, value)
    return block

def build_topbar(title):
    return f'''
      <!-- TOPBAR (mobile only) -->
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

# ── Configurações por página ──────────────────────────────────────────────────
PAGES = {
    'cnae.html': {
        'topbar_title': 'CNAEs por Equipe',
        'page_title': '👥 Cadastro Econômico por Equipe',
        'page_subtitle': 'Atividades econômicas (CNAEs) distribuídas por equipe de fiscalização.',
    },
    'pop.html': {
        'topbar_title': 'POPs da VISA',
        'page_title': '🎯 Lista Mestra de POPs',
        'page_subtitle': 'Procedimentos Operacionais Padrão da Vigilância Sanitária — GVS V.09.',
    },
    'plantao.html': {
        'topbar_title': 'Escala de Plantão',
        'page_title': '📅 Escala de Plantão Fiscal',
        'page_subtitle': 'Consulta e gestão da escala de plantão dos fiscais sanitários.',
    },
    'alvara.html': {
        'topbar_title': 'Alvarás Sanitários',
        'page_title': '🏦 Consulta de Alvarás Sanitários',
        'page_subtitle': 'Pesquisa de alvarás emitidos pela Vigilância Sanitária Municipal.',
    },
    'total.html': {
        'topbar_title': 'Totalização',
        'page_title': '🧮 Relatório Oficial – Regulados por Área',
        'page_subtitle': 'Estabelecimentos de alta complexidade distribuídos por área de atuação.',
    },
    'relatorio_plantao_fiscal.html': {
        'topbar_title': 'Relatório de Plantão',
        'page_title': '📈 Relatório de Plantão Fiscal',
        'page_subtitle': 'Registro das ocorrências e atividades realizadas durante o plantão fiscal.',
    },
}

print("Script de configuração carregado.")
print("Páginas configuradas:", list(PAGES.keys()))
print("Total de páginas no mapa:", len(PAGE_ACTIVE))
