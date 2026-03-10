# Especificação Técnica — Pesquisa Global Unificada
## VISA Anápolis · APP garrado/VISA

**Versão:** 2.0
**Data:** 10/03/2026
**Autor original:** Cláudio Nascimento Silva
**Revisão técnica:** Claude (Opus 4.6) — validação contra codebase real
**Status:** Proposta revisada para implementação

---

## Changelog v1.0 → v2.0

| # | Problema na v1.0 | Correção na v2.0 |
|---|---|---|
| 1 | Nomes de campos fictícios na seção 4.2 (`NomeFantasia`, `RazaoSocial`, `CNPJ`, `NumReq`, `NumDenuncia`, `NumOficio`, `Endereco`) não existem nos CSVs reais | Mapeamento corrigido com nomes reais dos campos de cada arquivo |
| 2 | `index_regulados.json` referenciado com campo `Endereco` — campo inexistente (JSON só tem `codigo`, `razao`, `fantasia`, `documento`) | Removido `Endereco` da lista de campos pesquisáveis em Regulados |
| 3 | `alvlib.csv` listado como pesquisável por `NomeFantasia`, `RazaoSocial`, `CNPJ` — nenhum desses campos existe nesse CSV | Estratégia de JOIN: busca via `Controle` (FK) cruzando com `index_regulados.json` |
| 4 | URLs de navegação (`cvs.html?q=`, `protocolo.html?num=`, `alvara.html?q=`) pressupõem query params que **não existem** nessas páginas | Seção 7 reescrita: links reais (somente `os.html?tipo=` funciona hoje); demais páginas precisam de adaptação prévia ou estratégia alternativa |
| 5 | `parseCSV()` não especifica `delimiter: ';'` — todos os CSVs usam ponto-e-vírgula | Corrigido no código de cache e na função `parseCSV()` |
| 6 | Race condition na flag `_carregando`: segundo chamador recebe `null` silenciosamente | Substituído por Promise compartilhada (`_promiseCarregamento`) |
| 7 | `Date.now()` como cache-buster força re-download a cada nova aba | Substituído por cache-buster baseado em data (granularidade diária) |
| 8 | Faltava `@keyframes spin` no CSS (referenciado mas não definido) | Adicionado |
| 9 | Badge colors hardcoded sem variantes dark mode | Adicionadas variantes dark mode para badges |
| 10 | Contagem de registros não mencionada (impacta performance) | Adicionada: 17.908 regulados, 2.370 protocolos, 13.194 requerimentos, 2.984 denúncias, 6.225 ofícios, 38.895 alvlib |

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

| Arquivo | Tamanho | Registros | Incluir na Busca | Observação |
|---|---|---|---|---|
| `index_regulados.json` | **2,1 MB** | 17.908 | ✅ Sim | Fonte primária de regulados |
| `regulados.csv` | 7,9 MB | — | ❌ Não | Grande demais; usar o JSON |
| `protocolo.csv` | 530 KB | 2.370 | ✅ Sim | Já carregado pelos stat cards |
| `tramitacao.csv` | 529 KB | 9.009 | ✅ Sim | Enriquece protocolos (JOIN) |
| `requerimento.csv` | **3,7 MB** | 13.194 | ⚠️ Parcial | Carregar só campos essenciais |
| `denuncia.csv` | 1,3 MB | 2.984 | ✅ Sim | Tamanho aceitável |
| `oficio.csv` | 2,0 MB | 6.225 | ⚠️ Parcial | Carregar só campos essenciais |
| `alvara.csv` | 8,2 MB | — | ❌ Não | Grande demais; usar alvlib |
| `alvlib.csv` | 3,7 MB | 38.895 | ⚠️ JOIN | Sem campos de nome; busca via cruzamento com regulados |
| `inspecoes.csv` | **19,7 MB** | — | ❌ Não | Inviável para busca client-side |
| `os_snapshot.json` | 11,8 MB | — | ❌ Não | Grande demais; usar CSVs acima |

### 2.1 Estrutura Real dos Campos (verificação contra CSVs)

> **ATENÇÃO**: Os nomes dos campos abaixo são os nomes **reais** extraídos
> dos cabeçalhos dos CSVs. Todos os CSVs usam **`;`** como delimitador.

| Arquivo | Campos reais relevantes para busca |
|---|---|
| `index_regulados.json` | `codigo`, `razao`, `fantasia`, `documento` |
| `protocolo.csv` | `Protocolo`, `Protocolante`, `Documento`, `Assunto` |
| `tramitacao.csv` | `PROTOCOLO`, `DATA`, `HORA`, `DESTINO` |
| `requerimento.csv` | `OS`, `Requerente`, `Prazo`, `Fiscal_Encaminha`, `Atendimento`, `Cancelado` |
| `denuncia.csv` | `Denuncia`, `Reclamado`, `Logradouro`, `Cnpj`, `Prazo`, `FiscalEncaminha`, `Archive` |
| `oficio.csv` | `Oficio`, `Fantasia`, `Regulado`, `Cnpj`, `Logradouro`, `Prazo`, `Fiscalencaminha`, `Cancela`, `Archive` |
| `alvlib.csv` | `Controle`, `Alvara`, `Data`, `Status`, `Atividade`, `Autoridade`, `Documento` |

### 2.2 Conclusão do Inventário

> ⚠️ **Atenção crítica:** `requerimento.csv` (3,7 MB), `oficio.csv`
> (2,0 MB) e `alvlib.csv` (3,7 MB) são carregáveis, mas pesados.
> A estratégia de **lazy loading com cache em memória** é obrigatória,
> não opcional. Esses três arquivos **jamais devem ser carregados na
> abertura da página** — somente na primeira busca do usuário.

> ⚠️ **`alvlib.csv` não possui campos de nome fantasia, razão social
> ou CNPJ.** A busca de alvarás por nome do estabelecimento exige
> cruzamento com `index_regulados.json` via chave `Controle` ↔ `codigo`.
> Essa intersecção cobre 15.215 dos 38.895 registros do alvlib.

**Peso total dos arquivos incluídos:** ~10,1 MB
**Peso estimado após seleção de campos (PapaParse):** ~3–4 MB efetivos na memória

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
  PapaParse alvlib.csv          // 3,7 MB (campos selecionados)
])
        │
        ▼
Pós-processamento:
  - Constrói mapa regulados: Map<codigo, {razao, fantasia, documento}>
  - Enriquece alvlib com dados de regulados via Controle ↔ codigo
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

  const [reguladosJson, protocolos, tramitacoes, denuncias,
         requerimentos, oficios, alvaras] =
    await Promise.all([
      fetch(`data/index_regulados.json?d=${hoje}`).then(r => r.json()),
      parseCSV(`data/protocolo.csv?d=${hoje}`),
      parseCSV(`data/tramitacao.csv?d=${hoje}`),
      parseCSV(`data/denuncia.csv?d=${hoje}`),
      parseCSV(`data/requerimento.csv?d=${hoje}`,
               ['OS', 'Requerente', 'Prazo', 'Fiscal_Encaminha',
                'Atendimento', 'Cancelado']),
      parseCSV(`data/oficio.csv?d=${hoje}`,
               ['Oficio', 'Fantasia', 'Regulado', 'Cnpj', 'Logradouro',
                'Prazo', 'Fiscalencaminha', 'Cancela', 'Archive']),
      parseCSV(`data/alvlib.csv?d=${hoje}`,
               ['Controle', 'Alvara', 'Data', 'Status', 'Atividade',
                'Autoridade'])
    ]);

  // Extrair array de dados do JSON (estrutura: { meta, dados })
  const regulados = reguladosJson.dados || reguladosJson;

  // Mapa de regulados para JOIN com alvlib
  const mapaRegulados = new Map();
  for (const r of regulados) {
    mapaRegulados.set(String(r.codigo), r);
  }

  // Enriquecer alvlib com dados de regulados
  for (const a of alvaras) {
    const reg = mapaRegulados.get(a.Controle);
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
           requerimentos, oficios, alvaras,
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

### 4.2 Campos Pesquisados por Fonte (NOMES REAIS)

| Fonte | Campos reais pesquisados | Campos exibidos no resultado |
|---|---|---|
| **Regulados** (`index_regulados.json`) | `fantasia`, `razao`, `documento` | Nome fantasia, CNPJ |
| **Protocolos** (`protocolo.csv`) | `Protocolo`, `Protocolante`, `Documento`, `Assunto` | Nº protocolo, protocolante, data tramitação |
| **Requerimentos** (`requerimento.csv`) | `OS`, `Requerente` | Nº OS, requerente, prazo |
| **Denúncias** (`denuncia.csv`) | `Denuncia`, `Reclamado`, `Logradouro`, `Cnpj` | Nº denúncia, reclamado, endereço |
| **Ofícios** (`oficio.csv`) | `Oficio`, `Fantasia`, `Regulado`, `Cnpj` | Nº ofício, nome fantasia, CNPJ |
| **Alvarás** (`alvlib.csv` + JOIN) | `_fantasia`, `_razao`, `_documento`, `Alvara`, `Autoridade` | Nº alvará, nome, atividade CNAE |

> **Nota sobre Alvarás**: O `alvlib.csv` não possui campos de nome/CNPJ.
> Os campos `_fantasia`, `_razao` e `_documento` são injetados via JOIN
> com `index_regulados.json` na etapa de pós-processamento (seção 3.3).
> Registros sem correspondência (23.680 de 38.895) serão pesquisáveis
> apenas por `Alvara` (número) e `Autoridade` (nome da pessoa autorizada).

### 4.3 Filtros de Registros Ativos

Antes do matching, filtrar registros inativos/cancelados:

```javascript
// Requerimentos: ignorar atendidos e cancelados
requerimentos.filter(r =>
  String(r.Atendimento || '').trim().toUpperCase() !== 'TRUE' &&
  String(r.Cancelado || '').trim().toUpperCase() !== 'TRUE'
);

// Denúncias: ignorar arquivadas
denuncias.filter(d =>
  String(d.Archive || '').trim().toUpperCase() !== 'TRUE'
);

// Ofícios: ignorar cancelados e arquivados
oficios.filter(o =>
  String(o.Cancela || '').trim().toUpperCase() !== 'TRUE' &&
  String(o.Archive || '').trim().toUpperCase() !== 'TRUE'
);
```

### 4.4 Limite de Resultados

- Máximo **5 resultados por categoria** exibidos no dropdown
- Se houver mais, exibir link `"Ver todos os X resultados →"` que abre
  a página do módulo correspondente com o filtro pré-aplicado via URL

### 4.5 Considerações de Performance

Com ~83.000 registros totais (17.908 + 2.370 + 13.194 + 2.984 + 6.225 + 38.895),
o loop de matching deve ser otimizado:

- Normalizar o termo de busca **uma vez** antes de todos os loops
- Usar `break` assim que 5 resultados forem encontrados por categoria
- Buscar em ordem de relevância: Regulados → Protocolos → Denúncias → Ofícios → Requerimentos → Alvarás
- Total de iterações no pior caso: ~83K comparações × 3 campos ≈ 250K `includes()` — aceitável (< 50ms em hardware moderno)

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

### 5.5 Exemplo Visual do Dropdown

```
┌─────────────────────────────────────────────────────┐
│ REGULADOS                                           │
│ 🏪  Farmácia Boa Saúde                    ✅ Ativo │
│     CNPJ: 12.345.678/0001-00 · CNAE: 4771-7/01    │
│ 🏪  Farmácia Popular LTDA               ⚠️ Vencido│
│     CNPJ: 98.765.432/0001-55 · CNAE: 4771-7/02    │
├─────────────────────────────────────────────────────┤
│ PROTOCOLOS                                          │
│ 📋  Prot. 20220015 · JOSE CASSIO ALVES   🔴 Vencida│
│     Assunto: PROJETO ARQUITETÔNICO SANITÁRIO       │
│ 📋  Prot. 20240210 · MARIA SILVA          ✅ OK    │
│     Tramitado: 10/02/2026 → DVISA                  │
├─────────────────────────────────────────────────────┤
│ DENÚNCIAS                                           │
│ ⚠️  Den. 456/2025 · Rua das Flores, 123 🔵 Aberta │
│     Reclamado: FARMÁCIA BOA SAÚDE                  │
├─────────────────────────────────────────────────────┤
│ OFÍCIOS                                             │
│ 📨  Of. 789/2025 · Farmácia Popular       🔵 Aberto│
│     CNPJ: 98.765.432/0001-55                       │
├─────────────────────────────────────────────────────┤
│ ALVARÁS                                             │
│ 🏦  Alv. 5182 · Farmácia Boa Saúde     ✅ Vigente │
│     CNAE: 9602-5/01                                │
└─────────────────────────────────────────────────────┘
```

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
| **3** | Matching para Protocolos + Tramitação | Campos: `Protocolo`, `Protocolante`, `Documento`; enriquecido com `mapaTramitacao` |
| **4** | Matching para Denúncias + Requerimentos + Ofícios | Denúncia: `Denuncia`, `Reclamado`, `Logradouro`, `Cnpj`; Req: `OS`, `Requerente`; Ofício: `Oficio`, `Fantasia`, `Cnpj` |
| **5** | Matching para Alvarás com JOIN | JOIN `alvlib.Controle` ↔ `regulados.codigo`; busca em `_fantasia`, `_razao`, `_documento`, `Alvara`, `Autoridade` |
| **6** | Renderizador do dropdown | HTML + badges de status + filtro de cancelados/arquivados |
| **7** | CSS completo | Campo, dropdown, dark mode (incluindo badges), responsivo, `@keyframes buscaSpin` |
| **8** | Inserir HTML no `index.html` + import dinâmico | Inserir no `.page-header` após `#dashboardSubtitle`; import após auth |
| **9** | Navegação por teclado + Ctrl+K | `↑↓` com `aria-activedescendant`, `Enter`, `Esc`, `mousedown` para fechar |
| **10** | Implementar `?q=` nas páginas de destino | `protocolo.html`, `cvs.html`, `alvara.html` — ler param e disparar busca |
| **11** | Integrar `limparCacheBusca()` no logout | Chamar no `window.logout` e no expirar de sessão |
| **12** | Testes | Mobile, dark mode, Fiscal vs Admin, alvará sem correspondência, CNPJ formatado vs sem formato |

---

## 10. Riscos e Mitigações

| Risco | Probabilidade | Mitigação |
|---|---|---|
| `requerimento.csv` (3,7 MB) lento em 3G | Média | Spinner com mensagem; carregar só 6 campos essenciais |
| `alvlib.csv` (3,7 MB / 38.895 registros) lento em 3G | Média | Carregar só 6 campos; JOIN reduz busca textual a 15.215 registros |
| CNPJ com formatação diferente entre arquivos | **Alta** | `norm()` já remove `.`, `-`, `/`; testar: `12345678000100` vs `12.345.678/0001-00` |
| Nomes de campos com caixa inconsistente entre CSVs | **Alta** | `Cnpj` (denúncia/ofício), `PROTOCOLO` (tramitação) — acessar exatamente como no cabeçalho |
| 23.680 alvarás sem correspondência em regulados | Média | Pesquisáveis apenas por nº alvará e nome Autoridade; exibir "(sem vínculo)" |
| Páginas de destino sem suporte a `?q=` | **Alta** | Implementar antes ou junto com a busca global (Fase 10) |
| Dropdown some ao clicar (mobile — evento `blur`) | Média | Usar `mousedown` em vez de `click` para itens do dropdown |
| Memória (~10 MB de dados em RAM) | Baixa | Aceitável para uso moderno; `limparCacheBusca()` no logout |
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
- **JOIN Alvarás-Regulados** — estratégia nova na v2.0 que resolve
  a ausência de campos de nome/CNPJ no `alvlib.csv`
- **Race-condition-free** — Promise compartilhada substitui flag
  booleana que silenciava erros (v2.0)

---

*Documento original: 09/03/2026 · Revisão v2.0: 10/03/2026*
*Vigilância Sanitária — Diretoria de Vigilância em Saúde · Anápolis – GO*
