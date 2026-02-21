# Backup pré-implementação de Notificações Push

**Data:** 2026-02-21
**Motivo:** Deploy do sistema de notificações push Firebase (alertas de prazo de OS)

## Arquivos salvos (versão original de produção)

| Arquivo | Descrição |
|---|---|
| `os.html` | Página de OSs antes da integração push |
| `index.html` | Página principal antes da integração push |
| `js/guard.js` | Guard de autenticação antes da alteração |
| `manifest.webmanifest` | Manifest antes da adição do gcm_sender_id |

## Arquivos novos adicionados (não existiam antes)

- `firebase-messaging-sw.js` — Service Worker FCM
- `js/push-notifications.js` — Módulo de registro de token
- `.github/workflows/notify-os.yml` — Workflow GitHub Actions
- `.github/scripts/notify-os.js` — Script de detecção e envio
- `.github/scripts/package.json` — Dependências Node.js
- `.github/scripts/package-lock.json` — Lock de dependências
- `data/os_snapshot.json` — Snapshot baseline das OSs
