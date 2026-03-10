# Logo VISA clicável — Atalho para o Dashboard

**Data da análise:** 10/03/2026
**Status:** Pronto para implantação

---

## Objetivo

Tornar o cabeçalho da sidebar (logo + "Vigilância Sanitária") um link clicável que navega de volta ao `index.html` (Dashboard), eliminando a necessidade de rolar o sidebar para acessar o item Dashboard quando se está em páginas listadas no final do menu.

---

## Análise de Impacto

### Verificação de segurança HTML

**Resultado:** ✅ Nenhum `<a>` aninhado encontrado em nenhum dos 26 arquivos verificados.

A mudança substitui `<div class="sidebar__header">` por `<a class="sidebar__header" href="index.html">`. Isso é **HTML5 válido** — `<a>` pode envolver elementos de bloco desde que não haja outro `<a>` aninhado. O header contém apenas `<img>` e `<div>`, sem links internos.

### Variantes encontradas

| Variante | Qtd. arquivos | Detalhe |
|----------|--------------|---------|
| Padrão (21 páginas) | 21 | Estrutura limpa — substituição automática via Python |
| `index.html` | 1 | Contém bloco logo comentado (`<!-- ... -->`) — edição manual |
| `includes/sidebar-nav.html` | 1 | Template de referência — edição manual |

**Total: 23 arquivos HTML + 3 scripts Python.**

### Comportamento na `index.html`

Quando já estiver no Dashboard, clicar no logo vai **recarregar a página**. Comportamento aceitável — é o padrão de 100% dos sistemas com logo clicável.

---

## Arquivos a modificar

### 1. `css/sidebar.css`

Adicionar ao bloco `.sidebar__header` existente (linha ~48):

```css
/* ANTES */
.sidebar__header {
  padding: 18px 16px 14px;
  border-bottom: 1px solid var(--line, #e2e8f0);
  display: flex;
  align-items: center;
  gap: 10px;
  flex-shrink: 0;
  position: sticky; top: 0;
  background: var(--card, #fff);
  z-index: 1;
}

/* DEPOIS */
.sidebar__header {
  padding: 18px 16px 14px;
  border-bottom: 1px solid var(--line, #e2e8f0);
  display: flex;
  align-items: center;
  gap: 10px;
  flex-shrink: 0;
  position: sticky; top: 0;
  background: var(--card, #fff);
  z-index: 1;
  text-decoration: none;
  color: inherit;
  transition: opacity 0.15s;
}
a.sidebar__header:hover { opacity: 0.75; }
```

> O dark mode já funciona automaticamente — `.sidebar__header` herda o background do dark mode via regra existente na linha ~347.

---

### 2. `includes/sidebar-nav.html` — edição manual

```html
<!-- ANTES -->
<div class="sidebar__header">
  ...conteúdo...
</div>

<!-- DEPOIS -->
<a class="sidebar__header" href="index.html">
  ...conteúdo...
</a>
```

---

### 3. Scripts Python (3 arquivos)

A mesma substituição de `<div>` → `<a>` no template string `make_sidebar()` de cada script:

| Arquivo | Localização do bloco |
|---------|---------------------|
| `scripts/apply_sidebar.py` | Função `make_sidebar()`, linha ~45 |
| `scripts/apply_sidebar_auth.py` | Função `make_sidebar()`, linha ~50 |
| `scripts/build_sidebar_pages.py` | Constante `SIDEBAR_BLOCK`, linha ~17 |

---

### 4. 21 páginas HTML — substituição automática

Todas têm a mesma estrutura. Um Python one-liner substitui tudo de uma vez:

```python
import re, glob

OLD = '''      <div class="sidebar__header">
        <div class="sidebar__logo" style="background:none;">
          <img src="icons/visa.png" style="width:36px;height:36px;border-radius:8px;object-fit:cover;" alt="VISA">
        </div>
        <div>
          <div class="sidebar__app-name">Vigilância Sanitária</div>
          <div class="sidebar__app-sub">Anápolis – GO</div>
        </div>
      </div>'''

NEW = '''      <a class="sidebar__header" href="index.html">
        <div class="sidebar__logo" style="background:none;">
          <img src="icons/visa.png" style="width:36px;height:36px;border-radius:8px;object-fit:cover;" alt="VISA">
        </div>
        <div>
          <div class="sidebar__app-name">Vigilância Sanitária</div>
          <div class="sidebar__app-sub">Anápolis – GO</div>
        </div>
      </a>'''

for f in glob.glob('*.html'):
    if f == 'index.html':
        continue  # trata manualmente
    content = open(f).read()
    if OLD in content:
        open(f, 'w').write(content.replace(OLD, NEW))
        print(f'  atualizado: {f}')
```

---

### 5. `index.html` — edição manual

O `index.html` tem um bloco logo comentado (`<!-- ... -->`) que difere do padrão. Localizar linha ~1167:

```html
<!-- ANTES -->
<div class="sidebar__header">
   <!--
          <div class="sidebar__logo">...</div>
   -->
          <div class="sidebar__logo" style="background:none;"> ...</div>
          <div>
            <div class="sidebar__app-name">Vigilância Sanitária</div>
            <div class="sidebar__app-sub">Anápolis – GO</div>
          </div>
        </div>

<!-- DEPOIS — trocar a tag externa de div para a, e remover o comentário legado -->
<a class="sidebar__header" href="index.html">
          <div class="sidebar__logo" style="background:none;"> ...</div>
          <div>
            <div class="sidebar__app-name">Vigilância Sanitária</div>
            <div class="sidebar__app-sub">Anápolis – GO</div>
          </div>
        </a>
```

---

## Resumo de risco

| Critério | Avaliação |
|----------|----------|
| Risco de quebra de layout | **Zero** — apenas a tag muda, todos os estilos são preservados |
| Validade HTML5 | **Válido** — `<a>` transparente sem links aninhados |
| Impacto no dark mode | **Nenhum** — estilos dark já existentes continuam funcionando |
| Impacto no mobile | **Nenhum** — header fica sticky e visível; toque funciona naturalmente |
| Impacto nos scripts Python | **Sim, mas inofensivo** — atualizar os 3 scripts garante que futuras propagações mantenham o link |
| Reversão | **Trivial** — trocar `<a>` de volta para `<div>` e remover 2 linhas do CSS |

---

## Ordem recomendada de implantação

1. `css/sidebar.css` — adicionar 3 linhas
2. `includes/sidebar-nav.html` — trocar tag
3. `scripts/apply_sidebar.py`, `apply_sidebar_auth.py`, `build_sidebar_pages.py` — trocar tag nos templates
4. Rodar o Python one-liner para as 21 páginas padrão
5. Editar `index.html` manualmente
6. Testar em browser (desktop + mobile)
7. Commit: `feat: logo sidebar clicável — atalho para o dashboard`
