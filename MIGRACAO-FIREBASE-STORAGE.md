# Plano de Migração: GitHub Pages → Firebase Storage (Dados Sensíveis VISA)

## Contexto e Motivação

O sistema VISA (Vigilância Sanitária) hospeda atualmente ~70 MB de arquivos CSV/JSON no
GitHub Pages, acessíveis publicamente via URL direta sem autenticação. Esses arquivos
contêm CPF, CNPJ, endereços, detalhes de não conformidades em inspeções sanitárias e
histórico de processos administrativos — dados sensíveis protegidos pela LGPD.

O Firebase Auth já protege as páginas HTML, mas **não protege os arquivos de dados brutos**.
Qualquer pessoa com a URL pode baixar `regulados.csv` (26k registros com CPF/CNPJ) ou
`inspecoes.csv` (68k registros de vistoria) sem nenhuma credencial.

**Objetivo:** Mover os arquivos de dados para Firebase Storage com regras de autenticação,
manter a funcionalidade existente (incluindo timestamps), e substituir o GitHub Actions de
notificação por Cloud Functions nativas do Firebase.

---

## Arquivos Envolvidos

### Arquivos de dados a migrar (de `data/` para Firebase Storage)

| Arquivo | Tamanho | Sensibilidade |
|---------|---------|---------------|
| `data/regulados.csv` | 8.3 MB | **Alta** — CPF, CNPJ, endereço, telefone, e-mail |
| `data/inspecoes.csv` | 19.8 MB | **Alta** — detalhes de não conformidades por estabelecimento |
| `data/denuncia.csv` | 1.3 MB | **Alta** — denúncias vinculadas ao contribuinte |
| `data/cnae_aux.csv` | 15.6 MB | Média — mapeamento SIM×CVS |
| `data/alvara.csv` | 8.5 MB | Média — alvarás e situação regulatória |
| `data/alvlib.csv` | 3.9 MB | Média |
| `data/taxa.csv` | 6.0 MB | Média |
| `data/requerimento.csv` | 3.9 MB | Média |
| `data/oficio.csv` | 2.0 MB | Média |
| `data/protocolo.csv` | 537 KB | Média |
| `data/tramitacao.csv` | 576 KB | Média |
| `data/rdpf.csv` | 1.0 MB | Média |
| `data/cnae.csv` | 25 KB | Baixa |
| `data/bairros.csv` | 139 KB | Baixa |
| `data/index_regulados.json` | 2.1 MB | Alta — índice completo de estabelecimentos |
| `data/complexidade_regulados.json` | variável | Média |
| `data/os_snapshot.json` | 1.6 MB | Média |
| `data/his/**/*.json` | milhares de arquivos | **Alta** — histórico e notas de inspeção por CODIGO |

### Arquivo a DELETAR do repositório (não usado em código algum)

- `data/login.csv` — contém senhas em texto puro de 53 usuários. Não é referenciado
  em nenhum arquivo JS/HTML. Deve ser removido do repositório E do histórico Git.

### Arquivos de código a modificar

| Arquivo | O que muda |
|---------|-----------|
| `js/regulados1.js` | `fetch(url)` → Firebase Storage SDK; `fetchGitCommitTime()` → `fetchStorageTimestamp()` |
| `js/busca-global.js` | Todos os `fetch()` de CSV/JSON → Firebase Storage SDK |
| `js/simxcvs.js` | `fetch()` → Firebase Storage SDK; `fetchGitCommitTime()` → `fetchStorageTimestamp()` |
| `.github/scripts/notify-os.js` | Migrar lógica para Cloud Function |
| `.github/workflows/notify-os.yml` | Desativar ou deletar após migrar para Cloud Function |
| Todos os `.html` | Adicionar Firebase Storage SDK no `<head>` |

---

## Etapa 0 — Pré-requisito: Deletar login.csv

### 0.1 Remover o arquivo e limpar histórico Git

```bash
# Na raiz do repositório local:

# 1. Instalar BFG Repo Cleaner (se não tiver):
#    Baixar de: https://rtyley.github.io/bfg-repo-cleaner/
#    Requer Java instalado

# 2. Fazer clone limpo do repositório (BFG trabalha em clone separado)
git clone --mirror https://github.com/garrado/VISA.git visa-mirror.git
cd visa-mirror.git

# 3. Remover o arquivo do histórico completo
java -jar bfg.jar --delete-files login.csv

# 4. Limpar e forçar push
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push --force

# 5. No clone normal, deletar o arquivo e commitar
cd /home/user/VISA
git rm data/login.csv
git commit -m "remove: login.csv não utilizado (dado sensível)"
git push
```

> ⚠️ **ATENÇÃO:** `git push --force` reescreve o histórico público. Se houver outros
> colaboradores com clones locais, eles precisarão fazer `git clone` novamente.

---

## Etapa 1 — Configurar Firebase Storage

### 1.1 Ativar Firebase Storage no Console

1. Acesse [console.firebase.google.com](https://console.firebase.google.com)
2. Projeto: `visam-3a30b`
3. Menu lateral → **Storage** → **Começar**
4. Escolher região: `southamerica-east1` (São Paulo — menor latência)
5. Confirmar criação do bucket

### 1.2 Configurar CORS (obrigatório para acesso via browser)

Criar arquivo `cors.json` na raiz do projeto:

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

Aplicar via terminal:

```bash
gsutil cors set cors.json gs://visam-3a30b.appspot.com
```

### 1.3 Configurar Cache-Control nos arquivos (evitar lentidão)

Após o upload inicial dos arquivos:

```bash
# CSVs grandes — cache de 10 minutos (600 segundos)
gsutil -m setmeta -h "Cache-Control:public, max-age=600" \
  "gs://visam-3a30b.appspot.com/data/*.csv"

# JSONs de índice — cache de 10 minutos
gsutil -m setmeta -h "Cache-Control:public, max-age=600" \
  "gs://visam-3a30b.appspot.com/data/*.json"

# Arquivos de histórico individuais — cache maior (1 hora)
gsutil -m setmeta -h "Cache-Control:public, max-age=3600" \
  "gs://visam-3a30b.appspot.com/data/his/**"
```

### 1.4 Configurar Regras de Segurança do Storage

No Console Firebase → Storage → Regras, substituir por:

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Dados sensíveis — apenas usuários autenticados
    match /data/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if false; // escrita apenas via Admin SDK / gsutil
    }
  }
}
```

### 1.5 Upload inicial dos arquivos

```bash
# Upload de todos os CSVs e JSONs de data/
gsutil -m cp -r data/ gs://visam-3a30b.appspot.com/data/

# Verificar
gsutil ls gs://visam-3a30b.appspot.com/data/
```

---

## Etapa 2 — Modificar o Código JavaScript

### 2.1 Adicionar Firebase Storage SDK nos HTMLs

Em cada HTML que carrega dados (`cvs.html`, `index.html`, `simxcvs.html`, `admin.html`,
`comply.html`, etc.), adicionar dentro do `<head>` ou antes dos scripts existentes:

```html
<!-- Firebase Storage SDK (adicionar junto com os outros SDKs Firebase existentes) -->
<script src="https://www.gstatic.com/firebasejs/10.12.0/firebase-storage-compat.js"></script>
```

### 2.2 Criar função utilitária compartilhada: `js/storage-utils.js`

Criar novo arquivo com as duas funções que substituem `fetch()` e `fetchGitCommitTime()`:

```javascript
// js/storage-utils.js
// Utilitários para acesso ao Firebase Storage (substitui fetch direto de arquivos de dados)

/**
 * Obtém a URL de download autenticada de um arquivo no Firebase Storage.
 * @param {string} storagePath - caminho no Storage, ex: "data/regulados.csv"
 * @returns {Promise<string>} URL temporária autenticada
 */
async function getStorageUrl(storagePath) {
  const storage = firebase.storage();
  const fileRef = storage.ref(storagePath);
  return await fileRef.getDownloadURL();
}

/**
 * Obtém o timestamp de última atualização de um arquivo no Firebase Storage.
 * Substitui fetchGitCommitTime() — retorna mesmo formato ISO 8601.
 * @param {string} storagePath - caminho no Storage, ex: "data/regulados.csv"
 * @returns {Promise<string|null>} ISO 8601 timestamp ou null em caso de erro
 */
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

Incluir este script nos HTMLs **após** a inicialização do Firebase:

```html
<script src="/js/storage-utils.js"></script>
```

### 2.3 Modificar `js/regulados1.js`

#### Remover função obsoleta
```javascript
// REMOVER esta função inteira:
async function fetchGitCommitTime(filePath) {
  try {
    const url = `https://api.github.com/repos/garrado/VISA/commits?path=${encodeURIComponent(filePath)}&per_page=1`;
    const r = await fetch(url);
    if (!r.ok) return null;
    const data = await r.json();
    if (Array.isArray(data) && data[0]?.commit?.author?.date) {
      return data[0].commit.author.date;
    }
    return null;
  } catch { return null; }
}
```

#### Substituir chamadas de fetch de dados

Localizar onde `taxa.csv`, `regulados.csv`, `alvara.csv` e outros são carregados.
O padrão atual é:
```javascript
// ANTES (fetch direto — funciona sem auth, arquivo público)
await parseCSV("/data/taxa.csv", [...])
```

Substituir por:
```javascript
// DEPOIS (URL autenticada do Firebase Storage)
const taxaUrl = await getStorageUrl("data/taxa.csv");
await parseCSV(taxaUrl, [...])
```

#### Substituir `fetchGitCommitTime` por `fetchStorageTimestamp`

```javascript
// ANTES
const commitTime = await fetchGitCommitTime("data/taxa.csv");
taxaTimestamp = commitTime ? formatCsvDate(commitTime) : "";

// DEPOIS (formatCsvDate não muda — ambos retornam ISO 8601)
const storageTime = await fetchStorageTimestamp("data/taxa.csv");
taxaTimestamp = storageTime ? formatCsvDate(storageTime) : "";
```

### 2.4 Modificar `js/simxcvs.js`

Mesma lógica do `regulados1.js`:

1. Remover `fetchGitCommitTime()` (é cópia idêntica da mesma função)
2. Substituir `fetch("/data/cnae_aux.csv")` por URL do Storage:

```javascript
// ANTES
const auxLastModified = await fetchGitCommitTime("data/cnae_aux.csv");

// DEPOIS
const auxUrl = await getStorageUrl("data/cnae_aux.csv");
const auxLastModified = await fetchStorageTimestamp("data/cnae_aux.csv");
// ... passar auxUrl para parseCSV em vez de path fixo
```

### 2.5 Modificar `js/busca-global.js`

Localizar todas as chamadas de `parseCSV` e `fetchJson` que carregam arquivos de `data/`.
Para cada uma:

```javascript
// PADRÃO ANTES:
const rows = await parseCSV("/data/protocolo.csv", campos);

// PADRÃO DEPOIS:
const url = await getStorageUrl("data/protocolo.csv");
const rows = await parseCSV(url, campos);
```

Arquivos afetados em `busca-global.js`:
- `data/protocolo.csv`
- `data/tramitacao.csv`
- `data/denuncia.csv`
- `data/requerimento.csv`
- `data/oficio.csv`
- `data/alvara.csv`
- `data/regulados.csv`
- `data/index_regulados.json`

### 2.6 Lazy loading de `data/his/**/*.json`

O padrão atual constrói o path assim (`regulados1.js`):
```javascript
const prefix = String(ndoc % 100).padStart(2, "0");
const url = `/data/his/${prefix}/${ndoc}.json`;
const data = await fetchJson(url);
```

Substituir por:
```javascript
const prefix = String(ndoc % 100).padStart(2, "0");
const storagePath = `data/his/${prefix}/${ndoc}.json`;
const url = await getStorageUrl(storagePath);
const data = await fetchJson(url);
```

> **Nota:** `getDownloadURL()` faz uma chamada de rede adicional por arquivo. Para os
> arquivos `his/` (carregados on-demand, um por vez), o impacto é mínimo (~50ms extra).
> Para os CSVs principais (carregados em paralelo na inicialização), o impacto também é
> pequeno pois `getDownloadURL()` é rápido.

---

## Etapa 3 — Substituir GitHub Actions por Cloud Function

### 3.1 Criar Cloud Function que substitui `notify-os.js`

No diretório `functions/` (criar se não existir):

```bash
cd /home/user/VISA
firebase init functions
# Escolher: JavaScript, instalar dependências
```

Criar `functions/index.js`:

```javascript
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

admin.initializeApp();

/**
 * Dispara automaticamente quando qualquer arquivo em data/ é atualizado no Storage.
 * Substitui o workflow .github/workflows/notify-os.yml
 */
exports.onDataUpdate = functions
  .region("southamerica-east1")
  .storage.object()
  .onFinalize(async (object) => {
    const filePath = object.name; // ex: "data/requerimento.csv"

    // Monitorar apenas os arquivos relevantes para notificações
    const monitored = [
      "data/requerimento.csv",
      "data/oficio.csv",
      "data/protocolo.csv",
      "data/tramitacao.csv",
    ];

    if (!monitored.includes(filePath)) return null;

    // Porta a lógica existente de notify-os.js aqui
    // (detectar mudanças via os_snapshot.json, enviar FCM, enviar email)
    // O código de notify-os.js pode ser copiado quase sem alteração
    // pois já usa firebase-admin
  });
```

### 3.2 Fazer deploy da Cloud Function

```bash
firebase deploy --only functions
```

### 3.3 Desativar GitHub Actions após confirmar funcionamento

```bash
# Renomear o workflow para desativá-lo (ou deletar)
mv .github/workflows/notify-os.yml .github/workflows/notify-os.yml.disabled
git add .
git commit -m "disable: notify-os workflow migrado para Cloud Function"
git push
```

---

## Etapa 4 — Atualização de Dados sem Git

### Método principal: `gsutil rsync`

Após qualquer atualização local dos CSVs, sincronizar com o Storage:

```bash
# Sincroniza apenas arquivos alterados (compara checksums)
gsutil -m rsync -r data/ gs://visam-3a30b.appspot.com/data/

# A Cloud Function onFinalize dispara automaticamente para cada arquivo atualizado
# e envia as notificações FCM/email correspondentes
```

### Script auxiliar recomendado: `scripts/sync-data.sh`

```bash
#!/bin/bash
# sync-data.sh — sincroniza dados locais para Firebase Storage
# Uso: ./scripts/sync-data.sh

set -e

echo "Sincronizando dados para Firebase Storage..."
gsutil -m rsync -r data/ gs://visam-3a30b.appspot.com/data/

echo "Aplicando Cache-Control..."
gsutil -m setmeta -h "Cache-Control:public, max-age=600" \
  "gs://visam-3a30b.appspot.com/data/*.csv" \
  "gs://visam-3a30b.appspot.com/data/*.json" 2>/dev/null || true

echo "Sincronização concluída."
```

---

## Etapa 5 — Verificação e Testes

### Checklist funcional

- [ ] `data/login.csv` não existe mais no repositório nem no histórico Git
- [ ] Arquivos de dados não são mais acessíveis via URL direta do GitHub Pages
  - Testar: `curl https://garrado.github.io/VISA/data/regulados.csv` → deve retornar 404
- [ ] Firebase Storage retorna 403 para usuário não autenticado
  - Testar abrindo URL do Storage sem sessão Firebase ativa
- [ ] `cvs.html` carrega e exibe resultados normalmente (regulados.csv via Storage)
- [ ] `simxcvs.html` carrega e exibe o timestamp de `cnae_aux.csv` corretamente
- [ ] `index.html` (dashboard) carrega todos os CSVs via Storage
- [ ] Timestamp de sincronização exibe data/hora correta (via `fetchStorageTimestamp`)
- [ ] Lazy loading de `data/his/XX/NDOC.json` funciona no painel de detalhes
- [ ] Cloud Function dispara ao fazer upload de `requerimento.csv`
- [ ] Notificações FCM chegam nos dispositivos registrados após upload

### Teste de regressão de performance

Comparar tempo de carregamento antes e depois:
- Medir com DevTools (Network tab) o tempo total de download dos CSVs
- Verificar que `Cache-Control` está presente nos response headers dos arquivos do Storage

---

## Resumo das Dependências entre Etapas

```
Etapa 0 (deletar login.csv)       → independente, fazer primeiro
    ↓
Etapa 1 (configurar Storage)      → necessário antes de modificar código
    ↓
Etapa 2 (modificar JS)            → depois que Storage estiver com arquivos e regras OK
    ↓
Etapa 3 (Cloud Function)          → paralela à Etapa 2, independente
    ↓
Etapa 4 (sync script)             → depois de tudo funcionando
    ↓
Etapa 5 (verificação)             → ao final de cada etapa
```

---

## Observações para o Modelo de IA que Implementar

1. **O Firebase já está configurado no projeto** (`visam-3a30b`) com Auth, Firestore e FCM.
   O Storage é o único serviço a adicionar.

2. **`formatCsvDate()` não precisa de nenhuma alteração** — tanto a GitHub API quanto
   `getMetadata()` do Storage retornam ISO 8601. A função já trata esse formato.

3. **Os SDKs Firebase já são carregados via CDN** nos HTMLs (versão compat 10.12.0).
   O Storage SDK compat (`firebase-storage-compat.js`) segue o mesmo padrão.

4. **Não alterar a lógica de autenticação** em `guard.js` — ela já funciona e não tem
   relação com o Storage.

5. **Os arquivos `data/his/` são milhares** — o upload inicial com `gsutil -m cp -r`
   faz isso em paralelo. Não tentar fazer manualmente.

6. **`notify-os.js` existente** (em `.github/scripts/`) pode ser copiado quase inteiro
   para dentro da Cloud Function — já usa `firebase-admin` e a lógica de diff/snapshot
   é idêntica.
