# Relatório Técnico: Interpretação de `fcmTokens` para o Painel Administrativo

Este relatório detalha a estrutura do campo `fcmTokens` na coleção `usuarios` do Firestore e oferece orientações sobre como interpretar essa informação para exibir o status de autorização de notificações push no painel administrativo.

---

## 1. Estrutura do Campo `fcmTokens` no Firestore

No Firestore, cada documento na coleção `usuarios` representa um usuário. O campo `fcmTokens` é um **array** que armazena os tokens de registro do Firebase Cloud Messaging (FCM) associados a esse usuário. 

Cada token representa um dispositivo ou navegador específico onde o usuário autorizou o recebimento de notificações. Um usuário pode ter múltiplos tokens se ele autorizou as notificações em seu celular, tablet e computador, por exemplo.

**Exemplo de um documento de usuário no Firestore:**

```json
{
  "nome": "CLÁUDIO NASCIMENTO SILVA",
  "email": "mens.agitat.molem.cns@gmail.com",
  "ativo": true,
  "grupo": "Fiscal",
  "fcmTokens": [
    "fcm_token_do_celular_do_claudio",
    "fcm_token_do_desktop_do_claudio",
    "fcm_token_do_tablet_do_claudio"
  ]
}
```

---

## 2. Interpretação para o Painel Administrativo

Para exibir o status de autorização de notificações no painel administrativo, a lógica é bastante direta:

| Condição do `fcmTokens` | Status de Notificação | Descrição |
|---|---|---|
| **`fcmTokens` existe e não é vazio** (array com 1 ou mais tokens) | ✅ **Autorizado** | O usuário autorizou as notificações em pelo menos um dispositivo e está apto a recebê-las. |
| **`fcmTokens` não existe ou é vazio** (array vazio) | ❌ **Não Autorizado** | O usuário ainda não autorizou as notificações em nenhum dispositivo, ou revogou a permissão em todos eles. |

---

## 3. Como Implementar no Painel Administrativo (Exemplo JavaScript)

Assumindo que você está usando JavaScript para interagir com o Firestore no seu painel administrativo, você pode adaptar o seguinte trecho de código:

```javascript
import { getFirestore, collection, getDocs } from "https://www.gstatic.com/firebasejs/9.6.1/firebase-firestore.js";

// ... (inicialização do Firebase App)
const db = getFirestore(app);

async function carregarStatusNotificacoesUsuarios() {
  const usuariosRef = collection(db, "usuarios");
  const snapshot = await getDocs(usuariosRef);

  const dadosUsuarios = [];
  snapshot.forEach(doc => {
    const data = doc.data();
    const email = doc.id; // O ID do documento é o email do usuário
    const nome = data.nome || 'N/A';
    const ativo = data.ativo !== false; // Considera ativo se não for explicitamente false
    
    // Verifica se o array fcmTokens existe e tem pelo menos um token válido
    const temTokens = Array.isArray(data.fcmTokens) && data.fcmTokens.length > 0;
    
    dadosUsuarios.push({
      email: email,
      nome: nome,
      ativo: ativo,
      notificacoesAutorizadas: temTokens ? 'Sim' : 'Não',
      quantidadeTokens: temTokens ? data.fcmTokens.length : 0
    });
  });

  // Exemplo de como exibir (adaptar para sua UI)
  console.table(dadosUsuarios);
  // Ou renderizar em uma tabela HTML:
  // const tabelaUsuarios = document.getElementById('tabela-usuarios');
  // dadosUsuarios.forEach(usuario => {
  //   const linha = `<tr>
  //     <td>${usuario.nome}</td>
  //     <td>${usuario.email}</td>
  //     <td>${usuario.ativo ? 'Ativo' : 'Inativo'}</td>
  //     <td>${usuario.notificacoesAutorizadas} (${usuario.quantidadeTokens} dispositivos)</td>
  //   </tr>`;
  //   tabelaUsuarios.innerHTML += linha;
  // });
}

// Chame esta função quando o painel administrativo for carregado
// carregarStatusNotificacoesUsuarios();
```

---

## 4. Considerações Adicionais

- **Tokens Inválidos:** O script `notify-os.js` já inclui uma lógica para remover tokens inválidos (que não estão mais registrados no FCM, por exemplo, porque o usuário desinstalou o app ou revogou a permissão). Isso garante que o array `fcmTokens` seja o mais preciso possível.
- **Privacidade:** Exibir a quantidade de dispositivos pode ser útil, mas a lista exata dos tokens não deve ser exposta na interface por questões de segurança e privacidade.

Com essa lógica, você pode facilmente adicionar uma coluna ou um ícone no seu painel de administração de usuários para indicar se cada fiscal autorizou ou não as notificações push.
