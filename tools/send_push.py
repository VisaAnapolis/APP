#!/usr/bin/env python3
# ============================================================
# send_push.py — Disparador Manual de Notificações Push
# Projeto: VISA Anápolis
# ============================================================
#
# USO:
#   python3 send_push.py
#
# PRÉ-REQUISITOS:
#   pip install firebase-admin
#
# CREDENCIAIS:
#   Coloque o arquivo JSON da conta de serviço do Firebase
#   na mesma pasta deste script com o nome:
#   visam-3a30b-firebase-adminsdk.json
#
# COMPORTAMENTO:
#   - Busca todos os usuários com tokens FCM no Firestore
#   - Envia apenas o campo "data" (sem "notification")
#     para que o firebase-messaging-sw.js exiba a notificação
#     corretamente no Android
#   - Inclui o campo "notification" para que o iOS exiba
#     a notificação mesmo com o app em background/fechado
#   - Envia apenas 1 token por usuário (o mais recente)
#     para evitar notificações duplicadas
#   - Ao final, exibe relatório de sucesso/falha
# ============================================================

import firebase_admin
from firebase_admin import credentials, messaging, firestore
import os

# ── Configuração ──────────────────────────────────────────
CRED_FILE = os.path.join(os.path.dirname(__file__), 'visam-3a30b-firebase-adminsdk.json')

# Mensagem a ser enviada (edite aqui antes de disparar)
TITULO  = "VISA Anápolis"
MENSAGEM = "Sincronização de sistema concluída com sucesso."
URL     = "https://garrado.github.io/VISA/index.html"
# ─────────────────────────────────────────────────────────

def main():
    # Inicializa o Firebase Admin SDK
    if not firebase_admin._apps:
        cred = credentials.Certificate(CRED_FILE)
        firebase_admin.initialize_app(cred)

    db = firestore.client()

    print("=" * 55)
    print("  VISA Anápolis — Disparador de Notificações Push")
    print("=" * 55)
    print(f"\n  Título  : {TITULO}")
    print(f"  Mensagem: {MENSAGEM}")
    print(f"  URL     : {URL}")
    print("\n  Buscando usuários com tokens no Firestore...")

    docs = db.collection('usuarios').stream()

    # Para cada usuário, pega apenas o ÚLTIMO token (evita duplicatas)
    tokens_por_usuario = {}
    for doc in docs:
        data = doc.to_dict()
        tokens = data.get('fcmTokens', [])
        nome = data.get('nome', doc.id)
        if isinstance(tokens, list) and tokens:
            # Usa o último token da lista (mais recente)
            tokens_por_usuario[doc.id] = {
                'token': tokens[-1],
                'nome': nome,
                'total_tokens': len(tokens)
            }

    total_usuarios = len(tokens_por_usuario)
    print(f"  Usuários com tokens: {total_usuarios}")

    if total_usuarios == 0:
        print("\n  Nenhum token encontrado. Encerrando.")
        return

    # Exibe lista de usuários que receberão
    print(f"\n  Destinatários ({total_usuarios}):")
    for uid, info in tokens_por_usuario.items():
        aviso = f" ⚠️  {info['total_tokens']} tokens acumulados" if info['total_tokens'] > 1 else ""
        print(f"    • {info['nome']}{aviso}")

    print(f"\n  Disparando para {total_usuarios} tokens únicos...")

    tokens = [info['token'] for info in tokens_por_usuario.values()]
    success_count = 0
    failure_count = 0

    # Envia em lotes de 500 (limite do FCM)
    for i in range(0, len(tokens), 500):
        batch = tokens[i:i+500]
        msg = messaging.MulticastMessage(
            # "notification" garante entrega no iOS (background/fechado)
            notification=messaging.Notification(
                title=TITULO,
                body=MENSAGEM,
            ),
            # "data" é lido pelo firebase-messaging-sw.js no Android
            data={
                "title":  TITULO,
                "body":   MENSAGEM,
                "url":    URL,
                "osNum":  "manual"
            },
            # Configuração Android: prioridade alta para entrega imediata
            android=messaging.AndroidConfig(
                priority='high',
                notification=messaging.AndroidNotification(
                    icon='visa-192',
                    color='#004aad',
                    channel_id='visa-os'
                )
            ),
            # Configuração APNS (iOS): badge e som padrão
            apns=messaging.APNSConfig(
                payload=messaging.APNSPayload(
                    aps=messaging.Aps(
                        badge=1,
                        sound='default'
                    )
                )
            ),
            tokens=batch,
        )

        response = messaging.send_each_for_multicast(msg)
        success_count += response.success_count
        failure_count += response.failure_count

    print(f"\n  Resultado:")
    print(f"    ✅ Sucesso : {success_count}")
    print(f"    ❌ Falha   : {failure_count}")
    if failure_count > 0:
        print(f"    ℹ️  Falhas indicam tokens expirados — limpe o Firestore.")
    print("\n" + "=" * 55)

if __name__ == "__main__":
    main()
