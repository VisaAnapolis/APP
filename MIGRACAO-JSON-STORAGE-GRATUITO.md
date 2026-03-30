# Plano de Migração: Apenas JSONs Sensíveis → Firebase Storage (Plano Gratuito)

## Contexto

Migração cirúrgica: apenas os arquivos JSON que contêm dados sensíveis protegidos pela
LGPD são movidos para Firebase Storage. Os CSVs permanecem no GitHub Pages pois seus
dados (CNPJ, endereço comercial, valor de taxas) são de interesse público e defensáveis
juridicamente como transparência administrativa.

**Motivação LGPD:**
- `data/his/**/*.json` — notas de inspeção sanitária, não conformidades, intimações.
  Registro de processo administrativo sancionatório. Claramente protegido.
- `data/index_regulados.json` — contém CPF de profissionais liberais vinculado a nome
  e endereço comercial. Sensível mesmo no contexto de atividade econômica regulada.

**Por que não os CSVs:**
- CNPJ, razão social, endereço comercial → Receita Federal publica abertamente
- Situação do alvará → interesse público do consumidor (ANVISA publica)
- Valor de taxas → calculado por tabela pública municipal, não é dado fiscal sigiloso
- Complexidade (`complexidade_regulados.json`) → apenas classificação ALTA/MÉDIA/BAIXA,
  sem PII — fica no GitHub Pages

---

## Arquivos JSON a Migrar

| Arquivo | Tamanho | Motivo |
|---------|---------|--------|
| `data/index_regulados.json` | 2.1 MB | Contém CPF/CNPJ + nome (campo `documento`) |
| `data/his/**/*.json` | 438 MB (106.417 arquivos) | Notas de inspeção — processo administrativo |

**Total no Storage: ~440 MB** (dentro do limite gratuito de 5 GB)

---

## Estimativa de Banda (Plano Spark Gratuito)

| Arquivo | Carga | Estimativa diária |
|---------|-------|-----------------|
| `index_regulados.json` | 15 usuários × 2 páginas × 2.1 MB | ~63 MB/dia |
| `his/XX/NDOC.json` | ~50 aberturas × ~1 KB | ~50 KB/dia |
| **Total** | | **~63 MB/dia** |

Limite gratuito: 1 GB/dia → **uso real: ~6% do limite. Custo: $0.**

---

## Arquivos de Código a Modificar

| Arquivo | O que muda |
|---------|-----------|
| `js/storage-utils.js` | **CRIAR** — funções `getStorageUrl()` e `fetchStorageTimestamp()` |
| `js/regulados1.js` | his/ lazy load + fetch de `index_regulados.json` → Storage |
| `js/busca-global.js` | Fetch de `index_regulados.json` → Storage |
| `js/simxcvs.js` | Fetch de `index_regulados.json` → Storage |
| `total.html` | Valor default do input `#indexUrl` |
| `analise.html` | Valor default do input `#indexUrl` |
| Todos HTMLs afetados | Adicionar `firebase-storage-compat.js` no `<head>` |

**HTMLs que precisam do SDK Storage** (os que carregam os JS acima):
`cvs.html`, `index.html`, `simxcvs.html`, `total.html`, `analise.html`

---

## Etapa 0 — Pré-requisito: Deletar login.csv

`data/login.csv` não é usado em nenhum arquivo do projeto (confirmado por grep) mas
contém senhas em texto puro de 53 usuários. Deve ser removido do repositório e do
histórico Git antes de qualquer outra etapa.

```bash
# 1. Instalar BFG Repo Cleaner (requer Java):
#    Download: https://rtyley.github.io/bfg-repo-cleaner/

# 2. Clone espelho para limpeza de histórico
git clone --mirror https://github.com/garrado/VISA.git visa-mirror.git
cd visa-mirror.git
java -jar bfg.jar --delete-files login.csv
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push --force

# 3. No repositório local, remover e commitar
git rm data/login.csv
git commit -m "remove: login.csv não utilizado (dado sensível)"
git push
```

> ⚠️ `git push --force` reescreve histórico público. Outros colaboradores precisarão
> fazer `git clone` novamente após esta etapa.

---

## Etapa 1 — Configurar Firebase Storage

### 1.1 Ativar Storage no Console Firebase

1. Acesse console.firebase.google.com → Projeto `visam-3a30b`
2. Menu lateral → **Storage** → **Começar**
3. Região: `southamerica-east1` (São Paulo)
4. Confirmar criação

### 1.2 Configurar CORS

Criar `cors.json` na raiz do projeto:

```json
[
  {
    "origin": ["https://garrado.github.io"],
    "method": ["GET", "HEAD"],
    "maxAgeSeconds": 600,
    "responseHeader": ["Content-Type", "Cache-Control"]
  }
]
```

Aplicar:

```bash
gsutil cors set cors.json gs://visam-3a30b.appspot.com
```

### 1.3 Regras de Segurança

No Console Firebase → Storage → Regras:

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /data/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if false;
    }
  }
}
```

### 1.4 Upload Inicial

```bash
# index_regulados.json
gsutil cp data/index_regulados.json gs://visam-3a30b.appspot.com/data/index_regulados.json

# Todos os arquivos his/ (paralelo — são 106k arquivos)
gsutil -m cp -r data/his/ gs://visam-3a30b.appspot.com/data/his/

# Cache-Control
gsutil setmeta -h "Cache-Control:public, max-age=600" \
  gs://visam-3a30b.appspot.com/data/index_regulados.json

gsutil -m setmeta -h "Cache-Control:public, max-age=3600" \
  "gs://visam-3a30b.appspot.com/data/his/**"
```

### 1.5 No Windows (gsutil via Google Cloud SDK)

```powershell
# Após instalar Google Cloud SDK e autenticar:
gcloud auth login

gsutil cp data/index_regulados.json gs://visam-3a30b.appspot.com/data/index_regulados.json
gsutil -m cp -r data\his\ gs://visam-3a30b.appspot.com/data/his/
```

---

## Etapa 2 — Criar `js/storage-utils.js`

Novo arquivo compartilhado por todos os JS que acessam Storage:

```javascript
// js/storage-utils.js
// Substitui fetch direto para arquivos JSON sensíveis no Firebase Storage.
// Requer firebase-storage-compat.js carregado antes deste script.

async function getStorageUrl(storagePath) {
  const storage = firebase.storage();
  const fileRef = storage.ref(storagePath);
  return await fileRef.getDownloadURL();
}

async function fetchStorageTimestamp(storagePath) {
  try {
    const storage = firebase.storage();
    const fileRef = storage.ref(storagePath);
    const metadata = await fileRef.getMetadata();
    return metadata.updated; // ISO 8601 — compatível com formatCsvDate() existente
  } catch {
    return null;
  }
}
```

---

## Etapa 3 — Adicionar SDK nos HTMLs

Em `cvs.html`, `index.html`, `simxcvs.html`, `total.html`, `analise.html`,
adicionar **após** os outros SDKs Firebase existentes e **antes** dos scripts JS do projeto:

```html
<script src="https://www.gstatic.com/firebasejs/10.12.0/firebase-storage-compat.js"></script>
<script src="/js/storage-utils.js"></script>
```

---

## Etapa 4 — Modificar `js/regulados1.js`

### 4.1 Remover `fetchGitCommitTime()` (linhas 68–79)

```javascript
// REMOVER esta função inteira — substituída por fetchStorageTimestamp()
async function fetchGitCommitTime(filePath) { ... }
```

### 4.2 Fetch de `index_regulados.json` (linha ~595)

```javascript
// ANTES
const url = './data/index_regulados.json?v=${Date.now()}';
const indexData = await fetchJson(url);

// DEPOIS
const url = await getStorageUrl('data/index_regulados.json');
const indexData = await fetchJson(url);
```

### 4.3 Lazy load de `his/` (linha ~542)

```javascript
// ANTES
const path = `./data/his/${b}/${ndoc}.json`;
const h = await fetchJson(path);

// DEPOIS
const storagePath = `data/his/${b}/${ndoc}.json`;
const path = await getStorageUrl(storagePath);
const h = await fetchJson(path);
```

### 4.4 Timestamp (linha ~116 e ~199)

```javascript
// ANTES
const commitTime = await fetchGitCommitTime('data/taxa.csv');
taxaTimestamp = commitTime ? formatCsvDate(commitTime) : '';

// DEPOIS — fetchStorageTimestamp para o arquivo mais representativo
const storageTime = await fetchStorageTimestamp('data/index_regulados.json');
taxaTimestamp = storageTime ? formatCsvDate(storageTime) : '';
```

> `formatCsvDate()` não precisa de alteração — ambos retornam ISO 8601.

---

## Etapa 5 — Modificar `js/busca-global.js`

Localizar a linha com `fetch('data/index_regulados.json?d=${hoje}')` (linha ~142):

```javascript
// ANTES
const indexData = await fetch(`data/index_regulados.json?d=${hoje}`).then(r => r.json());

// DEPOIS
const indexUrl = await getStorageUrl('data/index_regulados.json');
const indexData = await fetch(indexUrl).then(r => r.json());
```

---

## Etapa 6 — Modificar `js/simxcvs.js`

### 6.1 Remover `fetchGitCommitTime()` (linhas 57–68 — cópia idêntica da de regulados1.js)

### 6.2 Fetch de `index_regulados.json` (linha ~185)

```javascript
// ANTES
fetchJson(`./data/index_regulados.json?${ts}`)

// DEPOIS
getStorageUrl('data/index_regulados.json').then(url => fetchJson(url))
```

### 6.3 Timestamp de `cnae_aux.csv` (linha ~191)

```javascript
// ANTES
const auxLastModified = await fetchGitCommitTime('data/cnae_aux.csv');

// DEPOIS — cnae_aux.csv fica no GitHub Pages, usar Last-Modified do response header
// OU usar fetchStorageTimestamp para index_regulados.json como proxy de atualização
const auxLastModified = await fetchStorageTimestamp('data/index_regulados.json');
```

---

## Etapa 7 — Atualizar `total.html` e `analise.html`

Nos dois arquivos, o input `#indexUrl` tem valor default com path local.
Substituir pelo caminho que o código usará para buscar via Storage:

```html
<!-- ANTES -->
<input id="indexUrl" value="./data/index_regulados.json" />

<!-- DEPOIS — valor informativo; o JS buscará via getStorageUrl() internamente -->
<input id="indexUrl" value="data/index_regulados.json" />
```

> Verificar se `total.html` e `analise.html` têm JS inline que usa `#indexUrl` para
> montar o fetch. Se sim, substituir o fetch nesse JS inline pelo mesmo padrão
> `getStorageUrl()`.

---

## Etapa 8 — Atualização Contínua dos Dados (sem Git)

### Para `index_regulados.json`:
```bash
# Após regenerar o arquivo localmente:
gsutil cp data/index_regulados.json gs://visam-3a30b.appspot.com/data/index_regulados.json
```

### Para arquivos `his/` (quando gerados novos):
```bash
# Sincroniza apenas os arquivos alterados
gsutil -m rsync -r data/his/ gs://visam-3a30b.appspot.com/data/his/
```

### No Windows:
```powershell
gsutil cp data\index_regulados.json gs://visam-3a30b.appspot.com/data/index_regulados.json
gsutil -m rsync -r data\his\ gs://visam-3a30b.appspot.com/data/his/
```

---

## Checklist de Verificação

- [ ] `data/login.csv` removido do repositório e do histórico Git
- [ ] Firebase Storage ativo no projeto `visam-3a30b`
- [ ] CORS configurado para `garrado.github.io`
- [ ] Regras de segurança: leitura exige autenticação
- [ ] `index_regulados.json` e `data/his/` carregados no Storage
- [ ] `storage-utils.js` criado e funcionando
- [ ] SDK `firebase-storage-compat.js` adicionado nos 5 HTMLs
- [ ] `cvs.html`: busca de estabelecimentos carrega normalmente
- [ ] Painel de detalhes: histórico de inspeções abre (lazy load his/)
- [ ] `index.html`: busca global encontra estabelecimentos
- [ ] `simxcvs.html`: comparação SIM×CVS carrega com timestamp
- [ ] `indicadores.html`: painel de indicadores carrega (usa `complexidade_regulados.json`
      que permanece no GitHub Pages — sem alteração)
- [ ] Acesso sem login: Storage retorna 403 (dados protegidos)
- [ ] URL direta do GitHub Pages para `index_regulados.json`: retorna 404 ou arquivo
      removido do repositório

---

## O que NÃO muda

- Todos os CSVs (`regulados.csv`, `inspecoes.csv`, `alvara.csv`, etc.) — permanecem
  no GitHub Pages, servidos normalmente
- `data/complexidade_regulados.json` — sem PII, permanece no GitHub Pages
- `data/os_snapshot.json` — usado só por GitHub Actions, permanece no repo
- `js/guard.js` — autenticação não muda
- Firebase Auth, Firestore, FCM — sem alteração
- GitHub Actions `notify-os.yml` — sem alteração (continua usando os CSVs via repo)

---

## Observações para o Modelo de IA que Implementar

1. **Firebase já configurado** no projeto (`visam-3a30b`) com Auth, Firestore e FCM.
   Apenas o Storage é novo.

2. **SDK compat** — o projeto usa a versão compat do Firebase SDK (não modular).
   Usar `firebase-storage-compat.js` e `firebase.storage()` (não `getStorage()`).

3. **`formatCsvDate()` não muda** — já trata ISO 8601, formato do Storage metadata.

4. **`fetchGitCommitTime()` existe em dois arquivos** (`regulados1.js` e `simxcvs.js`)
   como cópias idênticas. Remover das duas.

5. **Upload dos `his/` é pesado** (106k arquivos, 438 MB). Usar `gsutil -m` para
   paralelizar. Pode levar 10–30 minutos dependendo da conexão.

6. **`total.html` e `analise.html`** — verificar se o JS inline desses arquivos
   faz `fetch` direto usando o valor do `#indexUrl` input. Se sim, adaptar para
   `getStorageUrl()`. Se o input é só documentação, apenas atualizar o valor default.
