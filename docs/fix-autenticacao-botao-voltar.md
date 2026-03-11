# Relatório de Correção — Perda de Autenticação no Botão Voltar

> **Projeto:** VISA Anápolis — GitHub Pages  
> **Data da análise:** 10/03/2026  
> **Status:** ⏳ Aguardando implementação  
> **Arquivos afetados:** `js/sidebar.js`, `js/guard.js`, `js/guard1.js`, `index.html`

---

## 1. Descrição do Problema

Ao pressionar o **botão Voltar** do navegador a partir de qualquer página interna para
o `index.html`, o sistema solicita login novamente — mesmo que a sessão Firebase ainda
esteja válida. A navegação pelos **links da sidebar funciona normalmente**; apenas o
histórico do navegador (Voltar / Alt+← / gesto de swipe) causa o problema.

---

## 2. Causa Raiz

### 2.1 `location.href` empilha o `index.html` no histórico

Em todos os arquivos de guarda e no logout da sidebar, o redirecionamento é feito com:

```javascript
location.href = 'index.html';   // ← cria entrada no histórico
```

Isso faz com que o `index.html` fique empilhado no histórico do navegador. Ao pressionar
Voltar a partir de qualquer página, o browser retorna ao `index.html` — que exibe o
formulário de login sem verificar se o usuário já está autenticado.

### 2.2 `index.html` não redireciona usuário já logado

O `index.html` não possui lógica de "se já estiver logado, vá direto para o dashboard".
Resultado: mesmo com sessão Firebase ativa no `localStorage`, o `index.html` sempre
exibe a tela de login.

### 2.3 bfcache (Back-Forward Cache) do navegador

Quando o navegador restaura uma página do cache ao pressionar Voltar, o JavaScript
**não re-executa**. O `onAuthStateChanged` não dispara novamente, e o estado exibido
fica "congelado" no momento em que a página foi abandonada. Isso afeta principalmente
páginas sem `guard` (ex: `legislacao.html`, `changelog.html`, `pop.html`), onde apenas
o `sidebar.js` gerencia a exibição do usuário.

---

## 3. Arquivos Afetados e Ocorrências

### `js/sidebar.js`
| Localização | Código atual | Problema |
|---|---|---|
| Função `sidebarLogout()` | `window.location.href = 'index.html'` | Empilha no histórico |
| Ausência de listener | — | Não trata bfcache |

### `js/guard.js`
| Localização | Código atual | Problema |
|---|---|---|
| `onAuthStateChanged` — usuário nulo | `location.href = INDEX_URL` | Empilha no histórico |
| `onAuthStateChanged` — email não autorizado | `location.href = INDEX_URL` | Empilha no histórico |
| `startExpiryTimer` — sessão expirada | `location.href = INDEX_URL` | Empilha no histórico |

### `js/guard1.js`
| Localização | Código atual | Problema |
|---|---|---|
| `onAuthStateChanged` — usuário nulo | `location.href = INDEX_URL` | Empilha no histórico |
| `onAuthStateChanged` — perfil inativo | `location.href = INDEX_URL` | Empilha no histórico |
| `onAuthStateChanged` — grupo Administrativo | `location.href = INDEX_URL` | Empilha no histórico |
| `startExpiryTimer` — sessão expirada | `location.href = INDEX_URL` | Empilha no histórico |

### `index.html`
| Localização | Situação | Problema |
|---|---|---|
| Inicialização do Firebase Auth | Sem verificação de sessão ativa | Sempre exibe login, mesmo logado |

---

## 4. Correções Necessárias

### 4.1 `js/sidebar.js` — 2 alterações

**Correção 1 — Logout:**
```javascript
// ANTES:
window.location.href = 'index.html';

// DEPOIS:
window.location.replace('index.html');
```

**Correção 2 — Tratamento do bfcache (adicionar no final do arquivo):**
```javascript
// Ao voltar pelo histórico (bfcache), força re-verificação do Auth
window.addEventListener('pageshow', function(e) {
  if (e.persisted) {
    window.__sidebarAuthInitialized = false;
    initSidebarAuth();
  }
});
```

> ⚠️ Para que `initSidebarAuth()` seja acessível pelo `pageshow`, a função IIFE atual
> `(function initSidebarAuth() { ... })()` deve ser convertida para função nomeada
> declarada antes da chamada:
> ```javascript
> function initSidebarAuth() { ... }
> initSidebarAuth();
> ```

---

### 4.2 `js/guard.js` — 3 alterações

Substituir todas as ocorrências de `location.href = INDEX_URL` por
`location.replace(INDEX_URL)`:

```javascript
// Ocorrência 1 — onAuthStateChanged, usuário nulo (~linha 68):
// ANTES:  location.href = INDEX_URL;
// DEPOIS: location.replace(INDEX_URL);

// Ocorrência 2 — onAuthStateChanged, email não autorizado (~linha 78):
// ANTES:  location.href = INDEX_URL;
// DEPOIS: location.replace(INDEX_URL);

// Ocorrência 3 — startExpiryTimer, sessão expirada (~linha 55):
// ANTES:  location.href = INDEX_URL;
// DEPOIS: location.replace(INDEX_URL);
```

---

### 4.3 `js/guard1.js` — 4 alterações

Substituir todas as ocorrências de `location.href = INDEX_URL` por
`location.replace(INDEX_URL)`:

```javascript
// Ocorrência 1 — onAuthStateChanged, usuário nulo
// Ocorrência 2 — onAuthStateChanged, perfil inativo
// Ocorrência 3 — onAuthStateChanged, grupo Administrativo
// Ocorrência 4 — startExpiryTimer, sessão expirada
// Em todas: ANTES: location.href = INDEX_URL;
//           DEPOIS: location.replace(INDEX_URL);
```

---

### 4.4 `index.html` — 1 adição

Após a inicialização do Firebase Auth no `index.html`, adicionar verificação de sessão
ativa para redirecionar usuário já logado diretamente ao dashboard:

```javascript
// Adicionar após getAuth(app) e setPersistence:
onAuthStateChanged(auth, function(user) {
  if (user) {
    // Usuário já autenticado — pula o login e vai direto para o dashboard
    window.location.replace('os.html'); // ajustar para a página principal desejada
  }
});
```

---

## 5. Por que `replace` e não `href`?

| Método | Comportamento | Efeito no botão Voltar |
|---|---|---|
| `location.href = 'index.html'` | Cria nova entrada no histórico | Voltar retorna ao `index.html` |
| `location.replace('index.html')` | **Substitui** a entrada atual no histórico | Voltar retorna à página **anterior** ao login |

O `replace` é o comportamento correto para redirecionamentos de autenticação: o usuário
não deve conseguir "voltar" para uma tela de login que ele acabou de sair.

---

## 6. Resumo das Alterações

| Arquivo | Alterações | Páginas beneficiadas |
|---|---|---|
| `js/sidebar.js` | 1 `replace` + listener `pageshow` | **Todas as 24+ páginas** |
| `js/guard.js` | 3 `replace` | Páginas com guard (OS, Alvarás, etc.) |
| `js/guard1.js` | 4 `replace` | Páginas com guard1 |
| `index.html` | Redirect se já logado | Ponto de entrada do app |

> **Impacto total: 0 alterações nas 24 páginas HTML.**  
> Todas as correções são feitas nos arquivos JS centrais — propagação automática.

---

## 7. Teste Após Implementação

1. Fazer login normalmente
2. Navegar para qualquer página interna (ex: `legislacao.html`, `os.html`)
3. Pressionar **Voltar** no navegador
4. ✅ Esperado: permanecer logado, sidebar mostrando usuário correto
5. Pressionar **Voltar** novamente (até `index.html`)
6. ✅ Esperado: `index.html` redireciona automaticamente para `os.html`
7. Fazer logout → pressionar **Voltar**
8. ✅ Esperado: permanecer no `index.html` (não volta para página protegida)

---

*Relatório gerado com base na análise do código-fonte do repositório `garrado/VISA` em 10/03/2026.*
