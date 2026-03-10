# Especificação Técnica — Pesquisa Global Unificada
## VISA Anápolis · APP garrado/VISA

**Versão:** 2.3
**Data:** 10/03/2026
**Autor original:** Cláudio Nascimento Silva
**Revisão técnica:** Claude (Opus 4.6) — validação com análise dos dados reais
**Status:** Proposta revisada para implementação

---

## Changelog v1.0 → v2.3

> A v2.1 incorpora análise direta dos arquivos de dados (`python3`) em
> cima das correções estruturais da v2.0. Todos os valores abaixo foram
> verificados contra os arquivos reais do repositório em 10/03/2026.

### Correções da v2.0 (estruturais)

| # | Problema na v1.0 | Correção |
|---|---|---|
| 1 | Nomes de campos fictícios (`NomeFantasia`, `RazaoSocial`, `CNPJ`, `NumReq`, `NumDenuncia`, `NumOficio`, `Endereco`) não existem nos CSVs | Mapeamento corrigido com nomes reais |
| 2 | `index_regulados.json` com campo `Endereco` inexistente | Removido; JSON só tem `codigo`, `razao`, `fantasia`, `documento` |
| 3 | `alvlib.csv` pesquisável por nome/CNPJ — campos inexistentes | Estratégia JOIN `Controle` ↔ `codigo` dos regulados |
| 4 | URLs `cvs.html?q=`, `protocolo.html?num=`, `alvara.html?q=` não existem | Seção 7 reescrita; só `os.html?tipo=` funciona hoje |
| 5 | `parseCSV()` sem `delimiter: ';'` | Corrigido |
| 6 | Race condition na flag `_carregando` | Substituída por Promise compartilhada |
| 7 | `Date.now()` como cache-buster | Substituído por data (granularidade diária) |
| 8 | `@keyframes spin` ausente no CSS | Adicionado como `buscaSpin` |
| 9 | Badges sem variantes dark mode | Adicionadas |

### Correções adicionais da v2.1 (validação dos dados reais)

| # | Achado | Impacto / Correção |
|---|---|---|
| 10 | `denuncia.csv`: 2.946 de 2.978 têm `Archive='True'` — **32 ativas** | Buscar **somente ativas** (decisão do usuário) |
| 11 | `requerimento.csv`: só **404** de 13.146 são ativos | Buscar **somente ativos** |
| 12 | `oficio.csv`: só **194** de 6.213 são ativos | Buscar **somente ativos** |
| 13 | `protocolo.csv`: buscar **todos** os registros (histórico completo) | Protocolos não têm filtro ativo/inativo — retornar tudo |
| 14 | `oficio.csv`: campo `Fantasia` preenchido em apenas 195/6.213; `Regulado` em 6.213/6.213 | Campo principal é `Regulado` |
| 15 | `protocolo.csv`: campo `Documento` é registro profissional (CRF, CAU), não CNPJ | Removido da busca por CNPJ |
| 16 | Formato protocolo: `20220015` (numérico puro) | Spec v1.0 mostrava `2025/1.847` — errado |
| 17 | `index_regulados.json` sem campo CNAE | CNAE só existe no `alvara.csv` (campo `Atividade`, via `alvlib.csv`) |
| 18 | CNPJs consistentemente formatados `XX.XXX.XXX/XXXX-XX` | A normalização `norm()` já cobre |
| 19 | Datas no formato `DD.MM.YYYY` em todas as fontes | `parseData()` existente cobre |
| 20 | **`alvlib.csv` substituído por `alvara.csv`** — alvara tem `Dt_emite` e `Dt_validade` (campos essenciais para badge de vencimento), `alvlib` não | Fonte de alvarás trocada para `alvara.csv` (40.129 registros) |
| 21 | `alvara.csv` FK: `Codigo` (não `Controle`) → `regulados.codigo` | JOIN correto: 34.167/40.129 (85%) vinculam a um regulado |
| 22 | `alvara.csv`: `Dt_emite` preenchido em 28.613/40.129; `Dt_validade` em 20.745/40.129 | Possível exibir badge de validade (vigente/vencido) |
| 23 | `alvara.csv`: `Cancela` preenchido em 334/40.129 | Filtrar cancelados |

### Correções da v2.3 (validação cruzada com código das páginas existentes)

| # | Achado | Impacto / Correção |
|---|---|---|
| 24 | Nomes de campos de "Fiscal" variam entre tipos: `Fiscal_Encaminha` (req), `Fiscalencaminha` (ofício), `FiscalEncaminha` (denúncia) | Nova seção 4.4 documenta mapeamento exato |
| 25 | Denúncia **não tem campo `Cancelado`** — sempre tratada como não cancelada | Removido do filtro de denúncias |
| 26 | Protocolo **não tem campos `Archive` nem `Cancelado`** — confirma decisão de buscar todos | Sem filtro para protocolos |
| 27 | `os.html` usa `processarBool()` que aceita `TRUE/true/T/SIM/Sim/S` | Busca global deve usar mesma lógica |
| 28 | Campo `Motivo` em denúncia é `Objeto1` (não `Motivo`) | Corrigido na tabela 4.4 |
| 29 | Fluxo de dados (seção 3.2) ainda referenciava `alvlib.csv` | Corrigido para `alvara.csv` |

---

## 1. Contexto e Motivação

O APP VISA possui hoje buscas isoladas por módulo: `protocolo.html`,
`cvs.html`, `os.html` e `alvara.html` cada um com seu próprio campo de
pesquisa, sem integração entre si. Um fiscal em campo que precisa de
todas as informações sobre um estabelecimento específico — protocolos
abertos, situação do alvará, denúncias, requerimentos — precisa navegar
manualmente por três ou quatro páginas diferentes.

A **Pesquisa Global Unificada** resolve esse problema com um único campo
de busca no Dashboard (`index.html`) que consulta simultaneamente todas
as fontes de dados e retorna resultados agrupados por categoria, com
links diretos para cada registro.

---

## 2. Inventário de Dados Disponíveis

Levantamento dos arquivos reais no repositório (`data/`), validado em 10/03/2026:

| Arquivo | Tamanho | Registros | Incluir na Busca | Escopo | Observação |
|---|---|---|---|---|---|
| `index_regulados.json` | **2,1 MB** | 17.908 | ✅ Sim | Todos | Fonte primária de regulados |
| `regulados.csv` | 7,9 MB | — | ❌ Não | — | Grande demais; usar o JSON |
| `protocolo.csv` | 530 KB | 2.346 | ✅ Sim | **Todos** | Busca histórica completa |
| `tramitacao.csv` | 529 KB | 9.009 | ✅ Sim | Todos | Enriquece protocolos (JOIN) |
| `requerimento.csv` | **3,7 MB** | 13.146 | ⚠️ Parcial | **Só ativos (404)** | Filtrar Atendimento/Cancelado |
| `denuncia.csv` | 1,3 MB | 2.978 | ✅ Sim | **Só ativas (32)** | Filtrar Archive |
| `oficio.csv` | 2,0 MB | 6.213 | ⚠️ Parcial | **Só ativos (194)** | Filtrar Cancela/Archive |
| `alvara.csv` | **8,2 MB** | 40.129 | ⚠️ JOIN | Não cancelados | Tem `Dt_emite` e `Dt_validade` para badge |
| `alvlib.csv` | 3,7 MB | 38.895 | ❌ Não | — | **Substituído por alvara.csv** (sem Dt_emite/Dt_validade) |
| `inspecoes.csv` | **19,7 MB** | — | ❌ Não | — | Inviável para busca client-side |
| `os_snapshot.json` | 11,8 MB | — | ❌ Não | — | Grande demais; usar CSVs |

### 2.1 Estrutura Real dos Campos (verificação contra CSVs)

> **ATENÇÃO**: Os nomes dos campos abaixo são os nomes **reais** extraídos
> dos cabeçalhos dos CSVs. Todos os CSVs usam **`;`** como delimitador.

| Arquivo | Campos reais relevantes para busca |
|---|---|
| `index_regulados.json` | `codigo`, `razao`, `fantasia`, `documento` |
| `protocolo.csv` | `Protocolo`, `Protocolante`, `Assunto` |
| `tramitacao.csv` | `PROTOCOLO`, `DATA`, `HORA`, `DESTINO` |
| `requerimento.csv` | `OS`, `Requerente`, `Prazo`, `Fiscal_Encaminha`, `Atendimento`, `Cancelado` |
| `denuncia.csv` | `Denuncia`, `Reclamado`, `Logradouro`, `Cnpj`, `Prazo`, `FiscalEncaminha`, `Archive` |
| `oficio.csv` | `Oficio`, `Regulado`, `Cnpj`, `Logradouro`, `Prazo`, `Fiscalencaminha`, `Cancela`, `Archive` |
| `alvara.csv` | `Controle`, `Codigo`, `Numero`, `Exercicio`, `Dt_emite`, `Dt_validade`, `Autoridade`, `Cancela` |

> **Mudança v2.1 → v2.2**: `alvlib.csv` substituído por `alvara.csv`.
> Motivo: `alvara.csv` possui `Dt_emite` (emissão) e `Dt_validade` (validade),
> campos essenciais para exibir badge de vencimento. `alvlib.csv` não tem
> esses campos. A FK para regulados em `alvara.csv` é o campo `Codigo`
> (não `Controle`), cobrindo 34.167/40.129 registros (85%).

### 2.2 Conclusão do Inventário

> ⚠️ **Atenção crítica:** `requerimento.csv` (3,7 MB), `oficio.csv`
> (2,0 MB) e `alvara.csv` (8,2 MB) são carregáveis, mas pesados.
> A estratégia de **lazy loading com cache em memória** é obrigatória,
> não opcional. Esses arquivos **jamais devem ser carregados na
> abertura da página** — somente na primeira busca do usuário.

> ⚠️ **`alvara.csv` não possui campos de nome fantasia, razão social
> ou CNPJ.** A busca de alvarás por nome do estabelecimento exige
> cruzamento com `index_regulados.json` via chave `Codigo` ↔ `codigo`.
> Essa intersecção cobre 34.167 dos 40.129 registros (85%).

**Peso total dos arquivos incluídos:** ~16,9 MB (alvara.csv é maior que alvlib)
**Peso estimado após seleção de campos (PapaParse):** ~5–6 MB efetivos na memória

---

## 3. Arquitetura da Solução

### 3.1 Novo Arquivo: `js/busca-global.js`

Módulo ES6 independente, seguindo o padrão dos demais arquivos em `js/`
(`sidebar.js`, `push-notifications.js` etc.). Exporta uma única função
pública: `initBuscaGlobal()`, chamada no `index.html` após o login ser
confirmado.

```
js/
├── version.js              (existente)
├── sidebar.js              (existente)
├── push-notifications.js   (existente)
├── guard.js                (existente)
├── cvs1.js                 (existente)
├── regulados1.js           (existente)
└── busca-global.js         ← NOVO
```

### 3.2 Fluxo de Dados

```
Usuário digita (≥3 chars, debounce 400ms)
        │
        ▼
initBuscaGlobal() verifica _cacheBusca
        │
   ┌────┴────┐
   │em cache │──→ busca imediata (< 10ms)
   └────┬────┘
        │ sem cache
        ▼
Promise.all([
  fetch index_regulados.json,   // 2,1 MB → { meta, dados: [...] }
  PapaParse protocolo.csv,      // 530 KB (delimiter: ';')
  PapaParse tramitacao.csv,     // 529 KB (delimiter: ';')
  PapaParse denuncia.csv,       // 1,3 MB (delimiter: ';')
  PapaParse requerimento.csv,   // 3,7 MB (campos selecionados)
  PapaParse oficio.csv,         // 2,0 MB (campos selecionados)
  PapaParse alvara.csv          // 8,2 MB (campos selecionados)
])
        │
        ▼
Pós-processamento:
  - Filtra ativos: den/req/ofi (protocolo = todos)
  - Constrói mapa regulados: Map<codigo, {razao, fantasia, documento}>
  - Enriquece alvara com dados de regulados via Codigo ↔ codigo
  - Enriquece protocolos com última tramitação
        │
        ▼
Salva em _cacheBusca (memória da sessão)
        │
        ▼
Executa matching em todas as fontes
        │
        ▼
Renderiza painel dropdown com resultados agrupados
```

### 3.3 Estratégia de Cache em Memória

```javascript
// Singleton de cache — vive enquanto a aba estiver aberta
let _cacheBusca = null;
let _promiseCarregamento = null;  // Promise compartilhada (evita race condition)

async function garantirDadosCarregados() {
  if (_cacheBusca) return _cacheBusca;   // hit: retorno imediato

  // Se já há um carregamento em andamento, espera o mesmo Promise
  // (resolve a race condition da v1.0 que retornava null)
  if (_promiseCarregamento) return _promiseCarregamento;

  _promiseCarregamento = _carregarTudo();
  try {
    _cacheBusca = await _promiseCarregamento;
    return _cacheBusca;
  } catch (e) {
    console.error('[BuscaGlobal] Falha ao carregar dados:', e);
    return null;
  } finally {
    _promiseCarregamento = null;
  }
}

async function _carregarTudo() {
  mostrarSpinnerNoCampo(true);

  // Cache-buster com granularidade diária (evita re-download a cada aba)
  const hoje = new Date().toISOString().slice(0, 10); // "2026-03-10"

  const [reguladosJson, protocolos, tramitacoes, denunciasRaw,
         requerimentosRaw, oficiosRaw, alvarasRaw] =
    await Promise.all([
      fetch(`data/index_regulados.json?d=${hoje}`).then(r => r.json()),
      parseCSV(`data/protocolo.csv?d=${hoje}`),      // todos (histórico)
      parseCSV(`data/tramitacao.csv?d=${hoje}`),
      parseCSV(`data/denuncia.csv?d=${hoje}`),
      parseCSV(`data/requerimento.csv?d=${hoje}`,
               ['OS', 'Requerente', 'Prazo', 'Fiscal_Encaminha',
                'Atendimento', 'Cancelado']),
      parseCSV(`data/oficio.csv?d=${hoje}`,
               ['Oficio', 'Regulado', 'Cnpj', 'Logradouro',
                'Prazo', 'Fiscalencaminha', 'Cancela', 'Archive']),
      parseCSV(`data/alvara.csv?d=${hoje}`,
               ['Controle', 'Codigo', 'Numero', 'Exercicio',
                'Dt_emite', 'Dt_validade', 'Autoridade', 'Cancela'])
    ]);

  // Extrair array de dados do JSON (estrutura: { meta, dados })
  const regulados = reguladosJson.dados || reguladosJson;

  // ---------- FILTROS DE REGISTROS ATIVOS ----------
  // Protocolos: retornar TODOS (histórico completo)
  // Denúncias: somente ativas (Archive !== 'True')
  const denuncias = denunciasRaw.filter(d =>
    String(d.Archive || '').trim().toUpperCase() !== 'TRUE'
  );
  // Requerimentos: somente ativos (sem Atendimento e sem Cancelado)
  const requerimentos = requerimentosRaw.filter(r =>
    String(r.Atendimento || '').trim().toUpperCase() !== 'TRUE' &&
    String(r.Cancelado   || '').trim().toUpperCase() !== 'TRUE'
  );
  // Ofícios: somente ativos (sem Cancela e sem Archive)
  const oficios = oficiosRaw.filter(o =>
    String(o.Cancela  || '').trim().toUpperCase() !== 'TRUE' &&
    String(o.Archive  || '').trim().toUpperCase() !== 'TRUE'
  );
  // Alvarás: excluir cancelados
  const alvarasAtivos = alvarasRaw.filter(a =>
    !String(a.Cancela || '').trim()
  );

  // ---------- MAPA DE REGULADOS para JOIN ----------
  const mapaRegulados = new Map();
  for (const r of regulados) {
    mapaRegulados.set(String(r.codigo), r);
  }

  // Enriquecer alvara.csv com dados de regulados via Codigo (FK)
  // ATENÇÃO: a FK é "Codigo", NÃO "Controle" (validado contra dados reais)
  for (const a of alvarasAtivos) {
    const reg = mapaRegulados.get(a.Codigo);
    if (reg) {
      a._fantasia  = reg.fantasia;
      a._razao     = reg.razao;
      a._documento = reg.documento;
    }
  }

  // Mapa de última tramitação por protocolo
  const mapaTramitacao = new Map();
  for (const t of tramitacoes) {
    const proto = (t.PROTOCOLO || '').trim();
    if (!proto) continue;
    const existente = mapaTramitacao.get(proto);
    if (!existente || (t.DATA || '') > (existente.DATA || '')) {
      mapaTramitacao.set(proto, t);
    }
  }

  mostrarSpinnerNoCampo(false);

  return { regulados, protocolos, tramitacoes, denuncias,
           requerimentos, oficios, alvaras: alvarasAtivos,
           mapaRegulados, mapaTramitacao };
}

/**
 * Wrapper do PapaParse com delimiter ';' (padrão dos CSVs do VISA).
 * @param {string} url - URL do CSV
 * @param {string[]|null} campos - Se informado, só retorna esses campos
 */
function parseCSV(url, campos = null) {
  return new Promise((resolve, reject) => {
    Papa.parse(url, {
      download: true,
      header: true,
      delimiter: ';',
      skipEmptyLines: true,
      complete: (results) => {
        if (campos && results.data.length > 0) {
          const camposSet = new Set(campos);
          resolve(results.data.map(row => {
            const filtrado = {};
            for (const c of camposSet) {
              if (c in row) filtrado[c] = row[c];
            }
            return filtrado;
          }));
        } else {
          resolve(results.data);
        }
      },
      error: reject
    });
  });
}
```

### 3.4 Limpeza de Cache no Logout

```javascript
// Chamar quando o usuário fizer logout ou a sessão expirar
export function limparCacheBusca() {
  _cacheBusca = null;
  _promiseCarregamento = null;
}
```

No `index.html`, após o `signOut`:

```javascript
window.logout = function() {
  import('./js/busca-global.js').then(m => m.limparCacheBusca?.());
  signOut(auth).catch(console.error);
};
```

---

## 4. Algoritmo de Matching

### 4.1 Normalização de Texto

```javascript
function norm(s) {
  return String(s || '')
    .toUpperCase()
    .trim()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')  // remove acentos
    .replace(/[.\-\/\s]+/g, ' ');     // normaliza CNPJ, espaços
}

function match(campo, termoNorm) {
  return norm(campo).includes(termoNorm);
}
```

> **Otimização**: normalizar o termo de busca **uma única vez** fora do
> loop, não a cada chamada de `match()`. A função `match()` recebe o
> termo já normalizado.

### 4.2 Campos Pesquisados por Fonte (VALIDADOS CONTRA DADOS REAIS)

| Fonte | Escopo | Campos de busca | Campos exibidos no resultado |
|---|---|---|---|
| **Regulados** (`index_regulados.json`) | Todos (17.908) | `fantasia`, `razao`, `documento` | Nome fantasia, CNPJ, razão social |
| **Protocolos** (`protocolo.csv`) | **Todos (2.346)** | `Protocolo`, `Protocolante`, `Assunto` | Nº protocolo, protocolante, assunto, destino tramitação |
| **Requerimentos** (`requerimento.csv`) | **Só ativos (~404)** | `OS`, `Requerente` | Nº OS, requerente, prazo |
| **Denúncias** (`denuncia.csv`) | **Só ativas (~32)** | `Denuncia`, `Reclamado`, `Logradouro`, `Cnpj` | Nº denúncia, reclamado, logradouro |
| **Ofícios** (`oficio.csv`) | **Só ativos (~194)** | `Oficio`, `Regulado`, `Cnpj` | Nº ofício, nome regulado, CNPJ |
| **Alvarás** (`alvara.csv` + JOIN) | Não cancelados | `_fantasia`, `_razao`, `_documento`, `Numero`, `Autoridade` | Nº alvará, nome (via JOIN), emissão, validade |

> **Protocolos — busca completa**: Protocolos retornam **todos** os registros
> (histórico completo), sem filtro de ativos/inativos.

> **Denúncias, Requerimentos, Ofícios — só ativos**: Filtros aplicados
> na etapa de carregamento (seção 3.3). Resultados mostram apenas registros
> em aberto (não arquivados, não atendidos, não cancelados).

> **Protocolos — `Documento` não é CNPJ**: O campo `Documento` em `protocolo.csv`
> contém número de registro profissional (CRF, CAU, CRO, etc.), não CNPJ.
> Removido da busca por CNPJ.

> **Ofícios — usar `Regulado` não `Fantasia`**: `Regulado` está preenchido
> em 6.213/6.213 registros; `Fantasia` em apenas 195. Campo principal é `Regulado`.

> **Alvarás — badge de validade**: `alvara.csv` possui `Dt_emite` (28.613 preenchidos)
> e `Dt_validade` (20.745 preenchidos). Possível calcular badge de vencimento:
> vigente, vencido ou a vencer. Alvarás sem `Dt_validade` não exibem badge.

### 4.3 Filtros de Registros — Decisão Tomada (v2.2)

Escopo definido pelo usuário:

| Fonte | Escopo | Registros efetivos | Justificativa |
|---|---|---|---|
| **Protocolos** | **Todos** | 2.346 | Busca histórica; não há campo ativo/inativo |
| **Denúncias** | **Só ativas** | ~32 | Archive !== 'True' |
| **Requerimentos** | **Só ativos** | ~404 | Atendimento !== 'True' && Cancelado !== 'True' |
| **Ofícios** | **Só ativos** | ~194 | Cancela !== 'True' && Archive !== 'True' |
| **Alvarás** | **Não cancelados** | ~39.795 | Cancela == '' (334 cancelados excluídos) |

> **Nota**: Os valores reais dos campos boolean são `'True'` (capital T) e `''`
> (vazio). A comparação `.toUpperCase() !== 'TRUE'` é robusta para qualquer caixa.
>
> Os filtros são aplicados na etapa de carregamento (seção 3.3), **antes** do
> matching, reduzindo drasticamente o número de iterações.

### 4.4 Referência Cruzada — Campos Reais vs Código Existente

> Análise do código-fonte de `os.html`, `protocolo.html`, `cvs.html` e
> `alvara.html` confirmou os nomes exatos dos campos e suas inconsistências
> de caixa entre CSVs. Esta seção documenta o mapeamento real.

#### Inconsistência crítica de nomes de campos entre tipos de OS

| Campo | Requerimento | Ofício | Denúncia | Protocolo |
|---|---|---|---|---|
| **Nº OS** | `OS` | `Oficio` | `Denuncia` | `Protocolo` |
| **Fiscal** | `Fiscal_Encaminha` | `Fiscalencaminha` | `FiscalEncaminha` | via `tramitacao.DESTINO` |
| **Data encaminhamento** | `Dt_encaminha` | `Dtencaminha` | `DtEncaminha` | `DATA` (tramitação) |
| **Data do registro** | `Dt_Req` | `Data` | `Data` | `Data` |
| **Atendido** | `Atendimento` | `Archive` | `Archive` | *(sem campo)* |
| **Cancelado** | `Cancelado` | `Cancela` | *(sem campo)* | *(sem campo)* |
| **Nome** | `Requerente` | `Regulado` | `Reclamado` | `Protocolante` |
| **CNPJ** | *(via Codigo→regulados)* | `Cnpj` | `Cnpj` | *(Documento ≠ CNPJ)* |
| **Motivo** | `Motivo` | `Motivo` | `Objeto1` | `Assunto` |
| **Endereço** | *(via Codigo→regulados)* | `Logradouro` | `Logradouro` | — |
| **Bairro** | *(via Codigo→regulados)* | `Cdbai` → bairros.csv | `Cdbai` → bairros.csv | — |
| **Prazo** | `Prazo` | `Prazo` | `Prazo` | — |
| **Código regulado** | `Codigo` | — | — | `Codigo` |

> ⚠️ **Atenção**: Os nomes de campos para "Fiscal" e "Data" variam entre
> os 4 tipos de OS (underscores, CamelCase, tudo junto). Usar os nomes
> **exatos** listados acima.

#### Função `processarBool()` do `os.html`

O código real usa a seguinte lógica para converter campos booleanos:

```javascript
// Extraído de os.html (linha ~1495)
function processarBool(valor) {
    const v = String(valor).toUpperCase();
    return v === 'TRUE' || v === 'SIM' || v === 'T' || v === 'S';
}
```

Aceita: `TRUE`, `true`, `True`, `T`, `SIM`, `Sim`, `S` → `true`
Tudo o resto → `false`

A busca global deve usar a mesma lógica (ou equivalente) para filtrar ativos.

#### Campos de `alvara.csv` confirmados pelo `alvara.html`

| Campo | Uso no `alvara.html` |
|---|---|
| `Codigo` | FK → `regulados.codigo` (JOIN para nome/CNPJ) |
| `Numero` | Número do alvará exibido |
| `Exercicio` | Ano fiscal |
| `Dt_emite` | Data de emissão (badge) |
| `Dt_validade` | Data de validade (badge vigente/vencido) |
| `Cancela` | Flag de cancelamento |
| `Autoridade` | Autoridade responsável |
| `Autenticador` | Código de autenticação |

### 4.5 Limite de Resultados

- Máximo **5 resultados por categoria** exibidos no dropdown
- Se houver mais, exibir link `"Ver todos os X resultados →"` que abre
  a página do módulo correspondente com o filtro pré-aplicado via URL

### 4.6 Considerações de Performance

Com os filtros aplicados, o total de registros pesquisáveis é **muito menor**:

| Fonte | Registros pesquisáveis |
|---|---|
| Regulados | 17.908 |
| Protocolos | 2.346 (todos) |
| Requerimentos | ~404 (só ativos) |
| Denúncias | ~32 (só ativas) |
| Ofícios | ~194 (só ativos) |
| Alvarás | ~39.795 (não cancelados) |
| **Total** | **~60.679** |

- Normalizar o termo de busca **uma vez** antes de todos os loops
- Usar `break` assim que 5 resultados forem encontrados por categoria
- Buscar em ordem de relevância: Regulados → Protocolos → Denúncias → Ofícios → Requerimentos → Alvarás
- Total de iterações no pior caso: ~60K comparações × 3 campos ≈ 180K `includes()` — aceitável (< 40ms)

---

## 5. Layout e Interface

### 5.1 Posicionamento do Campo

O campo é inserido dentro do `.page-header` existente no `index.html`,
após o `<p class="page-subtitle">`, sem alterar nenhuma outra estrutura:

```html
<!-- Inserção no index.html — dentro de .page-header -->
<div class="busca-global-wrapper">
  <div class="busca-global-container" style="position:relative">

    <div class="busca-global-field">
      <span class="busca-icon" id="buscaIcon">🔍</span>
      <input
        type="search"
        id="buscaGlobal"
        class="busca-global-input"
        placeholder="Buscar regulado, OS, CNPJ, protocolo..."
        autocomplete="off"
        spellcheck="false"
        aria-label="Pesquisa global"
        aria-autocomplete="list"
        aria-controls="buscaResultado"
      />
      <kbd class="busca-kbd">Ctrl K</kbd>
    </div>

    <div
      id="buscaResultado"
      class="busca-resultado"
      role="listbox"
      aria-label="Resultados da pesquisa"
      hidden
    ></div>

  </div>
</div>
```

### 5.2 CSS — Campo de Busca

```css
/* === BUSCA GLOBAL === */
.busca-global-wrapper {
  margin-top: 16px;
}

.busca-global-field {
  display: flex;
  align-items: center;
  gap: 10px;
  background: var(--card, #fff);
  border: 1.5px solid var(--line, #e2e8f0);
  border-radius: 12px;
  padding: 10px 14px;
  transition: border-color 0.15s, box-shadow 0.15s;
}
.busca-global-field:focus-within {
  border-color: var(--brand1, #2c5aa0);
  box-shadow: 0 0 0 3px rgba(44, 90, 160, 0.12);
}

.busca-global-input {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  font-size: 0.92rem;
  color: var(--text, #1a1a2e);
  font-family: inherit;
}
.busca-global-input::placeholder { color: var(--muted, #94a3b8); }
.busca-global-input::-webkit-search-cancel-button { display: none; }

.busca-kbd {
  font-size: 0.68rem;
  color: var(--muted, #94a3b8);
  background: var(--bg, #f4f6f9);
  border: 1px solid var(--line, #e2e8f0);
  border-radius: 5px;
  padding: 2px 6px;
  font-family: monospace;
  white-space: nowrap;
  flex-shrink: 0;
}
@media (max-width: 768px) { .busca-kbd { display: none; } }
```

### 5.3 CSS — Painel de Resultados

```css
.busca-resultado {
  position: absolute;
  top: calc(100% + 6px);
  left: 0; right: 0;
  background: var(--card, #fff);
  border: 1px solid var(--line, #e2e8f0);
  border-radius: 14px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.14);
  max-height: 60vh;
  overflow-y: auto;
  z-index: 500;
  padding: 6px 0;
}

.busca-grupo-titulo {
  font-size: 0.68rem;
  font-weight: 700;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--muted, #94a3b8);
  padding: 10px 14px 4px;
}
.busca-grupo-titulo:not(:first-child) {
  border-top: 1px solid var(--line, #e2e8f0);
  margin-top: 4px;
}

.busca-item {
  display: flex;
  align-items: flex-start;
  gap: 10px;
  padding: 9px 14px;
  cursor: pointer;
  text-decoration: none;
  color: var(--text, #1a1a2e);
  transition: background 0.12s;
  border-left: 3px solid transparent;
}
.busca-item:hover,
.busca-item:focus {
  background: rgba(44, 90, 160, 0.06);
  border-left-color: var(--brand1, #2c5aa0);
  outline: none;
}
.busca-item-icon { font-size: 1rem; flex-shrink: 0; margin-top: 1px; }
.busca-item-nome { font-size: 0.87rem; font-weight: 700; color: var(--text-primary, #1a202c); display: block; }
.busca-item-sub  { font-size: 0.78rem; color: var(--muted, #64748b); display: block; margin-top: 1px; }
.busca-item-badge {
  margin-left: auto;
  font-size: 0.68rem;
  font-weight: 700;
  padding: 2px 8px;
  border-radius: 20px;
  flex-shrink: 0;
  align-self: center;
}

.badge-ok      { background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; }
.badge-vencida { background: #fef2f2; color: #dc2626; border: 1px solid #fecaca; }
.badge-avencer { background: #fffbeb; color: #b45309; border: 1px solid #fde68a; }
.badge-aberto  { background: rgba(44,90,160,.08); color: #2c5aa0; border: 1px solid rgba(44,90,160,.2); }

/* Dark mode para badges */
@media (prefers-color-scheme: dark) {
  .badge-ok      { background: rgba(22,163,74,.15); color: #4ade80; border-color: rgba(74,222,128,.25); }
  .badge-vencida { background: rgba(220,38,38,.15); color: #f87171; border-color: rgba(248,113,113,.25); }
  .badge-avencer { background: rgba(180,83,9,.15);  color: #fbbf24; border-color: rgba(251,191,36,.25); }
  .badge-aberto  { background: rgba(107,154,212,.12); color: #93bbef; border-color: rgba(107,154,212,.25); }
}

.busca-ver-todos {
  display: block;
  font-size: 0.78rem;
  font-weight: 600;
  color: var(--brand1, #2c5aa0);
  padding: 6px 14px 8px;
  text-decoration: none;
  opacity: 0.85;
}
.busca-ver-todos:hover { opacity: 1; text-decoration: underline; }

.busca-vazio {
  padding: 20px 14px;
  text-align: center;
  color: var(--muted, #94a3b8);
  font-size: 0.88rem;
}

.busca-loading {
  padding: 16px 14px;
  text-align: center;
  color: var(--muted, #94a3b8);
  font-size: 0.85rem;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}
.busca-spinner {
  width: 14px; height: 14px;
  border: 2px solid var(--line, #e2e8f0);
  border-top-color: var(--brand1, #2c5aa0);
  border-radius: 50%;
  animation: buscaSpin 0.8s linear infinite;
  flex-shrink: 0;
}

@keyframes buscaSpin {
  to { transform: rotate(360deg); }
}
```

### 5.4 CSS — Responsivo Mobile

```css
@media (max-width: 768px) {
  .busca-global-wrapper {
    position: sticky;
    top: 56px;           /* altura exata da .topbar existente */
    z-index: 200;
    background: var(--bg, #f4f6f9);
    padding: 8px 14px 6px;
    margin: 0 -14px;     /* sangrar até a borda da tela */
  }
  .busca-resultado {
    position: fixed;     /* fixo na tela, não relativo ao pai */
    top: 110px;          /* topbar (56px) + campo (54px) */
    left: 0; right: 0;
    border-radius: 0 0 14px 14px;
    max-height: calc(100vh - 120px);
  }
  .busca-item {
    padding: 12px 14px;  /* área de toque mínima 44px */
  }
}
```

### 5.5 Exemplo Visual do Dropdown (dados reais)

```
┌─────────────────────────────────────────────────────┐
│ REGULADOS                                           │
│ 🏪  BRISA SORVETERIA                               │
│     CNPJ: 23.730.770/0001-83                       │
│     Razão: MARCIO FLAVIO DOS SANTOS                │
├─────────────────────────────────────────────────────┤
│ PROTOCOLOS  (histórico completo)                    │
│ 📋  20220015 · JOSE CASSIO ALVES PINTO             │
│     Assunto: PROJETO ARQUITETÔNICO SANITÁRIO       │
│     → NÚCLEO DE ENGENHARIA · 18.01.2022            │
├─────────────────────────────────────────────────────┤
│ DENÚNCIAS  (somente ativas)                         │
│ ⚠️  20210002 · PRAÇA DO AVIÃO          🔵 Aberta  │
│     Reclamado: URBAN                               │
├─────────────────────────────────────────────────────┤
│ OFÍCIOS  (somente ativos)                           │
│ 📨  20240008 · HOSPITAL EVANGÉLICO GOIANO 🔵 Aberto│
│     CNPJ: 46.551.897/0001-42                       │
├─────────────────────────────────────────────────────┤
│ ALVARÁS  (via JOIN alvara.csv → regulados)          │
│ 🏦  Alv. 20260544 · CAFEZINHO DA VOVO  ✅ Vigente │
│     Emissão: 09.03.2026 · Validade: 08.03.2027    │
│ 🏦  Alv. 1602 · sem vínculo cadastral             │
│     Autoridade: CELÚCIA DE FREITAS BORGES          │
└─────────────────────────────────────────────────────┘
```

> **Notas sobre o exemplo**:
> - Protocolos retornam **todos** (histórico); demais só ativos
> - Número de protocolo é numérico puro: `20220015`, não `2025/1.847`
> - Alvarás agora têm **badge de validade** (`Dt_validade` de `alvara.csv`):
>   - `✅ Vigente` — `Dt_validade` >= hoje
>   - `🔴 Vencido` — `Dt_validade` < hoje
>   - Sem badge — `Dt_validade` vazio (19.384 registros)
> - Alvarás sem JOIN (15% dos 40.129) mostram `Autoridade` em vez de nome
> - FK é `Codigo` (não `Controle`): 34.167/40.129 registros vinculam (85%)

---

## 6. Interações e Acessibilidade

| Ação | Comportamento |
|---|---|
| Digitar ≥ 3 chars | Abre dropdown após 400ms (debounce) |
| Digitar < 3 chars | Fecha dropdown |
| `Ctrl+K` / `Cmd+K` | Foca o campo em qualquer posição da página |
| `Esc` | Fecha dropdown, mantém foco no campo |
| `↑` / `↓` | Navega pelos itens do dropdown |
| `Enter` sobre item | Abre o link do item |
| Clique fora | Fecha dropdown (via `mousedown` para evitar bug mobile) |
| Clique em item | Navega para a página do módulo |

---

## 7. Links de Navegação por Tipo de Resultado

> ⚠️ **ATENÇÃO (v2.0)**: Na v1.0, esta seção assumia que `cvs.html`,
> `protocolo.html` e `alvara.html` aceitam query parameters (`?q=`,
> `?num=`). **Isso é falso** — essas páginas não implementam leitura
> de `URLSearchParams` atualmente. Apenas `os.html` suporta `?tipo=`
> e `?fiscal=`.

### 7.1 Estratégia de Navegação

**Opção A — Implementar `?q=` nas páginas de destino (RECOMENDADA)**

Adicionar suporte a query parameter `?q=` em `protocolo.html`, `cvs.html`
e `alvara.html`, preenchendo automaticamente o campo de busca existente
e disparando a pesquisa. Isso exige modificar 3 páginas (escopo adicional).

**Opção B — Navegar sem filtro pré-aplicado**

Simplesmente abrir a página do módulo. O usuário precisará digitar
novamente o termo de busca. Menos útil, mas zero modificações extras.

### 7.2 URLs Geradas (com Opção A implementada)

| Tipo | URL gerada | Status do suporte |
|---|---|---|
| Regulado | `cvs.html?q=CNPJ_OU_NOME` | ❌ Precisa implementar |
| Protocolo | `protocolo.html?q=NUMERO_OU_NOME` | ❌ Precisa implementar |
| Requerimento | `os.html?tipo=Requerimento` | ✅ Funciona hoje |
| Denúncia | `os.html?tipo=Den%C3%BAncia` | ✅ Funciona hoje |
| Ofício | `os.html?tipo=Of%C3%ADcio` | ✅ Funciona hoje |
| Alvará | `alvara.html?q=CNPJ_OU_NOME` | ❌ Precisa implementar |

### 7.3 Implementação do `?q=` nas Páginas de Destino

Padrão mínimo a adicionar no `DOMContentLoaded` de cada página:

```javascript
// Adicionar em protocolo.html, cvs.html, alvara.html:
const urlParams = new URLSearchParams(window.location.search);
const qParam = urlParams.get('q');
if (qParam) {
  const campoBusca = document.getElementById('campoBusca'); // ajustar ID
  if (campoBusca) {
    campoBusca.value = qParam;
    // Disparar busca automaticamente
    executarBusca(); // ajustar nome da função
  }
}
```

---

## 8. Inicialização no `index.html`

A função `initBuscaGlobal()` deve ser chamada **somente após** o login
e o carregamento do perfil — dentro do bloco que já executa
`carregarOSPendentesFiscal()` ou `carregarOSAdmin()`:

```javascript
// Dentro do onAuthStateChanged, após setUserInfoPerfil(perfil, user):
import('./js/busca-global.js').then(({ initBuscaGlobal }) => {
  initBuscaGlobal();
});
```

O import dinâmico garante que o módulo **não seja baixado** na tela de
login — somente após a autenticação ser confirmada.

---

## 9. Plano de Implementação

| Fase | Tarefa | Detalhe |
|---|---|---|
| **1** | Criar `js/busca-global.js` — estrutura base | Cache com Promise compartilhada, `parseCSV()` com delimiter `;`, `limparCacheBusca()` |
| **2** | Matching para Regulados | Campos: `fantasia`, `razao`, `documento` do JSON |
| **3** | Matching para Protocolos + Tramitação | Campos: `Protocolo`, `Protocolante`, `Assunto`; enriquecido com `mapaTramitacao` |
| **4** | Matching para Denúncias + Requerimentos + Ofícios | Denúncia: `Denuncia`, `Reclamado`, `Logradouro`, `Cnpj`; Req: `OS`, `Requerente`; Ofício: `Oficio`, `Regulado`, `Cnpj` |
| **5** | Matching para Alvarás com JOIN | JOIN `alvara.Codigo` ↔ `regulados.codigo`; busca em `_fantasia`, `_razao`, `_documento`, `Numero`, `Autoridade`; badge via `Dt_validade` |
| **6** | Renderizador do dropdown | HTML + badges de status + filtro de cancelados/arquivados |
| **7** | CSS completo | Campo, dropdown, dark mode (incluindo badges), responsivo, `@keyframes buscaSpin` |
| **8** | Inserir HTML no `index.html` + import dinâmico | Inserir no `.page-header` após `#dashboardSubtitle`; import após auth |
| **9** | Navegação por teclado + Ctrl+K | `↑↓` com `aria-activedescendant`, `Enter`, `Esc`, `mousedown` para fechar |
| **10** | Implementar `?q=` nas páginas de destino | `protocolo.html`, `cvs.html`, `alvara.html` — ler param e disparar busca |
| **11** | Integrar `limparCacheBusca()` no logout | Chamar no `window.logout` e no expirar de sessão |
| **12** | Testes | Mobile, dark mode, Fiscal vs Admin, alvará sem correspondência, CNPJ formatado vs sem formato |

---

## 10. Riscos e Mitigações

| Risco | Prob. | Mitigação |
|---|---|---|
| `alvara.csv` (8,2 MB / 40.129 registros) lento em 3G | **Alta** | Carregar só 8 campos essenciais via PapaParse; spinner com mensagem |
| `requerimento.csv` (3,7 MB) lento em 3G | Média | Spinner; carregar só 6 campos essenciais |
| CNPJ consistente (`XX.XXX.XXX/XXXX-XX`) em todas as fontes | Baixa | `norm()` remove `.`, `-`, `/` — cobre busca com e sem formatação |
| Nomes de campos com caixa inconsistente entre CSVs | **Alta** | Usar nomes exatos: `Cnpj` (denúncia/ofício), `PROTOCOLO` (tramitação), `Regulado` (ofício), `Codigo` (alvará FK) |
| 5.962 alvarás sem correspondência em regulados (15%) | Média | Pesquisáveis por nº alvará e `Autoridade`; exibir "(sem vínculo cadastral)" |
| `oficio.csv` campo `Fantasia` quase vazio (195/6213) | **Alta** | Usar campo `Regulado` (100% preenchido) como campo de busca principal |
| Páginas de destino sem suporte a `?q=` | **Alta** | Fase 10 do plano; sem isso, links abrem a página sem filtro pré-aplicado |
| `Dt_validade` vazio em 19.384/40.129 alvarás (48%) | Média | Não exibir badge quando vazio; exibir apenas emissão se disponível |
| Dropdown some ao clicar (mobile — evento `blur`) | Média | Usar `mousedown` em vez de `click` para itens do dropdown |
| Memória (~6 MB de dados após seleção de campos) | Baixa | Aceitável para uso moderno; `limparCacheBusca()` no logout |
| Race condition em chamadas simultâneas | Média | Promise compartilhada `_promiseCarregamento` (v2.0) |

---

## 11. Pré-requisitos (NOVO na v2.0)

Antes de iniciar a implementação da busca global, verificar:

1. **PapaParse** já está carregado no `index.html` via CDN ✅
2. **`index_regulados.json`** está atualizado e acessível ✅
3. **Todos os CSVs** usam delimiter `;` e estão com cabeçalhos corretos ✅
4. **`os.html`** suporta `?tipo=` ✅
5. **`protocolo.html`**, **`cvs.html`**, **`alvara.html`** precisam de
   suporte a `?q=` — implementar na Fase 10 ou antes

---

## 12. Considerações Finais

- **Zero dependências novas** — PapaParse já está no `index.html`,
  padrão ES Module já é usado em todo o projeto
- **Não quebra nada existente** — inserção é estritamente aditiva,
  sem alterar nenhuma lógica atual do dashboard
- **Escalável** — adicionar nova fonte (ex.: `rdpf.csv`) é inserir
  um bloco no `Promise.all` e um renderizador de grupo
- **Consistente com o design system** — usa 100% das variáveis CSS
  e classes já definidas (`var(--card)`, `var(--brand1)` etc.)
- **Funciona offline (PWA)** — se os CSVs estiverem no cache do
  Service Worker, a busca funciona sem conexão
- **Dark mode automático** — herda todas as variáveis CSS; badges
  têm variantes dark mode explícitas (v2.0)
- **JOIN Alvarás-Regulados** — `alvara.csv.Codigo` ↔ `regulados.codigo`
  (85% de cobertura); inclui `Dt_emite`/`Dt_validade` para badge de vencimento
- **Race-condition-free** — Promise compartilhada substitui flag
  booleana que silenciava erros (v2.0)

---

*Documento original: 09/03/2026 · Revisão v2.0: 10/03/2026 · Revisão v2.3: 10/03/2026*
*Vigilância Sanitária — Diretoria de Vigilância em Saúde · Anápolis – GO*
