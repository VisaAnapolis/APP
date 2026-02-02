# Backup - Fase 1: Correções Críticas

**Data:** 01/02/2026  
**Arquivos salvos:** check.html, pop.html

## Arquivos Originais

- `check.html` - Página de Checklists (antes das correções)
- `pop.html` - Página de POPs (antes das correções)

## Correções Aplicadas

1. ✅ Ocultar header principal ao abrir modal de PDF
2. ✅ Adicionar botão "Baixar PDF" em check.html
3. ✅ Corrigir dark mode (substituir cores fixas por variáveis CSS)
4. ✅ Aumentar z-index dos modais para 1050
5. ✅ Adicionar suporte a safe-area (iOS notch)

## Como Restaurar

```bash
# Restaurar check.html
cp backup_fase1_20260201/check.html ./

# Restaurar pop.html
cp backup_fase1_20260201/pop.html ./

# Restaurar ambos
cp backup_fase1_20260201/*.html ./
```

## Via Git

```bash
# Ver commit antes das correções
git log --oneline

# Reverter para versão anterior
git checkout <commit-hash> -- check.html pop.html
```
