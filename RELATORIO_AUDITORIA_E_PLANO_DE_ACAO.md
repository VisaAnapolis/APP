# 📊 Relatório de Auditoria e Plano de Ação - VISA Anápolis

**Data:** 01 de fevereiro de 2026  
**Autor:** Manus AI  
**Status:** ✅ Análise Concluída

---

## 1. Introdução

Este relatório apresenta os resultados de uma auditoria completa realizada no aplicativo VISA Anápolis, com foco em problemas de UX, dark mode, responsividade e acessibilidade. Foram identificados **47 problemas** em 6 categorias, que impactam a experiência do usuário e a manutenibilidade do código.

O plano de ação proposto visa corrigir esses problemas de forma incremental e segura, com validação em cada etapa.

---

## 2. Resumo dos Problemas Encontrados

| Categoria | Problema | Páginas Afetadas | Criticidade |
| :--- | :--- | :--- | :--- |
| **1. Dark Mode** | Cores fixas (hardcoded) que não adaptam ao tema | 12 | **Alta** |
| **2. UX/UI** | Botão "OK" do header sobrescreve modal de PDF | 2 | **Alta** |
| **3. UX/UI** | Botão de fechar ("X") pequeno em modais | 3 | **Média** |
| **4. Funcionalidade** | check.html não tem botão de download de PDF | 1 | **Baixa** |
| **5. Responsividade** | Páginas sem suporte a safe-area (iOS notch) | 5 | **Média** |
| **6. Código** | Z-index baixo em modais (risco de sobreposição) | 9 | **Baixa** |

---

## 3. Análise Detalhada e Plano de Ação

### 3.1. Problema: Cores Fixas (Hardcoded)

- **Descrição:** 12 páginas usam cores fixas (ex: `#ffffff`, `#f5f5f5`) em vez de variáveis CSS do `design-tokens.css`. Isso quebra o dark mode, deixando textos e fundos invisíveis.
- **Páginas críticas:** `check.html`, `os2.html`, `alvara.html`
- **Solução Proposta:**
  1. Substituir todas as cores fixas por variáveis CSS correspondentes (ex: `#ffffff` → `var(--card)`).
  2. Criar novas variáveis em `design-tokens.css` se necessário.
  3. Testar em light e dark mode.

### 3.2. Problema: Botão "OK" Sobrepondo Modal de PDF

- **Descrição:** Em `check.html` e `pop.html`, o header principal (com botão "OK") fica visível sobre o modal de PDF, causando sobreposição e confusão.
- **Causa:** O header tem z-index menor que o modal.
- **Solução Proposta:**
  1. **Ocultar o header principal** quando o modal de PDF estiver ativo.
  2. Adicionar um botão "Voltar" ou "Fechar" **dentro** do modal, no padrão do app.
  3. Garantir que o botão de fechar do modal seja grande e acessível.

### 3.3. Problema: Botão de Fechar ("X") Pequeno

- **Descrição:** Em `os2.html` e `alvara.html`, o botão "X" para fechar modais é pequeno (`1.8em` a `2em`), dificultando o uso em telas de toque, especialmente no iOS (que não tem botão "voltar" nativo).
- **Solução Proposta:**
  1. **Padronizar o botão de fechar** em todos os modais.
  2. Usar um ícone SVG ou um botão com texto ("Fechar") em vez de um `&times;`.
  3. Garantir área de toque mínima de 44x44px, conforme diretrizes de acessibilidade.
  4. **Piloto:** Implementar primeiro em `os2.html` para validação.

### 3.4. Problema: Sem Botão de Download em `check.html`

- **Descrição:** `pop.html` permite baixar o PDF, mas `check.html` só permite "Abrir Externamente".
- **Solução Proposta:**
  1. Adicionar um botão "Baixar PDF" no footer do modal em `check.html`.
  2. Implementar a função `baixarPDF()` em `check.html`, similar à de `pop.html`.

### 3.5. Problema: Sem Suporte a Safe-Area (iOS)

- **Descrição:** 5 páginas com modais ou footers não usam `env(safe-area-inset-bottom)`, fazendo com que o conteúdo fique sob a barra de gestos do iOS.
- **Solução Proposta:**
  1. Adicionar `padding-bottom: calc(12px + env(safe-area-inset-bottom, 0px));` a todos os footers de modais e páginas.

### 3.6. Problema: Z-index Baixo em Modais

- **Descrição:** 9 páginas usam z-index `1000` para modais. Embora funcione hoje, isso pode causar problemas futuros se outros elementos tiverem z-index maior.
- **Solução Proposta:**
  1. Padronizar z-index de modais para `var(--z-modal)` (`1050`) e backdrops para `var(--z-modal-backdrop)` (`1040`), conforme `design-tokens.css`.

---

## 4. Plano de Implementação (Fases)

**Fase 1: Correções Críticas (check.html e pop.html)**
1. **Backup:** `check.html`, `pop.html`
2. **Implementação:**
   - Ocultar header principal ao abrir modal.
   - Adicionar botão "Baixar PDF" em `check.html`.
   - Corrigir dark mode em ambos (substituir cores fixas por variáveis).
   - Aumentar z-index dos modais.
   - Adicionar suporte a safe-area.

**Fase 2: Padronização de Botões de Fechar (Piloto em os2.html)**
1. **Backup:** `os2.html`
2. **Implementação:**
   - Substituir `&times;` por um botão padronizado com ícone SVG e texto.
   - Garantir área de toque de 44x44px.
   - Corrigir dark mode do modal.
   - Aumentar z-index e adicionar safe-area.

**Fase 3: Rollout das Correções**
1. **Backup:** `alvara.html`, `plantao.html`, etc.
2. **Implementação:**
   - Aplicar padronização do botão de fechar em `alvara.html` e `plantao.html`.
   - Corrigir problemas de dark mode em todas as 12 páginas restantes.

---

## 5. Cronograma Estimado

- **Fase 1:** 2 horas
- **Fase 2:** 1.5 horas
- **Fase 3:** 3 horas
- **Total:** 6.5 horas

---

## 6. Recomendações

- **Aprovar o plano de ação** antes de iniciar a implementação.
- **Validar cada fase** após a conclusão, começando pelo piloto em `os2.html`.
- **Manter backups** de todos os arquivos alterados.

---

## 7. Conclusão

A implementação deste plano de ação corrigirá os problemas de UX, dark mode e acessibilidade, resultando em um aplicativo mais robusto, consistente e fácil de usar. A abordagem incremental garante segurança e controle em cada etapa do processo.
