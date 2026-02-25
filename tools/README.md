# VISA Anápolis — Ferramentas Administrativas

Esta pasta contém scripts Python para operações administrativas do projeto VISA que não fazem parte do app web.

---

## `send_push.py` — Disparador Manual de Notificações Push

Envia uma notificação push para **todos os usuários com token FCM** registrado no Firestore.

### Pré-requisitos

```bash
pip install firebase-admin
```

### Configuração

1. Coloque o arquivo JSON da conta de serviço do Firebase na mesma pasta com o nome:
   ```
   visam-3a30b-firebase-adminsdk.json
   ```
   > **Atenção:** Este arquivo contém credenciais sensíveis. **Nunca commite no GitHub.**
   > Ele já está listado no `.gitignore`.

2. Edite as variáveis no topo do script:
   ```python
   TITULO   = "VISA Anápolis"
   MENSAGEM = "Sua mensagem aqui."
   URL      = "https://garrado.github.io/VISA/index.html"
   ```

### Execução

```bash
cd tools/
python3 send_push.py
```

### Comportamento

- Busca todos os usuários com tokens FCM no Firestore.
- Envia apenas **1 token por usuário** (o mais recente), evitando notificações duplicadas.
- Exibe aviso para usuários com múltiplos tokens acumulados.
- Compatível com **Android** (via `firebase-messaging-sw.js`) e **iOS** (via campo `notification`).
- Exibe relatório de sucesso/falha ao final.

### Exemplo de saída

```
=======================================================
  VISA Anápolis — Disparador de Notificações Push
=======================================================

  Título  : VISA Anápolis
  Mensagem: Sincronização de sistema concluída.
  URL     : https://garrado.github.io/VISA/index.html

  Buscando usuários com tokens no Firestore...
  Usuários com tokens: 18

  Destinatários (18):
    • Cláudio Nascimento Silva ⚠️  3 tokens acumulados
    • Maria Edwiges Pinheiro de Souza Chaves
    • ...

  Disparando para 18 tokens únicos...

  Resultado:
    ✅ Sucesso : 16
    ❌ Falha   : 2
    ℹ️  Falhas indicam tokens expirados — limpe o Firestore.
=======================================================
```
