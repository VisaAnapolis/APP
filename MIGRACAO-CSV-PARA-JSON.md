# Plano: Migração CSV → JSON (Sistema VISA)

## Contexto

O sistema Delphi (CVS municipal) exporta todos os dados como CSV com encoding variado
(UTF-8 e ISO-8859-1), colunas desnecessárias e sem pré-filtragem. O browser baixa ~70 MB
por sessão e parseia tudo via PapaParse. A migração para JSON permite:

- Exportar apenas as colunas realmente usadas pelo JS
- Pré-filtrar registros inativos/cancelados no lado Delphi (sem fazer no browser)
- Eliminar dependência do PapaParse (CDN externo)
- Eliminar problema de encoding do `taxa.csv` (ISO-8859-1)
- Reduzir download total de ~70 MB para ~20 MB (~70% de redução)

---

## Diagnóstico: O que cada CSV tem vs. o que o JS usa

| CSV | Tamanho | Cols totais | Cols usadas no JS | Redução estimada |
|-----|---------|-------------|-------------------|-----------------|
| `cnae_aux.csv` | 15.6 MB | 12 | 5 | ~10 MB |
| `regulados.csv` | 8.3 MB | 34 | 4 (max) | ~8 MB — ver nota |
| `alvara.csv` | 8.5 MB | 27 | 8 | ~6 MB |
| `taxa.csv` | 6.0 MB | 11 | 4 + encoding | ~4 MB |
| `requerimento.csv` | 3.9 MB | 27 | 7 (browser) / 27 (notify) | ~2 MB |
| `oficio.csv` | 2.0 MB | 21 | 9 (browser) / 21 (notify) | ~1 MB |
| `denuncia.csv` | 1.3 MB | 24 | 24 (todos) | ~0.3 MB |
| `protocolo.csv` | 537 KB | 15 | 15 (todos) | ~0.1 MB |
| `tramitacao.csv` | 576 KB | 4 | 4 (todos) | ~0.1 MB |
| `inspecoes.csv` | 19.8 MB | 27 | **0 — não carregado no browser** | sem impacto |
| `alvlib.csv` | 3.9 MB | 10 | **0 — não carregado no browser** | sem impacto |
| `rdpf.csv` | 1.0 MB | 30 | **0 — não carregado no browser** | sem impacto |
| `bairros.csv` | 139 KB | 21 | **0 — não carregado no browser** | sem impacto |

> **Nota `regulados.csv`:** Se o `index_regulados.json` for enriquecido com os campos
> adicionais necessários (`municipal`, `cgc`, `cpf`, `logradouro`, `bairro`), o
> `regulados.csv` pode ser **eliminado totalmente** do carregamento no browser.

---

## Parte 1 — Enriquecer `index_regulados.json` (Delphi)

### Estrutura atual
```json
{ "codigo": 4, "razao": "MARCIO FLAVIO DOS SANTOS", "fantasia": "BRISA SORVETERIA", "documento": "23.730.770/0001-83" }
```

### Estrutura proposta (campos adicionais do regulados.csv)
```json
{
  "codigo": 4,
  "razao": "MARCIO FLAVIO DOS SANTOS",
  "fantasia": "BRISA SORVETERIA",
  "documento": "23.730.770/0001-83",
  "municipal": "12345",
  "logradouro": "AV MINAS GERAIS",
  "complemento": "405/B",
  "bairro": "JUNDIAÍ",
  "cdbai": "29",
  "atividade": "18",
  "inatividade": "",
  "fone": "",
  "celular": ""
}
```

**Impacto no JS:**
- `js/regulados1.js`: `loadMunicipalData()` pode ser **eliminada** — `municipal` já estará
  no index
- `js/simxcvs.js`: fetch de `regulados.csv` pode ser **eliminado** — `documento` (CGC/CPF)
  e `municipal` já estão no index
- `js/busca-global.js`: fetch de `regulados.csv` (só CODIGO+MUNICIPAL) pode ser
  **eliminado** — usa `mapaRegulados` que pode ser construído do index

**Resultado:** `regulados.csv` para de ser carregado no browser completamente.

---

## Parte 2 — JSONs a gerar (Delphi exporta direto)

### 2.1 `cnae_aux.json` — PRIORIDADE ALTA (maior impacto: -10 MB)

Somente os 5 campos usados por `simxcvs.js`:

```json
{
  "meta": { "gerado_em": "2026-03-30T08:00:00-03:00", "total": 110261 },
  "dados": [
    {
      "INSCRICAO_ISS": "000123",
      "CNAE": "4711-3/01",
      "ATIVIDADE": "COMÉRCIO VAREJISTA DE MERCADORIAS",
      "DOCUMENTO": "23.730.770/0001-83",
      "IND_PRINCIPAL": "S"
    }
  ]
}
```

**JS a modificar:** `js/simxcvs.js`
- Remover `parseCSV(url, ["INSCRICAO_ISS","CNAE","ATIVIDADE","DOCUMENTO","IND_PRINCIPAL"])`
- Substituir por `fetchJson("data/cnae_aux.json")` → acessar `data.dados`
- Remover `fetchGitCommitTime()` → `fetchStorageTimestamp()` (se migrar para Storage)

---

### 2.2 `alvara.json` — PRIORIDADE ALTA (-6 MB)

Somente os 8 campos usados por `busca-global.js`. Pode ser **pré-filtrado**
(apenas alvarás ativos — sem cancelados, sem duplicatas por Codigo/Exercicio):

```json
{
  "meta": { "gerado_em": "...", "total": 41103, "ativos": 18500 },
  "dados": [
    {
      "Controle": "1001",
      "Codigo": "4",
      "Numero": "000123/2025",
      "Exercicio": "2025",
      "Dt_emite": "15.01.2025",
      "Dt_validade": "31.12.2025",
      "Autoridade": "DR. FULANO",
      "Cancela": ""
    }
  ]
}
```

**JS a modificar:** `js/busca-global.js`
- Remover `parseCSV(url, ["Controle","Codigo","Numero","Exercicio","Dt_emite","Dt_validade","Autoridade","Cancela"])`
- Substituir por `fetchJson("data/alvara.json")` → acessar `data.dados`
- Se pré-filtrado no Delphi: remover lógica de filtro de ativos no browser

---

### 2.3 `taxa.json` — PRIORIDADE ALTA (-4 MB + resolve encoding)

Somente os 4 campos usados por `regulados1.js`. Elimina o problema ISO-8859-1:

```json
{
  "meta": { "gerado_em": "...", "total": 62484 },
  "dados": [
    {
      "inscricao": "000123",
      "valor": "R$ 150,00",
      "situacao": "QUITADO",
      "observacao": "* Área: ALIMENTOS"
    }
  ]
}
```

> **Atenção:** `regulados1.js` faz regex no campo `observacao` para extrair
> `Área`, `Vencimento`, `Exercício`, `Lançamento`. Manter o conteúdo do campo
> `Observação` exatamente como está no CSV original.

**JS a modificar:** `js/regulados1.js`
- Remover `loadTaxaData()` inteira (inclui lógica de ISO-8859-1 e ArrayBuffer)
- Substituir por `fetchJson("data/taxa.json")` → iterar `data.dados`
- Construir `taxaMap` com `Map<inscricao_normalizada, row>`

---

### 2.4 `requerimento.json` — PRIORIDADE MÉDIA (-2 MB)

Decisão: incluir **todos os 27 campos** (notify-os.js precisa de tudo).
Pode ser pré-filtrado (sem cancelados) para reduzir tamanho para browser:

```json
{
  "meta": { "gerado_em": "...", "total": 13548 },
  "dados": [
    {
      "Controle": "...", "Codigo": "...", "OS": "...", "Area": "...",
      "Motivo": "...", "Prioridade": "...", "Requerente": "...",
      "Prazo": "...", "Fiscal_Encaminha": "...", "Atendimento": "...",
      "Cancelado": "...",
      ... (todos os 27 campos)
    }
  ]
}
```

**JS a modificar:** `js/busca-global.js`
- Remover `parseCSV(url, ["OS","Codigo","Requerente","Prazo","Fiscal_Encaminha","Atendimento","Cancelado"])`
- Substituir por `fetchJson("data/requerimento.json")` → acessar `data.dados`

**Script a modificar:** `.github/scripts/notify-os.js`
- Remover função `parseCSV()` customizada (60+ linhas)
- Substituir por `JSON.parse(fs.readFileSync("data/requerimento.json"))` → `.dados`

---

### 2.5 `oficio.json` — PRIORIDADE MÉDIA (-1 MB)

Todos os 21 campos (notify-os.js precisa de tudo):

```json
{
  "meta": { "gerado_em": "...", "total": 6321 },
  "dados": [{ ...todos 21 campos... }]
}
```

**JS a modificar:** `js/busca-global.js` (mesma lógica)
**Script a modificar:** `.github/scripts/notify-os.js`

---

### 2.6 `protocolo.json`, `tramitacao.json`, `denuncia.json` — PRIORIDADE BAIXA

Mesma estrutura: `{ meta: {...}, dados: [...todos os campos...] }`

Impacto menor em tamanho, mas simplifica o código (remove PapaParse calls).

**JS a modificar:** `js/busca-global.js` (3 substitutos de `parseCSV`)
**Script a modificar:** `.github/scripts/notify-os.js` (denuncia.csv)

---

## Parte 3 — Remoção do PapaParse (etapa final)

Após converter todos os CSVs, PapaParse pode ser removido:

**Verificar antes:** se alguma página ainda usa PapaParse para qualquer outro CSV.
Se zero usos restantes:
- Remover de todos os HTMLs: `<script src=".../papaparse.min.js"></script>`
- Remover funções `parseCSV()` de `busca-global.js`, `regulados1.js`, `simxcvs.js`

---

## Parte 4 — CSVs que ficam como CSV (não são carregados no browser)

Estes não precisam ser convertidos para o browser funcionar. Delphi pode continuar
exportando como CSV ou converter quando houver necessidade futura:

| CSV | Uso atual |
|-----|-----------|
| `inspecoes.csv` | Importado pelo Delphi — não carregado no browser |
| `alvlib.csv` | Não usado em nenhum JS |
| `rdpf.csv` | Não usado em nenhum JS |
| `bairros.csv` | Não usado em nenhum JS |

---

## Ordem de Implementação Recomendada

```
1. Enriquecer index_regulados.json  →  elimina regulados.csv do browser (-8 MB)
2. cnae_aux.json                    →  maior arquivo convertido (-10 MB)
3. alvara.json                      →  segundo maior (-6 MB)
4. taxa.json                        →  resolve encoding + reduz (-4 MB)
5. requerimento.json                →  simplifica notify-os.js também
6. oficio.json                      →  idem
7. denuncia.json                    →  idem
8. protocolo.json + tramitacao.json →  menores, completam a migração
9. Remover PapaParse                →  cleanup final
```

---

## Arquivos Modificados no Projeto

| Arquivo | Tipo de mudança |
|---------|----------------|
| `js/busca-global.js` | Substituir todos `parseCSV()` por `fetchJson()` |
| `js/regulados1.js` | Remover `loadMunicipalData()` e `loadTaxaData()` |
| `js/simxcvs.js` | Remover fetch de regulados.csv e cnae_aux.csv (CSV) |
| `.github/scripts/notify-os.js` | Remover parser CSV customizado, usar JSON |
| `.github/scripts/notify-email-os.js` | Idem |
| Todos os HTMLs | Remover `<script papaparse>` após etapa 9 |

---

## O que o Delphi precisa fazer (lado do exportador)

Para cada tabela convertida, o Delphi deve:
1. Gerar arquivo `.json` com estrutura `{ meta: { gerado_em, total }, dados: [...] }`
2. `gerado_em`: timestamp ISO 8601 no fuso `-03:00`
3. Encoding: **sempre UTF-8** (sem BOM)
4. Campos de data: manter formato atual `dd.mm.aaaa` (o JS já trata)
5. Strings: sem aspas extras, sem quebras de linha internas
6. Campos numéricos: manter como string (o JS faz parse onde necessário)

---

## Verificação (Checklist por etapa)

**Após enriquecer index_regulados.json:**
- [ ] `simxcvs.html` carrega sem buscar `regulados.csv`
- [ ] Busca global encontra estabelecimentos por documento (CGC/CPF)
- [ ] `loadMunicipalData()` pode ser removida de `regulados1.js`

**Após cada JSON convertido:**
- [ ] Página correspondente carrega sem erro no console
- [ ] DevTools (Network): CSV antigo não aparece mais nas requisições
- [ ] Tamanho do download menor que antes

**Após remover PapaParse:**
- [ ] Nenhum `parseCSV` restante em busca-global, regulados1, simxcvs
- [ ] Nenhum `Papa.parse` no código
- [ ] Páginas carregam sem a CDN do PapaParse
