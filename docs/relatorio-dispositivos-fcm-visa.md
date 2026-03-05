# Relatório Técnico — Gestão de Dispositivos e Tokens FCM
## VISA Anápolis — garrado.github.io/VISA
**Data:** 05/03/2026 | **Autor:** Análise técnica da sessão

---

## 1. CONTEXTO E PROBLEMA ORIGINAL

O sistema VISA registra no Firestore, para cada usuário, um mapa `dispositivos` indexado por uma **chave string** que identifica unicamente cada dispositivo. Paralelamente, existe um array `fcmTokens` com os tokens de push notification (Firebase Cloud Messaging).

**O problema:** usuários estavam acumulando até **17 tokens FCM** e múltiplos registros de dispositivo duplicados para o mesmo aparelho físico.

---

## 2. CAUSA RAIZ IDENTIFICADA

### 2.1 Chave de dispositivo incluía resolução de tela

No `index.html`, a chave era gerada assim:

```javascript
const chaveDispositivo = [
  (dadosDispositivo.sistemaOperacional || 'desconhecido').toLowerCase().replace(/[^a-z0-9]/g, ''),
  (dadosDispositivo.navegador || 'desconhecido').toLowerCase().replace(/[^a-z0-9]/g, ''),
  (dadosDispositivo.resolucao || '0x0').replace('x', '_')   // ← PROBLEMA
].join('_');
```

A **resolução muda** quando o usuário:
- Redimensiona a janela do navegador
- Rotaciona o celular
- Acessa de monitor diferente
- Usa zoom do sistema operacional

Cada resolução diferente gerava uma nova chave → novo registro de dispositivo → novo token FCM acumulado.

### 2.2 Tokens não vinculados ao dispositivo

O array `fcmTokens` é **global por usuário**, sem vínculo com qual dispositivo gerou cada token. Isso tornou impossível saber quais tokens remover ao limpar dispositivos duplicados.

---

## 3. ESTRUTURA ATUAL DO FIRESTORE

```
usuarios/{email}/
  ├── nome, grupo, ativo, ...
  ├── ultimoAcesso: Timestamp
  ├── appVersionLast: "2.4.7"
  ├── pageLast: "index.html"
  ├── fcmTokens: [ "token1", "token2", ... ]   ← array global, sem vínculo
  └── dispositivos/
        ├── windows_chrome_1920_1080/           ← chave ANTIGA (com resolução)
        │     sistemaOperacional: "Windows"
        │     navegador: "Chrome"
        │     versaoNavegador: "145.0.0.0"
        │     fabricante: ""
        │     modelo: ""
        │     resolucao: "1920x1080"
        │     ultimoAcesso: "2026-03-05T..."
        │     appVersionLast: "2.4.7"
        │     fcmToken: ""                      ← campo existe mas vazio
        └── android_chrome_396_870/             ← chave ANTIGA (com resolução)
              ...
```

---

## 4. CORREÇÕES JÁ REALIZADAS

### 4.1 Nova lógica de chave — `index.html`

**Substituir** o bloco de geração da `chaveDispositivo` por:

```javascript
// Gera chave única para este dispositivo
try {
  const dadosDispositivo = coletarDadosDispositivo();

  const _norm = s => (s || 'desconhecido').toLowerCase().replace(/[^a-z0-9]/g, '');
  const _so   = _norm(dadosDispositivo.sistemaOperacional);
  const _nav  = _norm(dadosDispositivo.navegador);
  const _fab  = _norm(dadosDispositivo.fabricante);
  const _mod  = _norm(dadosDispositivo.modelo);
  const _res  = (dadosDispositivo.resolucao || '').replace('x', '_').replace(/[^a-z0-9_]/g, '');

  // Se tem fabricante ou modelo real → usa eles (sem resolução) → chave estável
  // Senão → usa resolução como fallback (compatível com registros antigos no banco)
  const chaveDispositivo = (_fab !== 'desconhecido' || _mod !== 'desconhecido')
    ? `${_so}_${_nav}_${_fab}_${_mod}`
    : `${_so}_${_nav}_${_res}`;
```

**Resultado por tipo de dispositivo:**

| Dispositivo | Chave gerada |
|---|---|
| Windows Chrome sem fabricante | `windows_chrome_1920_1080` (igual à antiga ✅) |
| iOS Safari sem fabricante | `ios_safari_390_844` (igual à antiga ✅) |
| Android Samsung com fabricante | `android_chrome_samsung_galaxya32` (nova, estável ✅) |
| Android sem fabricante | `android_chrome_desconhecido_k` (nova, estável ✅) |

### 4.2 Cleanup de migração executado

Foi criado e executado o arquivo `cleanup-dispositivos.html` que:
- Reagrupou dispositivos pela nova chave
- Migrou 38 chaves em 25 usuários
- Reduziu tokens de 43 → 14

### 4.3 Status da implementação

- ✅ Lógica da chave corrigida no `index.html`
- ✅ Cleanup/migração executado no Firestore (25 usuários, 38 chaves migradas)
- ⏳ Token vinculado ao dispositivo — **NÃO implementado ainda** (próxima etapa)

---

## 5. PROBLEMA REMANESCENTE — ANDROIDS COM MESMA CHAVE

Dispositivos Android **sem fabricante/modelo** coletados geram a chave `android_chrome_desconhecido_k`.
Se um usuário tiver **dois Androids diferentes**, ambos cairão na mesma chave e um sobrescreverá o outro.

**Causa:** a função `coletarDadosDispositivo()` não captura fabricante/modelo na maioria dos
Androids — o User-Agent moderno não expõe esses dados por padrão.

**Solução futura:** usar a API `navigator.userAgentData.getHighEntropyValues()` para obter
dados reais do dispositivo Android. O agente deve consultar e atualizar a função
`coletarDadosDispositivo()` no `index.html`.

---

## 6. PRÓXIMA ETAPA — TOKEN ACOPLADO AO DISPOSITIVO

### 6.1 Estrutura alvo no Firestore

```
usuarios/{email}/
  ├── fcmTokens: ["token1", "token2"]   ← mantém por compatibilidade com envio de push
  └── dispositivos/
        ├── windows_chrome_1920_1080/
        │     ...dados do dispositivo...
        │     fcmToken: "token1"        ← token deste dispositivo específico
        └── android_chrome_samsung_k/
              ...dados do dispositivo...
              fcmToken: "token2"        ← token deste dispositivo específico
```

### 6.2 Mudança necessária no `index.html`

O agente precisa:

1. **Localizar** onde o token é obtido via `getToken(messaging, { vapidKey: ... })`
2. **Garantir** que o token seja obtido **antes** do `updateDoc` do dispositivo
3. **Incluir** o `fcmToken` no `registroDispositivo`:

```javascript
const registroDispositivo = {
  // ...campos existentes (sistemaOperacional, navegador, etc.)...
  fcmToken: fcmToken || ''   // ← ADICIONAR
};
```

4. **Atualizar** o array global `fcmTokens` usando `arrayUnion` para não duplicar:

```javascript
import { arrayUnion } from 'firebase/firestore';

await updateDoc(doc(db, 'usuarios', userDocId), {
  [`dispositivos.${chaveDispositivo}`]: registroDispositivo,
  fcmTokens: arrayUnion(fcmToken)   // adiciona sem duplicar
});
```

> ⚠️ **Atenção ao agente:** o `getToken` pode estar em outro ponto do fluxo
> (callback de notificação, service worker ou função separada). Mapear o fluxo
> completo antes de implementar.

### 6.3 Mudança necessária no `admin.html`

Na função `abrirModalDispositivos()`, dentro do bloco que monta o HTML de cada
card de dispositivo (`disp-modal-item`), adicionar exibição do status de push:

```javascript
const temToken = d.fcmToken && d.fcmToken.length > 10;
html += `<div class="dm-row">
  <span class="k">Push</span>
  ${temToken
    ? '<span style="color:#4ade80;font-weight:700">✅ Ativo</span>'
    : '<span style="color:#f87171;font-weight:700">❌ Sem token</span>'}
</div>`;
```

---

## 7. NECESSIDADE DE NOVO CLEANUP?

### Cenário atual pós-migração:
- Chaves no banco: formato antigo (com resolução) para iOS/Windows, novo (sem resolução) para alguns Androids
- Tokens: array global `fcmTokens` ainda desvinculado dos dispositivos
- Push notifications: **continuam funcionando** — o array `fcmTokens` ainda existe

### Precisa apagar tudo e pedir autorização de novo?

**Não obrigatoriamente.** O fluxo recomendado é:

1. ✅ Implementar o `fcmToken` dentro do `registroDispositivo` no `index.html`
2. ✅ Usar `arrayUnion` no `fcmTokens` para não duplicar
3. ⏳ Aguardar todos os usuários acessarem o app pelo menos uma vez → cada acesso
   vai gravar o `fcmToken` dentro do dispositivo automaticamente
4. ⏳ Após ~2 semanas (quando todos tiverem acessado), rodar um **cleanup final** que:
   - Reconstrói `fcmTokens` a partir dos `fcmToken` de cada dispositivo
   - Remove tokens órfãos do array global

**Só precisaria pedir autorização de novo se** os tokens forem apagados do banco.
Enquanto o array `fcmTokens` existir, o push continua funcionando.

---

## 8. ARQUIVOS QUE O AGENTE DEVE CONSULTAR

| Arquivo | O que analisar |
|---|---|
| `index.html` | Função `coletarDadosDispositivo()` · bloco `chaveDispositivo` · bloco `registroDispositivo` · `updateDoc` do dispositivo · função de `getToken` FCM |
| `admin.html` | Função `abrirModalDispositivos()` · bloco que monta HTML de cada card de dispositivo (`disp-modal-item`) |
| `firebase-messaging-sw.js` | Confirmar VAPID key e configuração do service worker de push |
| `js/version.js` | Confirmar constante `APP_VERSION` atual |

---

## 9. RESUMO DAS TAREFAS PARA O AGENTE

| # | Tarefa | Arquivo | Prioridade |
|---|---|---|---|
| 1 | Confirmar que a nova lógica de `chaveDispositivo` está aplicada | `index.html` | ✅ Feito |
| 2 | Adicionar campo `fcmToken` no `registroDispositivo` | `index.html` | 🔴 Alta |
| 3 | Trocar por `arrayUnion` no `updateDoc` do `fcmTokens` | `index.html` | 🔴 Alta |
| 4 | Exibir ✅/❌ de push por dispositivo no modal | `admin.html` | 🟡 Média |
| 5 | Melhorar `coletarDadosDispositivo()` com `userAgentData` para Androids | `index.html` | 🟡 Média |
| 6 | Criar cleanup final que reconstrói `fcmTokens` a partir dos dispositivos | `cleanup-v2.html` | 🟢 Baixa (rodar após 2 semanas) |

---

## 10. OBSERVAÇÕES FINAIS

- O repositório é: **https://github.com/garrado/VISA**
- O app está em produção em: **https://garrado.github.io/VISA**
- Firestore project: `visam-3a30b`
- Versão atual do app no momento da análise: **v2.4.7**
- O cleanup de migração já foi executado com sucesso em produção
- Não houve perda de dados — apenas renomeação de chaves e deduplicação de tokens
