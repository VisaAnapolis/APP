# Especificação Técnica — Pesquisa Global Unificada
## VISA Anápolis · APP garrado/VISA

**Versão:** 1.0  
**Data:** 09/03/2026  
**Autor:** Cláudio Nascimento Silva  
**Status:** Proposta para implementação

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

Levantamento dos arquivos reais no repositório (`data/`):

| Arquivo | Tamanho Real | Incluir na Busca | Observação |
|---|---|---|---|
| `index_regulados.json` | **2,1 MB** | ✅ Sim | Fonte primária de regulados |
| `regulados.csv` | 8,3 MB | ❌ Não | Grande demais; usar o JSON |
| `protocolo.csv` | 543 KB | ✅ Sim | Já carregado pelos stat cards |
| `tramitacao.csv` | 541 KB | ✅ Sim | Já carregado pelos stat cards |
| `requerimento.csv` | **3,9 MB** | ⚠️ Parcial | Carregar só campos essenciais |
| `denuncia.csv` | 1,3 MB | ✅ Sim | Tamanho aceitável |
| `oficio.csv` | 2,0 MB | ⚠️ Parcial | Carregar só campos essenciais |
| `alvara.csv` | **8,5 MB** | ❌ Não | Grande demais; usar alvlib |
| `alvlib.csv` | 3,9 MB | ⚠️ Parcial | Somente campos chave |
| `inspecoes.csv` | **19,7 MB** | ❌ Não | Inviável para busca client-side |
| `os_snapshot.json` | 11,8 MB | ❌ Não | Grande demais; usar CSVs acima |

### 2.1 Conclusão do Inventário

> ⚠️ **Atenção crítica:** `requerimento.csv` (3,9 MB), `oficio.csv`
> (2,0 MB) e `alvlib.csv` (3,9 MB) são carregáveis, mas pesados.
> A estratégia de **lazy loading com cache em memória** é obrigatória,
> não opcional. Esses três arquivos **jamais devem ser carregados na
> abertura da página** — somente na primeira busca do usuário.

**Peso total dos arquivos incluídos:** ~10,4 MB  
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
  fetch index_regulados.json,   // 2,1 MB
  PapaParse protocolo.csv,      // 543 KB
  PapaParse tramitacao.csv,     // 541 KB
  PapaParse denuncia.csv,       // 1,3 MB
  PapaParse requerimento.csv,   // 3,9 MB (campos selecionados)
  PapaParse oficio.csv,         // 2,0 MB (campos selecionados)
  PapaParse alvlib.csv          // 3,9 MB (campos selecionados)
])
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
let _carregando  = false;

async function garantirDadosCarregados() {
  if (_cacheBusca) return _cacheBusca;   // hit: retorno imediato
  if (_carregando) return null;          // evita duplo fetch simultâneo

  _carregando = true;
  mostrarSpinnerNoCampo(true);

  try {
    const ts = Date.now();

    const [regulados, protocolos, tramitacoes, denuncias,
           requerimentos, oficios, alvaras] =
      await Promise.all([
        fetch(`data/index_regulados.json?t=${ts}`).then(r => r.json()),
        parseCSV(`data/protocolo.csv?t=${ts}`),
        parseCSV(`data/tramitacao.csv?t=${ts}`),
        parseCSV(`data/denuncia.csv?t=${ts}`),
        parseCSV(`data/requerimento.csv?t=${ts}`),
        parseCSV(`data/oficio.csv?t=${ts}`),
        parseCSV(`data/alvlib.csv?t=${ts}`)
      ]);

    _cacheBusca = { regulados, protocolos, tramitacoes,
                    denuncias, requerimentos, oficios, alvaras };
    return _cacheBusca;

  } catch (e) {
    console.error('[BuscaGlobal] Falha ao carregar dados:', e);
    return null;
  } finally {
    _carregando = false;
    mostrarSpinnerNoCampo(false);
  }
}
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

function match(campo, termo) {
  return norm(campo).includes(norm(termo));
}
```

### 4.2 Campos Pesquisados por Fonte

| Fonte | Campos indexados |
|---|---|
| **Regulados** | `NomeFantasia`, `RazaoSocial`, `CNPJ`, `Endereco` |
| **Protocolos** | `Protocolo` (nº), `NomeFantasia`, `RazaoSocial`, `CNPJ` |
| **Requerimentos** | `NumReq`, `NomeFantasia`, `CNPJ` |
| **Denúncias** | `NumDenuncia`, `Endereco`, `NomeFantasia` |
| **Ofícios** | `NumOficio`, `NomeFantasia`, `CNPJ` |
| **Alvarás** | `NomeFantasia`, `RazaoSocial`, `CNPJ` |

### 4.3 Limite de Resultados

- Máximo **5 resultados por categoria** exibidos no dropdown
- Se houver mais, exibir link `"Ver todos os X resultados →"` que abre
  a página do módulo correspondente com o filtro pré-aplicado via URL

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
  border: 2px solid #e2e8f0;
  border-top-color: var(--brand1, #2c5aa0);
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
  flex-shrink: 0;
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
│ 📋  2025/1.847 · Farmácia Boa Saúde     🔴 Vencida│
│     Fiscal: CLÁUDIO · Tramitado: 10/02/2026        │
│ 📋  2024/3.210 · Farmácia Popular        ✅ OK     │
│     Concluído                                       │
├─────────────────────────────────────────────────────┤
│ DENÚNCIAS                                           │
│ ⚠️  Den. 456/2025 · Rua das Flores, 123 🔵 Aberta │
│     Prazo: 15/03/2026 · Fiscal: THIAGO             │
├─────────────────────────────────────────────────────┤
│ ALVARÁS                                             │
│ 🏦  Farmácia Boa Saúde                  ✅ Vigente │
│     Validade: 31/12/2026                           │
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
| Clique fora | Fecha dropdown |
| Clique em item | Navega para a página do módulo |

---

## 7. Links de Navegação por Tipo de Resultado

Cada item do dropdown linka diretamente para a página correspondente,
aproveitando os parâmetros de URL já existentes no app:

| Tipo | URL gerada |
|---|---|
| Regulado | `cvs.html?q=CNPJ_OU_NOME` |
| Protocolo | `protocolo.html?num=2025/1847` |
| Requerimento | `os.html?tipo=Requerimento&q=NOME` |
| Denúncia | `os.html?tipo=Den%C3%BAncia&q=NOME` |
| Ofício | `os.html?tipo=Of%C3%ADcio&q=NOME` |
| Alvará | `alvara.html?q=CNPJ_OU_NOME` |

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

| Fase | Tarefa | Estimativa |
|---|---|---|
| **1** | Criar `js/busca-global.js` com estrutura base, cache e parseCSV | 4h |
| **2** | Matching para Regulados (`index_regulados.json`) | 2h |
| **3** | Matching para Protocolos + Tramitação | 2h |
| **4** | Matching para Denúncias + Requerimentos + Ofícios | 3h |
| **5** | Matching para Alvarás (`alvlib.csv`) | 2h |
| **6** | Renderizador do dropdown (HTML + badges) | 3h |
| **7** | CSS completo (campo, dropdown, dark mode, responsivo) | 2h |
| **8** | Inserir HTML no `index.html` + import dinâmico | 1h |
| **9** | Navegação por teclado (↑↓ Enter Esc) + atalho Ctrl+K | 2h |
| **10** | Testes: mobile, dark mode, Fiscal e Administrador | 2h |
| | **Total estimado** | **~23h** |

---

## 10. Riscos e Mitigações

| Risco | Probabilidade | Mitigação |
|---|---|---|
| `requerimento.csv` (3,9 MB) lento em 3G | Média | Spinner com mensagem; carregar campos selecionados |
| `alvlib.csv` (3,9 MB) idem | Média | Mesmo tratamento acima |
| CNPJ com formatação diferente entre arquivos | Alta | Normalizar: remover `.`, `-`, `/` antes de comparar |
| Campo de Prazo em formato variado | Média | Reutilizar `parseData()` já existente no `index.html` |
| Nome do fiscal em caixa mista | Alta | Reutilizar `.normalize('NFD')` já usado no projeto |
| Dropdown some ao clicar (mobile — evento `blur`) | Média | Usar `mousedown` em vez de `click` para fechar |
| Memória (~10 MB de dados em RAM) | Baixa | Aceitável para uso moderno; limpar `_cacheBusca` no logout |

---

## 11. Considerações Finais

- **Zero dependências novas** — PapaParse já está no `index.html`,
  padrão ES Module já é usado em todo o projeto
- **Não quebra nada existente** — inserção é estritamente aditiva,
  sem alterar nenhuma lógica atual
- **Escalável** — adicionar nova fonte (ex.: `rdpf.csv`) é inserir
  um bloco no `Promise.all` e um renderizador de grupo
- **Consistente com o design system** — usa 100% das variáveis CSS
  e classes já definidas (`var(--card)`, `var(--brand1)` etc.)
- **Funciona offline (PWA)** — se os CSVs estiverem no cache do
  Service Worker, a busca funciona sem conexão
- **Dark mode automático** — herda todas as variáveis CSS sem CSS extra

---

*Documento gerado em 09/03/2026 · Vigilância Sanitária — Diretoria de Vigilância em Saúde · Anápolis – GO*
