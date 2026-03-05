# CLAUDE.md — AI Assistant Guide for VISA

This file documents the codebase structure, conventions, and development workflows for the **VISA** (Vigilância Sanitária) repository. It is intended to help AI assistants (e.g., Claude Code) understand and work effectively within this project.

---

## Project Overview

VISA is a **static Progressive Web Application (PWA)** built for internal use by municipal health surveillance staff (*Vigilância Sanitária*). It provides dashboards, inspection management, permit tracking, scheduling, and push notifications.

- **Architecture**: Vanilla HTML + CSS + JavaScript (no frontend frameworks)
- **Backend**: Serverless via Firebase (Auth, Firestore, Cloud Messaging)
- **Hosting**: GitHub Pages
- **Automation**: GitHub Actions (CSV monitoring + push notifications)
- **Language**: Portuguese (Brazilian) — all content, variable names, and comments

---

## Repository Structure

```
VISA/
├── .github/
│   ├── scripts/            # Node.js scripts for CI/CD automation
│   │   ├── notify-os.js    # Main notification script (detects new OS in CSVs)
│   │   ├── test-notify.js  # Manual test notification sender
│   │   └── package.json    # Dependencies for scripts (firebase-admin)
│   └── workflows/
│       ├── notify-os.yml   # Auto-runs on push to CSV files + 3x daily cron
│       └── test-notify.yml # Manually triggered test workflow
├── css/
│   ├── design-tokens.css   # CSS custom properties, theming (light/dark/iOS/Android)
│   ├── base.css            # Global baseline reset and typography
│   ├── components.css      # Reusable UI components (cards, buttons, badges)
│   ├── layouts.css         # Grid/flex layout patterns, responsive breakpoints
│   ├── regulados.css       # Styles for regulated entities page
│   └── sidebar.css         # Sidebar navigation styles
├── js/
│   ├── guard.js            # Auth guard: email whitelist + session management
│   ├── guard1.js           # Alternate auth guard (used by some pages)
│   ├── platform-detector.js # Device/OS/feature detection → applies CSS classes
│   ├── push-notifications.js # FCM token registration and foreground notifications
│   ├── sidebar.js          # Sidebar component loader and interaction
│   ├── cvs1.js             # CVS/regulated entities data processing
│   └── regulados1.js       # Regulated entities display logic
├── data/
│   ├── *.csv               # OS records: denuncia, protocolo, tramitacao, rdpf, alvlib
│   ├── index_regulados.json # Index for regulated entities
│   ├── his/                # Historical JSON data by fiscal code
│   └── os_snapshot.json    # Snapshot state for notification deduplication
├── icons/                  # PWA icons (192x192, 512x512)
├── docs/                   # PDF/image documentation
├── check-list-*/           # PDF-based inspection checklists with assets
├── mts/                    # MTS regulatory documents
├── normas/                 # Regulatory norms/standards
├── _backup/                # Version backup files (not deployed)
├── *.html                  # 40+ application pages (see Pages section below)
├── service-worker.js       # PWA service worker (Network First cache strategy)
├── firebase-messaging-sw.js # FCM background message handler
├── manifest.webmanifest    # PWA manifest (icons, theme, start URL)
├── package.json            # Root package (only firebase-admin dependency)
├── README.md               # Legal/institutional framework description
├── FIREBASE-SEGURANCA.md   # Firebase security guide
└── RELATORIO_FCM_ADMIN.md  # FCM token structure documentation
```

---

## Key Application Pages

| File | Purpose |
|------|---------|
| `index.html` | Main dashboard |
| `os.html` | Orders of Service (OS) — core feature |
| `admin.html` | Admin panel |
| `plantao.html` | Shift management |
| `inspecoes.html` | Inspections |
| `ferias.html` | Vacation scheduling |
| `alvara.html` | Permits/licenses |
| `cvs.html` | Regulated entities (CVS) |
| `changelog.html` | Public version history |

---

## Technology Stack

| Layer | Technology |
|-------|-----------|
| Markup | HTML5 |
| Styling | CSS3 with custom properties (no preprocessors) |
| Logic | Vanilla ES6+ JavaScript |
| Auth | Firebase Authentication (Google Sign-In) |
| Database | Firebase Firestore (NoSQL) |
| Notifications | Firebase Cloud Messaging (FCM) |
| Hosting | GitHub Pages |
| CI/CD | GitHub Actions |
| Package Mgr | npm (minimal usage) |
| Firebase SDK | v10.12.0 via CDN (esm.sh) |

---

## Naming Conventions

| Context | Convention | Example |
|---------|-----------|---------|
| Files | `kebab-case` | `platform-detector.js` |
| CSS classes | `kebab-case` | `.app-header`, `.btn-back-ios` |
| HTML IDs | `camelCase` or `snake_case` | `#visa_session_start`, `#loading` |
| JS variables | `camelCase` | `userEmail`, `fcmTokens` |
| JS constants | `SCREAMING_SNAKE_CASE` | `SESSION_MAX_MIN`, `AUTHORIZED_EMAILS` |
| Git commits | Portuguese imperative | `feat: adiciona sidebar`, `fix: corrige guard` |

---

## Authentication & Authorization

- Authentication is handled by **Firebase Auth with Google Sign-In**.
- Access is restricted by a **hardcoded email whitelist** in `js/guard.js` (currently ~55 authorized emails stored in a `Set` for O(1) lookups).
- Session limits are enforced client-side:
  - Max session: **8 hours**
  - Idle timeout: **20 minutes** (user activity tracked via mouse/keyboard events)
- Session data is stored in `sessionStorage`.
- Pages that require auth must include `guard.js` or `guard1.js`.

**Important**: Adding a new authorized user requires editing the `AUTHORIZED_EMAILS` Set in `js/guard.js`.

---

## Firestore Data Model

```
usuarios/{email}          ← Document ID is the user's email (lowercase)
  nome: string            ← Display name
  email: string           ← Same as document ID
  ativo: boolean          ← Whether user is active
  grupo: string           ← Permission group ("Fiscal", "Admin", etc.)
  fcmTokens: string[]     ← Array of FCM device tokens
  notificationOptIn: bool ← Optional; whether user opted into notifications
```

No ORM is used — all Firestore access is via the Firebase SDK directly.

---

## CSS Architecture

The styling system uses a **design-token approach** with CSS custom properties:

1. **`design-tokens.css`** — defines all tokens (colors, spacing, fonts, radii, shadows)
   - Supports `prefers-color-scheme` for automatic dark mode
   - Platform-specific overrides: `.ios-device`, `.android-device`
   - Safe area insets for notched devices
2. **`base.css`** — resets and global typography
3. **`components.css`** — reusable UI patterns (cards, buttons, badges, modals)
4. **`layouts.css`** — responsive grid/flex layouts, media queries

All pages should import these in order: `design-tokens.css` → `base.css` → `components.css` → `layouts.css` → page-specific CSS.

**Dark mode** is applied automatically via `prefers-color-scheme: dark` in `design-tokens.css`.

---

## Platform Detection

`js/platform-detector.js` runs on every page and applies CSS classes and `data-*` attributes to `<html>`:

- Classes: `.ios-device`, `.android-device`, `.desktop-device`, `.mobile-device`, `.pwa-mode`
- Features detected: backdrop filter, touch, vibration, dark mode, connection type, safe areas
- Used to apply platform-specific UI adaptations (iOS-style vs Material Design 3)

---

## Push Notification System

Notifications are sent via **Firebase Cloud Messaging (FCM)**:

- **Client side** (`js/push-notifications.js`): Requests permission, registers FCM token, stores token array in Firestore `usuarios` collection, handles foreground notifications (toast).
- **Service Worker** (`firebase-messaging-sw.js`): Handles background notifications when app is not in focus.
- **Server side** (`.github/scripts/notify-os.js`): Admin SDK script run by GitHub Actions to send multicast notifications.

**Notification trigger stages** (based on OS deadline):
| Stage | Days Remaining | Cron Schedule |
|-------|---------------|---------------|
| `VENCE_HOJE` | 0 days | Daily 08:30 |
| `AMANHA` | 1 day | Daily 08:30 |
| `RECUPERACAO` | 2–4 days | Daily 08:30 |
| `PRAZO_5D` | 5 days | Daily 08:30 |

Deduplication is handled by `data/os_snapshot.json`, which is committed to the repo after each notification run.

---

## GitHub Actions Workflows

### `notify-os.yml` (automatic)
- **Triggers**: push to CSV data files OR scheduled 3x daily (weekdays 08:30, 12:30, 16:30 Brasília time)
- **Steps**: Checkout → Install deps → Create service account from secret → Run `notify-os.js` → Cleanup → Commit updated snapshot
- **Required Secret**: `FIREBASE_SERVICE_ACCOUNT` (JSON of Firebase Admin SDK service account)

### `test-notify.yml` (manual)
- **Trigger**: Manual `workflow_dispatch`
- **Purpose**: Send a test notification to all registered users; validate Firebase connectivity

---

## Service Worker & PWA

- **Cache name**: `visa-v2.2.8` (bump this when deploying breaking UI changes)
- **Strategy**: Network First — always tries the network, falls back to cache if offline
- **PWA manifest** (`manifest.webmanifest`):
  - `start_url`: `/VISA/`
  - `theme_color`: `#004aad`
  - `display`: `standalone`

---

## Data Files (CSV)

CSV files in `data/` are the source of truth for OS (Orders of Service) records. They are version-controlled in Git. The CI/CD pipeline monitors specific files:

- `requerimento.csv`
- `oficio.csv`
- `denuncia.csv`
- `protocolo.csv`
- `cvs_sync.txt` (sync marker)

When these files are pushed, `notify-os.yml` runs automatically.

---

## Sidebar — Gerenciamento de Links de Navegação

> **IMPORTANTE**: Sempre que uma página for **adicionada**, **renomeada** ou **removida** do projeto, os links do sidebar em **todas** as páginas devem ser atualizados. Existe um template HTML e scripts Python para isso.

### Arquivos do sistema de sidebar

| Arquivo | Função |
|---------|--------|
| `includes/sidebar-nav.html` | Template de referência do bloco `<aside>` do sidebar. **Edite este arquivo primeiro** ao alterar links. |
| `scripts/apply_sidebar.py` | Aplica o layout sidebar (com topbar e page-header) em páginas **sem autenticação**. |
| `scripts/apply_sidebar_auth.py` | Aplica o layout sidebar em páginas **com autenticação** (guard.js/guard1.js). |
| `scripts/build_sidebar_pages.py` | Gera/atualiza o bloco do sidebar em páginas existentes. |

### Como atualizar o sidebar ao adicionar/renomear/remover uma página

1. **Edite `includes/sidebar-nav.html`** — adicione, renomeie ou remova o link `<a class="visa-nav-item">` correspondente.
2. **Edite o `SIDEBAR_BLOCK` / lista `items`** nos scripts `apply_sidebar.py` e `build_sidebar_pages.py` com a mesma alteração.
3. **Adicione/remova a entrada** no dicionário `PAGE_ACTIVE` (em `build_sidebar_pages.py`) e `PAGES` (nos scripts apply).
4. **Execute o script** para propagar as mudanças em todas as páginas:
   ```bash
   python3 scripts/apply_sidebar.py        # páginas sem auth
   python3 scripts/apply_sidebar_auth.py   # páginas com auth
   ```
5. Verifique se o `<aside>` foi atualizado corretamente em todas as páginas HTML.

---

## Development Workflow

Since this is a static site with no build step:

1. **Edit files directly** — HTML, CSS, JS can be edited without a build process.
2. **Test locally** — Open HTML files in a browser or use a local server (`npx serve .` or `python3 -m http.server`).
3. **Firebase testing** — Firebase Auth and Firestore require an internet connection and a logged-in authorized Google account.
4. **Deploy** — Simply push to `master`. GitHub Pages auto-deploys.
5. **Notifications** — Trigger manually via `workflow_dispatch` on `test-notify.yml`, or push a CSV change to trigger `notify-os.yml`.

**No build system, no transpiler, no bundler** — just plain files.

---

## Environment & Secrets

| Secret | Location | Purpose |
|--------|----------|---------|
| `FIREBASE_SERVICE_ACCOUNT` | GitHub Actions secret | Admin SDK auth for notification scripts |

**`.gitignore`** excludes:
- `*service-account*.json` — Firebase admin credentials
- `*.key.json`

**Firebase client config** (in `firebase-messaging-sw.js`) is intentionally public — it is protected by Firestore Security Rules, not by key secrecy. Do not raise security alerts for this.

---

## Conventions for AI Assistants

1. **Language**: All code comments, commit messages, variable names, and UI text are in **Brazilian Portuguese**. Keep this convention.
2. **No frameworks**: Do not introduce React, Vue, Angular, or any frontend framework. Use vanilla JS only.
3. **No build tools**: Do not add webpack, vite, babel, or similar. The project intentionally avoids build complexity.
4. **CSS first**: Prefer CSS solutions over JavaScript for UI behavior where possible. Use existing design tokens.
5. **Auth awareness**: Any new page that contains private data must include `guard.js` or `guard1.js`.
6. **Mobile first**: All new UI must be responsive. Test for iOS and Android via `platform-detector.js` classes.
7. **Commit style**: Use Portuguese imperative (`feat: adiciona`, `fix: corrige`, `style: padroniza`, `refactor: reorganiza`, `docs: atualiza`).
8. **Security**: Never commit service account JSON files. Never hardcode new credentials. Never skip `.gitignore` rules.
9. **Minimal dependencies**: Do not add npm packages without strong justification. The project uses almost no dependencies by design.
10. **Data files**: CSV files in `data/` are sensitive operational data — do not delete or restructure them without explicit instruction.
11. **Versioning**: Update the cache name in `service-worker.js` (`visa-vX.X.X`) when making significant UI changes that affect cached assets.

---

## Firebase SDK Import Pattern

All Firebase SDK imports use CDN via `esm.sh`:

```javascript
import { initializeApp } from 'https://www.gstatic.com/firebasejs/10.12.0/firebase-app.js';
import { getAuth, signInWithPopup, GoogleAuthProvider, onAuthStateChanged, signOut }
  from 'https://www.gstatic.com/firebasejs/10.12.0/firebase-auth.js';
import { getFirestore, doc, getDoc, setDoc, updateDoc, collection, query, onSnapshot }
  from 'https://www.gstatic.com/firebasejs/10.12.0/firebase-firestore.js';
```

Always use **version 10.12.0** for consistency. Do not mix versions.

---

## Quick Reference

```bash
# Local development server
npx serve .
# or
python3 -m http.server 8080

# Install notification script dependencies
cd .github/scripts && npm install

# Run notification script locally (requires service account)
FIREBASE_SERVICE_ACCOUNT_PATH=./service-account.json node .github/scripts/notify-os.js

# Git: deploy to production (GitHub Pages)
git push origin master
```
