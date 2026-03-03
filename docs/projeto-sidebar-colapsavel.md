# Projeto: Sidebar Colapsável por Seção

**Status:** Aguardando execução
**Prioridade:** Média
**Estimativa:** 2–2,5 horas (Sonnet)

---

## Problema

A sidebar está extensa demais. Ao abrir o menu (hamburger ou desktop), todos os links aparecem de uma vez — difícil navegar, especialmente em mobile.

## Comportamento desejado

Ao abrir a sidebar, exibir **somente os cabeçalhos de seção** (mais o Dashboard):

```
📊 Dashboard
▶ Operacional
▶ Relatórios
▶ Escala
▶ Referência
▶ Distribuição
▶ Sistema
```

Ao clicar em uma seção, ela expande mostrando os links internos.

---

## Decisões de design

| Ponto | Decisão |
|---|---|
| Expansão | **Click** em todos os dispositivos |
| Hover | Apenas realce visual (sem expandir) — evita fechar ao mover o mouse até o link |
| Animação | `grid-template-rows: 0fr → 1fr` com `transition` (técnica moderna, sem max-height fixo) |
| Persistência | `localStorage` salva quais seções estavam abertas |
| Seção ativa | Sempre abre automaticamente, independente do localStorage |
| Agente | **Sonnet** (o script Python de replicação é o passo de maior risco) |

---

## Estrutura HTML a implementar

### Antes (atual)
```html
<div class="nav-section-label">Operacional</div>
<a class="visa-nav-item" href="os.html">...</a>
<a class="visa-nav-item" href="alvara.html">...</a>
<a class="visa-nav-item" href="cvs.html">...</a>
```

### Depois
```html
<div class="nav-section" data-section="operacional">
  <button class="nav-section-header">
    <span>Operacional</span>
    <svg class="nav-section-chevron">...</svg>
  </button>
  <div class="nav-section-items">
    <a class="visa-nav-item" href="os.html">...</a>
    <a class="visa-nav-item" href="alvara.html">...</a>
    <a class="visa-nav-item" href="cvs.html">...</a>
  </div>
</div>
```

---

## Passos de execução

1. **Atualizar `includes/sidebar-nav.html`** com a nova estrutura colapsável
2. **CSS em `sidebar.css`** — estilos do header de seção, chevron, animação `grid-template-rows`
3. **JS em `sidebar.js`** — toggle click, persistência localStorage, expansão automática da seção ativa
4. **Script Python** para replicar o novo `<aside>` nas 22+ páginas automaticamente
5. **Verificar** páginas após aplicação (especialmente as que têm variações no aside)

---

## Arquivos afetados

- `includes/sidebar-nav.html` — fonte da verdade da sidebar
- `css/sidebar.css` — estilos novos
- `js/sidebar.js` — lógica de expand/collapse
- Scripts Python em `/scripts/` para replicação
- Todas as **22+ páginas HTML** do projeto

---

## Mapeamento das seções

| Seção | Links |
|---|---|
| Operacional | OS, Alvarás, Regulados |
| Relatórios | RMPF, Inspeções, Ocorrências, Indicadores, Indicadores de Conformidade |
| Escala | Plantão Fiscal, Veículos, Férias |
| Referência | Legislação, POPs da VISA, Check Lists |
| Distribuição | Áreas, CNAEs, Totalização |
| Sistema | Painel Admin, Sugestões, Novidades da versão, Aviso Institucional |

---

## Observações

- O Dashboard (`index.html`) fica **sempre visível**, fora das seções
- A seção da página atual abre **automaticamente** ao carregar
- `comply.html` (Indicadores de Conformidade) entra em **Relatórios**
- O script Python existente em `/scripts/apply_sidebar.py` serve de base para a replicação
