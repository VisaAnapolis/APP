# Projeto de Excelência Unificado — VISA Anápolis

**Autor:** Claude Code (Opus 4.6)
**Data:** 04 de Março de 2026
**Versão:** 1.0
**Base:** Fusão dos projetos `PROJETO_PADRONIZACAO_VISA.md` + `projeto-sidebar-colapsavel.md`

---

## Sumário Executivo

Este documento unifica dois projetos complementares num único roteiro à prova de erros:

| Projeto Original | Objetivo | Status Atual |
|---|---|---|
| **Padronização do Layout** | Aplicar sidebar + layout `app-layout` em todas as 24 páginas | Parcialmente implementado (~60% das páginas) |
| **Sidebar Colapsável** | Seções com accordion (expand/collapse) na navegação | Não iniciado |

**Insight principal:** A ordem de execução é crítica. Implementar o colapsável *antes* de propagar evita retrabalho. Propagar *depois* garante que todas as páginas já recebam a versão final.

---

## Diagnóstico do Estado Atual

### O que já existe e funciona

| Componente | Arquivo | Estado |
|---|---|---|
| Template de referência | `includes/sidebar-nav.html` | Completo, 22 itens, 6 seções |
| CSS da sidebar | `css/sidebar.css` | Maduro (401 linhas), responsivo, dark mode |
| JS da sidebar | `js/sidebar.js` | Completo (168 linhas), Firebase integrado |
| Script de propagação (sem auth) | `scripts/apply_sidebar.py` | Funcional, 6 páginas configuradas |
| Script de propagação (com auth) | `scripts/apply_sidebar_auth.py` | Existe |
| Build em lote | `scripts/build_sidebar_pages.py` | Existe |
| Página modelo | `index.html` | Layout completo implementado |

### O que NÃO existe (proposto pelo Projeto Padronização, mas desnecessário)

| Proposta Original | Decisão | Motivo |
|---|---|---|
| `component-loader.js` | **Descartado** | GitHub Pages é estático; fetch dinâmico de HTML fragmenta o carregamento, causa FOUC (flash de conteúdo sem estilo) e prejudica SEO/performance. Scripts Python de propagação resolvem melhor. |
| `main-layout.html` (template) | **Descartado** | Sem servidor/build tool, um template HTML não tem utilidade prática. O `includes/sidebar-nav.html` já serve como fonte da verdade. |
| `sidebar.html` / `header.html` (fragmentos) | **Descartado** | Mesma razão — sem include server-side ou build step, fragmentos HTML não são carregáveis de forma confiável. |
| Unificação `guard.js` + `guard1.js` | **Adiado** | Risco alto, escopo separado. Não é pré-requisito para nenhum dos dois projetos. Pode ser tratado num projeto futuro dedicado. |

### Decisão Arquitetural

> **Manter a abordagem atual**: sidebar copiada em cada HTML, propagada por scripts Python.
> É a abordagem mais robusta para um site estático sem build step. Evita problemas de CORS, FOUC, e dependência de fetch em runtime.

---

## Roteiro de Execução (4 Fases)

### Visão Geral

```
FASE 1 ──→ FASE 2 ──→ FASE 3 ──→ FASE 4
Colapsável   Propagar    Validar    Polimento
(template)   (todas)     (QA)       (edge cases)
```

---

### FASE 1 — Sidebar Colapsável (Template + Páginas Modelo)

**Objetivo:** Implementar expand/collapse por seção na sidebar
**Modelo recomendado:** Sonnet 4.6 (tarefa estruturada, CSS/JS moderado)
**Risco:** Baixo (alterações isoladas em 3 arquivos)
**Estimativa:** ~1,5h

#### Etapa 1.1 — Atualizar estrutura HTML do template

**Arquivo:** `includes/sidebar-nav.html`

Transformar de:
```html
<div class="nav-section-label">Operacional</div>
<a class="visa-nav-item" href="os.html">...</a>
```

Para:
```html
<div class="nav-section" data-section="operacional">
  <button class="nav-section-header" aria-expanded="false">
    <span>Operacional</span>
    <svg class="nav-section-chevron" viewBox="0 0 24 24" width="18" height="18">
      <path d="M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6z" fill="currentColor"/>
    </svg>
  </button>
  <div class="nav-section-items">
    <a class="visa-nav-item" href="os.html">...</a>
  </div>
</div>
```

**Checklist à prova de erros:**
- [ ] Manter Dashboard (`index.html`) **fora** das seções, sempre visível
- [ ] Adicionar `aria-expanded` para acessibilidade
- [ ] Usar `<button>` (não `<div>`) para o header — semântica e teclado
- [ ] Manter todos os `href` exatamente como estão
- [ ] Manter ícones emoji exatamente como estão
- [ ] Verificar que nenhum link foi omitido comparando com o template atual

#### Etapa 1.2 — CSS para collapse/expand

**Arquivo:** `css/sidebar.css` (adicionar ao final)

```css
/* === Seções Colapsáveis === */
.nav-section-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  padding: 10px 16px;
  border: none;
  background: transparent;
  color: var(--sidebar-section-color, #7a8a9e);
  font-size: 0.7rem;
  font-weight: 700;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  cursor: pointer;
  transition: background 0.15s ease;
}
.nav-section-header:hover {
  background: var(--sidebar-hover-bg, rgba(0,0,0,0.04));
}

.nav-section-chevron {
  transition: transform 0.25s ease;
  opacity: 0.5;
  flex-shrink: 0;
}
.nav-section.open .nav-section-chevron {
  transform: rotate(90deg);
}

.nav-section-items {
  display: grid;
  grid-template-rows: 0fr;
  transition: grid-template-rows 0.3s ease;
}
.nav-section.open .nav-section-items {
  grid-template-rows: 1fr;
}
.nav-section-items > * {
  overflow: hidden;
}
```

**Checklist à prova de erros:**
- [ ] Usar `grid-template-rows: 0fr → 1fr` (técnica moderna, sem `max-height` hack)
- [ ] Testar que a transição funciona em Chrome, Safari e Firefox
- [ ] Respeitar design tokens existentes (cores, espaçamentos)
- [ ] Dark mode: verificar que `.nav-section-header` herda corretamente
- [ ] Não quebrar estilos existentes de `.visa-nav-item`

> **ATENÇÃO:** A técnica `grid-template-rows: 0fr/1fr` requer que os filhos diretos de `.nav-section-items` tenham `overflow: hidden`. Como os `<a>` são filhos diretos, pode ser necessário envolver em um `<div>` wrapper.

Solução robusta:
```html
<div class="nav-section-items">
  <div class="nav-section-items-inner">
    <a class="visa-nav-item" href="os.html">...</a>
    <a class="visa-nav-item" href="alvara.html">...</a>
  </div>
</div>
```
```css
.nav-section-items-inner {
  overflow: hidden;
}
```

#### Etapa 1.3 — JavaScript para toggle + persistência

**Arquivo:** `js/sidebar.js` (adicionar ao final)

Funcionalidades:
1. **Click no header** → toggle classe `.open` na `.nav-section`
2. **localStorage** → salvar/restaurar estado das seções (`visa_sidebar_sections`)
3. **Seção ativa** → sempre aberta (baseado no `pathname` atual)
4. **aria-expanded** → atualizar automaticamente

```javascript
function initCollapsibleSections() {
  const sections = document.querySelectorAll('.nav-section');
  if (!sections.length) return;

  const storageKey = 'visa_sidebar_sections';
  const saved = JSON.parse(localStorage.getItem(storageKey) || '{}');
  const currentPage = location.pathname.split('/').pop() || 'index.html';

  sections.forEach(section => {
    const key = section.dataset.section;
    const header = section.querySelector('.nav-section-header');
    const links = section.querySelectorAll('.visa-nav-item');

    // Seção ativa: contém link para a página atual
    const isActive = Array.from(links).some(a => {
      const href = a.getAttribute('href');
      return href && currentPage.endsWith(href.replace('./', ''));
    });

    // Abrir se: seção ativa OU salvo como aberto no localStorage
    if (isActive || saved[key] === true) {
      section.classList.add('open');
      header?.setAttribute('aria-expanded', 'true');
    }

    header?.addEventListener('click', () => {
      const isOpen = section.classList.toggle('open');
      header.setAttribute('aria-expanded', String(isOpen));

      // Persistir estado
      const current = JSON.parse(localStorage.getItem(storageKey) || '{}');
      current[key] = isOpen;
      localStorage.setItem(storageKey, JSON.stringify(current));
    });
  });
}

// Inicializar quando DOM estiver pronto
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initCollapsibleSections);
} else {
  initCollapsibleSections();
}
```

**Checklist à prova de erros:**
- [ ] Não quebrar `markActiveNavItem()` existente — colapsável é complementar
- [ ] Não quebrar `toggleSidebar()` (abertura mobile) — são funcionalidades ortogonais
- [ ] Fallback se `localStorage` não disponível (try/catch)
- [ ] Funciona se chamado antes dos links existirem (guarda `if (!sections.length)`)
- [ ] Não depende de ordem de carregamento com `guard.js`

#### Etapa 1.4 — Aplicar na `index.html` e testar

1. Atualizar o `<aside>` em `index.html` com a nova estrutura
2. Testar manualmente:
   - Desktop: seções colapsam/expandem ao clicar
   - Mobile: sidebar abre (hamburger), seções funcionam dentro dela
   - Recarregar: estado das seções persiste via localStorage
   - Navegar: seção da página atual sempre aberta
   - Dark mode: visual coerente

**Critério de aceite:** `index.html` funciona perfeitamente com sidebar colapsável antes de propagar.

---

### FASE 2 — Propagação para Todas as Páginas

**Objetivo:** Aplicar layout padronizado + sidebar colapsável em todas as 24 páginas
**Modelo recomendado:** Sonnet 4.6 (tarefa repetitiva, alto volume, baixa complexidade por unidade)
**Risco:** Médio (volume alto, cada página pode ter particularidades)
**Estimativa:** ~2h

#### Etapa 2.1 — Inventário e classificação de páginas

| Categoria | Páginas | Tratamento |
|---|---|---|
| **Já tem sidebar completa** | `index.html` | Apenas atualizar para colapsável |
| **Sidebar via script (sem auth)** | `cnae.html`, `pop.html`, `plantao.html`, `alvara.html`, `total.html`, `relatorio_plantao_fiscal.html` | Re-executar script atualizado |
| **Sidebar via script (com auth)** | Páginas com `guard.js`/`guard1.js` | Re-executar `apply_sidebar_auth.py` atualizado |
| **Sem sidebar** | Páginas restantes | Aplicar manualmente ou via script |
| **Exceções** | `pdf_viewer.html`, `readme.html` | Avaliar caso a caso — podem não precisar de sidebar |

#### Etapa 2.2 — Atualizar scripts Python de propagação

**Arquivos:** `scripts/apply_sidebar.py`, `scripts/apply_sidebar_auth.py`

Modificações necessárias:
1. Atualizar o bloco HTML da sidebar nos scripts para incluir a estrutura colapsável
2. Manter a lista de seções/links sincronizada com `includes/sidebar-nav.html`
3. Adicionar tratamento de erro robusto (backup antes de sobrescrever)

**Checklist à prova de erros:**
- [ ] Script cria backup `.bak` antes de modificar qualquer arquivo
- [ ] Script valida que o HTML resultante tem tags de abertura/fechamento balanceadas
- [ ] Script não remove conteúdo `<script>` existente da página
- [ ] Script preserva `<meta>`, `<link>` e `<title>` originais do `<head>`
- [ ] Dry-run disponível (`--dry-run`) para verificar antes de aplicar

#### Etapa 2.3 — Executar propagação em lote

```bash
# 1. Backup completo
cp -r *.html _backup/pre-propagacao/

# 2. Executar para páginas sem auth
python3 scripts/apply_sidebar.py

# 3. Executar para páginas com auth
python3 scripts/apply_sidebar_auth.py

# 4. Páginas manuais (exceções)
# Tratar individualmente
```

#### Etapa 2.4 — Ajustes manuais pós-propagação

Páginas que provavelmente precisarão de ajustes:
- **`os.html`**: Página mais complexa, tem muito JS inline
- **`admin.html`**: Painel administrativo, pode ter layout próprio
- **`cvs.html`**: Tem CSS próprio (`regulados.css`)
- **`check.html`**: Links para PDFs, verificar se caminhos relativos funcionam
- **`pdf_viewer.html`**: Provavelmente deve ficar sem sidebar (é um visualizador)

---

### FASE 3 — Validação e QA

**Objetivo:** Garantir que tudo funciona em todos os cenários
**Modelo recomendado:** Haiku 4.5 (verificações rápidas e repetitivas) + humano para testes visuais
**Risco:** Baixo (leitura, não escrita)
**Estimativa:** ~1h

#### Etapa 3.1 — Validação automatizada

Criar script de verificação (`scripts/validate_pages.py`):

```python
# Para cada HTML na raiz:
# 1. Verificar presença de <aside class="sidebar">
# 2. Verificar presença de .nav-section (colapsável)
# 3. Verificar que sidebar.css e sidebar.js estão linkados
# 4. Verificar tags HTML balanceadas (abertura/fechamento)
# 5. Verificar que guard.js está presente em páginas protegidas
# 6. Contar links na sidebar — deve ser 22 em todas
```

#### Etapa 3.2 — Checklist de teste manual

| Teste | Método |
|---|---|
| Desktop Chrome: sidebar colapsável funciona | Manual |
| Desktop Firefox: sidebar colapsável funciona | Manual |
| Mobile Chrome (Android): hamburger + colapsável | Manual |
| Mobile Safari (iOS): hamburger + colapsável + safe areas | Manual |
| Dark mode: todos os elementos visíveis | Manual |
| PWA standalone: sidebar funciona | Manual |
| Login → navegar entre páginas → sidebar mantém estado | Manual |
| Usuário não autenticado → redirect funciona | Manual |
| localStorage limpo → todas seções fechadas (exceto ativa) | Manual |
| Página offline (service worker) → sidebar carrega do cache | Manual |

#### Etapa 3.3 — Teste de regressão

- [ ] Todas as 22 URLs na sidebar apontam para páginas que existem
- [ ] Nenhum link 404
- [ ] `markActiveNavItem()` destaca o item correto
- [ ] Login/logout funciona em todas as páginas
- [ ] Push notifications não foram afetadas
- [ ] Service worker cacheando corretamente (atualizar versão do cache se necessário)

---

### FASE 4 — Polimento e Documentação

**Objetivo:** Ajustes finos, performance, e atualização de documentação
**Modelo recomendado:** Sonnet 4.6 (mistura de código e texto)
**Risco:** Baixo
**Estimativa:** ~30min

#### Etapa 4.1 — Polimento visual

- Animação suave do chevron (rotação 0° → 90°)
- Feedback tátil (`vibrate` API) no toggle em mobile (se suportado)
- Transição de altura sem "salto" visual
- Indicador visual de seção com itens ativos (ex: badge ou cor diferente)

#### Etapa 4.2 — Performance

- Verificar que `grid-template-rows` transition não causa reflow excessivo
- Testar em dispositivos de baixa performance (Android antigo)
- Verificar que `localStorage` não é chamado em excesso (debounce se necessário)

#### Etapa 4.3 — Atualizar service worker

```javascript
// service-worker.js — atualizar versão do cache
const CACHE_NAME = 'visa-v2.5.0'; // bump de v2.2.8 para v2.5.0
```

#### Etapa 4.4 — Atualizar documentação

- [ ] Atualizar `includes/sidebar-nav.html` como fonte da verdade final
- [ ] Atualizar `changelog.html` com entrada sobre a nova sidebar
- [ ] Marcar ambos os projetos originais como **concluídos** nos respectivos `.md`

---

## Mapa de Modelos por Etapa

| Fase | Etapa | Modelo | Justificativa |
|---|---|---|---|
| **1.1** | HTML do template colapsável | **Sonnet 4.6** | Estruturado, baixo risco, precisa de atenção a detalhes HTML |
| **1.2** | CSS do collapse | **Sonnet 4.6** | CSS puro, técnica conhecida, precisa respeitar tokens existentes |
| **1.3** | JS toggle + persistência | **Sonnet 4.6** | Lógica moderada, integração com código existente |
| **1.4** | Aplicar em `index.html` | **Sonnet 4.6** | Cuidado para não quebrar a página principal |
| **2.1** | Inventário de páginas | **Haiku 4.5** | Tarefa de leitura e classificação simples |
| **2.2** | Atualizar scripts Python | **Sonnet 4.6** | Modificação de scripts existentes, risco médio |
| **2.3** | Executar propagação | **Sonnet 4.6** | Execução + verificação de resultados |
| **2.4** | Ajustes manuais | **Opus 4.6** | Páginas complexas requerem julgamento contextual |
| **3.1** | Validação automatizada | **Haiku 4.5** | Script de verificação simples |
| **3.2** | Teste manual | **Humano** | Requer olho humano em dispositivos reais |
| **3.3** | Teste de regressão | **Sonnet 4.6** | Verificações de links e funcionalidades |
| **4.1** | Polimento visual | **Sonnet 4.6** | CSS/JS incremental |
| **4.2** | Performance | **Sonnet 4.6** | Análise técnica |
| **4.3** | Service worker | **Haiku 4.5** | Mudança de uma linha |
| **4.4** | Documentação | **Haiku 4.5** | Texto descritivo |

---

## Matriz de Riscos e Mitigações

| Risco | Probabilidade | Impacto | Mitigação |
|---|---|---|---|
| Script Python corrompe HTML de página | Média | **Alto** | Backup `.bak` antes de cada modificação; validação pós-aplicação |
| `grid-template-rows` não funciona em Safari antigo | Baixa | Médio | Fallback CSS: `display: none` para `.nav-section-items` quando não `.open` |
| Conflito entre `markActiveNavItem()` e colapsável | Baixa | Médio | Colapsável roda **depois** de `markActiveNavItem()`; são complementares |
| `guard.js` redireciona antes da sidebar carregar | Baixa | Baixo | `guard.js` já roda após DOM; sidebar é HTML inline, não fetch |
| localStorage cheio ou indisponível | Muito baixa | Baixo | try/catch com fallback para seção ativa apenas |
| Perda de links na propagação | Média | **Alto** | Script de validação conta links (deve ser sempre 22); diff manual |
| Dark mode quebra com novos estilos | Baixa | Médio | Testar com `prefers-color-scheme: dark` antes de commitar |
| Service worker serve versão antiga cacheada | Média | Médio | Bump obrigatório da versão do cache |

---

## Critérios de Aceite Globais

O projeto está **concluído** quando:

1. **Todas as 24 páginas** (exceto `pdf_viewer.html` se justificado) têm sidebar com layout `app-layout`
2. **Sidebar colapsável** funciona em todas as páginas: click expande/colapsa seções
3. **Persistência** via localStorage: seções abertas são lembradas entre navegações
4. **Seção ativa** sempre aberta automaticamente
5. **Responsivo**: funciona em desktop (≥768px) e mobile (<768px)
6. **Dark mode**: visual coerente sem elementos invisíveis
7. **Acessibilidade**: `aria-expanded` atualizado, navegação por teclado funciona
8. **Performance**: sem jank visual, transições suaves, sem reflows desnecessários
9. **Nenhuma regressão**: auth, notificações, service worker, links — tudo funcionando
10. **Documentação**: changelog atualizado, template de referência sincronizado

---

## O que foi DESCARTADO dos projetos originais (e por quê)

| Proposta | Origem | Motivo do Descarte |
|---|---|---|
| `component-loader.js` (fetch dinâmico de HTML) | Padronização | FOUC, latência, complexidade desnecessária. Scripts Python de propagação são mais confiáveis para site estático. |
| `main-layout.html` (template base) | Padronização | Sem build tool, um template não pode ser consumido. `includes/sidebar-nav.html` já serve como referência. |
| Unificação `guard.js` + `guard1.js` | Padronização | Escopo independente, risco alto, não é pré-requisito. Projeto separado no futuro. |
| `sidebar-component.css` (novo arquivo) | Padronização | `sidebar.css` já existe e é maduro. Renomear sem necessidade é churn. |
| Hover para expandir seções | Colapsável | Causa fechamento acidental ao mover o mouse; click é mais previsível em todos os dispositivos. |

---

## Ordem de Commits Recomendada

```
1. feat: adiciona estrutura colapsável na sidebar (template)
2. style: adiciona CSS para seções colapsáveis da sidebar
3. feat: adiciona JS para toggle, persistência e seção ativa
4. refactor: aplica sidebar colapsável na index.html
5. refactor: atualiza scripts Python de propagação
6. refactor: propaga sidebar padronizada para páginas sem auth
7. refactor: propaga sidebar padronizada para páginas com auth
8. fix: ajustes manuais em páginas com particularidades
9. test: adiciona script de validação de páginas
10. chore: atualiza versão do cache no service worker
11. docs: atualiza changelog e documentação do projeto
```

---

*Este documento substitui e consolida `PROJETO_PADRONIZACAO_VISA.md` e `projeto-sidebar-colapsavel.md` como o plano de referência oficial para a evolução do layout do VISA.*
