# Relatório Técnico — VISA Anápolis
> **Versão do sistema:** 2.5.1 · **Data:** março/2026  > Análise técnica completa do sistema VISA Anápolis: arquitetura, módulos, segurança e dados.

---

## Sumário
1. [Visão Geral](#1-visão-geral)
2. [Arquitetura do Sistema](#2-arquitetura-do-sistema)
3. [Módulos e Páginas](#3-módulos-e-páginas)
4. [Sistema de Design e CSS](#4-sistema-de-design-e-css)
5. [Segurança e Autenticação](#5-segurança-e-autenticação)
6. [Camada de Dados](#6-camada-de-dados)
7. [Sistema de Notificações](#7-sistema-de-notificações)
8. [Progressive Web App (PWA)](#8-progressive-web-app-pwa)
9. [Automação (GitHub Actions)](#9-automação-github-actions)
10. [Busca Global Unificada](#10-busca-global-unificada)
11. [Pontos de Atenção e Melhorias Futuras](#11-pontos-de-atenção-e-melhorias-futuras)
12. [Conclusão](#12-conclusão)

---

## 1. Visão Geral

### 1.1 Identificação

| Atributo | Valor |
|----------|-------|
| **Nome** | VISA Anápolis — Sistema de Vigilância Sanitária Municipal |
| **Versão** | 2.5.1 (mar/2026) |
| **Tipo** | Progressive Web App (PWA) — estático, sem servidor de aplicação |
| **Hospedagem** | GitHub Pages (CDN global, HTTPS) |
| **URL de produção** | `https://garrado.github.io/VISA/` |
| **Público-alvo** | Servidores da Vigilância Sanitária de Anápolis-GO |
| **Backend** | Firebase (Auth, Firestore, Cloud Messaging) |
| **Automatização** | GitHub Actions (notificações, sincronização de dados) |

### 1.2 Propósito

O VISA Anápolis é um painel interno de consulta e gestão operacional desenvolvido para uso exclusivo da equipe técnica de Vigilância Sanitária do Município de Anápolis-GO. O sistema centraliza o acesso a **Ordens de Serviço (OS)**, **alvarás sanitários**, **registros de estabelecimentos regulados**, **escalas de plantão e férias**, **inspeções** e **indicadores de desempenho**, eliminando a necessidade de consultar múltiplos sistemas ou planilhas desconexas.

O sistema tem caráter informativo e de apoio à decisão; não substitui os sistemas oficiais de registro do município e não produz atos administrativos formais.

### 1.3 Estatísticas gerais

| Métrica | Valor |
|---------|-------|
| Páginas HTML | 23 |
| Módulos JavaScript | 10 (+ 2 service workers) |
| Arquivos CSS | 6 |
| Arquivos CSV de dados | 13 |
| Workflows de automação (GitHub Actions) | 5 |
| Volume total de dados (CSV) | ~47 MB |
| Usuários autorizados | ~46 e-mails de fiscais |
| Versão Firebase SDK (CDN) | 10.12.0 |
| Coleção Firestore | 1 (`usuarios`) |

---

## 2. Arquitetura do Sistema

### 2.1 Diagrama de camadas

```
┌─────────────────────────────────────────────────────────────┐
│              VISA Anápolis — Arquitetura em Camadas          │
├───────────────────────────┬─────────────────────────────────┤
│  FRONTEND (Static PWA)    │  BACKEND (Firebase/Serverless)  │
│  ─────────────────────    │  ───────────────────────────    │
│  23 páginas HTML          │  Firebase Auth (Google SSO)     │
│  6 arquivos CSS           │  Cloud Firestore (perfis, FCM)  │
│  10 módulos JS            │  Cloud Messaging (push)         │
│  2 service workers        │  Projeto ID: visam-3a30b        │
│  PWA manifest             │                                 │
├───────────────────────────┴─────────────────────────────────┤
│  DADOS (Git-tracked, servidos via GitHub Pages)             │
│  ─────────────────────────────────────────────────────      │
│  13 arquivos CSV (~47 MB) — OS, alvarás, inspeções, etc.   │
│  index_regulados.json — índice de busca dos regulados       │
│  os_snapshot.json — estado das notificações enviadas        │
│  data/his/*.json — histórico de inspeções por código        │
├─────────────────────────────────────────────────────────────┤
│  AUTOMAÇÃO (GitHub Actions — 5 workflows)                   │
│  ─────────────────────────────────────────────────────      │
│  notify-os.yml — push FCM 3×/dia (seg–sex)                  │
│  notify-email-os.yml — e-mail HTML 3×/dia                   │
│  test-notify.yml / test-email-notify.yml — testes manuais  │
│  reset-optin-sem-token.yml — limpeza de tokens expirados    │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 Pilha tecnológica

| Camada | Tecnologia | Versão/Observação |
|--------|-----------|-------------------|
| Markup | HTML5 | Semântico, `lang="pt-BR"` |
| Estilização | CSS3 com custom properties | Sem pré-processador |
| Lógica de UI | Vanilla ES6+ JavaScript | Módulos ES6, sem framework |
| Autenticação | Firebase Authentication | Google Sign-In (OAuth 2.0) |
| Banco de dados | Cloud Firestore | NoSQL, tempo real |
| Push | Firebase Cloud Messaging (FCM) | Web Push / VAPID |
| Hospedagem | GitHub Pages | CDN global, HTTPS, sem custo |
| CI/CD | GitHub Actions | Node.js scripts, YAML workflows |
| Manipulação de CSV | PapaParse 5.4.1 | CDN; parsing no browser |
| Tabelas interativas | DataTables 1.13.7 | CDN; filtros, paginação |
| Export Excel | SheetJS (XLSX) 0.18.5 | CDN; export direto no browser |
| Firebase Admin SDK | firebase-admin ^13.6.1 | Somente no GitHub Actions |
| E-mail (CI) | nodemailer ^6.x | Gmail SMTP com App Password |

### 2.3 Estrutura de diretórios

```
VISA/
├── css/                   # Sistema de design (6 arquivos)
│   ├── design-tokens.css  # Tokens CSS (cores, espaçamento, tipografia)
│   ├── base.css           # Reset e estilos globais
│   ├── components.css     # Componentes reutilizáveis
│   ├── layouts.css        # Grid/flex, responsividade
│   ├── sidebar.css        # Sidebar de navegação
│   └── header-component.css  # Header topbar (mobile)
├── js/                    # Módulos JavaScript (10 arquivos)
│   ├── guard.js           # Guard de autenticação (básico)
│   ├── guard1.js          # Guard com controle por grupo
│   ├── sidebar.js         # Sidebar: toggle, permissões, usuário
│   ├── platform-detector.js  # Detecção de SO/dispositivo/recursos
│   ├── push-notifications.js # Registro FCM e notificações foreground
│   ├── busca-global.js    # Busca unificada em 7 fontes de dados
│   ├── cvs1.js            # Lógica do módulo CVS/Regulados
│   ├── regulados1.js      # Exibição de entidades reguladas
│   ├── version.js         # Versão centralizada (APP_VERSION)
│   └── header-loader.js   # Gerador dinâmico de header
├── data/                  # CSVs e JSONs (dados operacionais)
├── .github/
│   ├── scripts/           # Scripts Node.js para CI/CD
│   └── workflows/         # Definições dos GitHub Actions
├── includes/              # Fragmento HTML do sidebar (referência)
├── scripts/               # Scripts Python de manutenção
├── icons/                 # Ícones PWA (192×192, 512×512)
├── service-worker.js      # PWA service worker (Network First)
├── firebase-messaging-sw.js  # SW para push em background
├── manifest.webmanifest   # Manifesto PWA
└── *.html                 # 23 páginas da aplicação
```

---

## 3. Módulos e Páginas

### 3.1 Catálogo de páginas

| Página | Nome | Acesso | Descrição |
|--------|------|--------|-----------|
| `index.html` | Dashboard | Autenticado | Painel principal com busca global unificada, cards de navegação e indicadores por fiscal |
| `os.html` | Ordens de Serviço | Fiscal/Admin | Consulta e filtro de OS (requerimentos, denúncias, ofícios) com export XLSX |
| `alvara.html` | Alvarás | Autenticado | Busca de alvarás sanitários por estabelecimento, validade e situação |
| `cvs.html` | Regulados | Fiscal/Admin | Cadastro de entidades reguladas, histórico de inspeções e situação cadastral |
| `protocolo.html` | Protocolos | Fiscal/Admin | Consulta de protocolos administrativos por número, nome ou CNPJ |
| `rmpf.html` | RMPF | Fiscal/Admin | Relatório mensal de produção fiscal |
| `inspecoes.html` | Inspeções | Fiscal/Admin | Histórico de inspeções por fiscal, período e estabelecimento |
| `relatorio_plantao_fiscal.html` | Ocorrências | Fiscal/Admin | Registro de ocorrências de plantão fiscal |
| `indicadores.html` | Indicadores | Apenas Admin | KPIs e métricas de desempenho da equipe |
| `comply.html` | Compliance | Fiscal/Admin | Taxas de conformidade sanitária; export PDF/HTML |
| `plantao.html` | Plantão Fiscal | Público | Escala de plantão fiscal |
| `veiculos.html` | Veículos | Fiscal/Admin | Controle de veículos da fiscalização |
| `ferias.html` | Férias | Fiscal/Admin | Escala de férias da equipe |
| `areas.html` | Áreas | Fiscal/Admin | Distribuição geográfica de bairros por fiscal |
| `cnae.html` | CNAEs | Autenticado | Códigos de atividade econômica por equipe |
| `total.html` | Totalização | Autenticado | Totais e resumos agregados de todos os módulos |
| `admin.html` | Painel Admin | Apenas Admin | Gerenciamento de usuários, dispositivos e tokens FCM |
| `clean.html` | Manutenção | Apenas Admin | Deduplicação de dispositivos e tokens FCM órfãos |
| `legislacao.html` | Legislação | Público | Links para legislação sanitária vigente |
| `pop.html` | POPs da VISA | Público | Procedimentos Operacionais Padrão da VISA |
| `check.html` | Check Lists | Público | Modelos de checklists de inspeção por tipo de estabelecimento |
| `changelog.html` | Novidades | Público | Histórico de versões e alterações do sistema |
| `readme.html` | Aviso Institucional | Público | Aviso legal, LGPD e natureza jurídica do sistema |

### 3.2 Módulos JavaScript

| Arquivo | Linhas | Responsabilidade principal |
|---------|--------|---------------------------|
| `guard.js` | 142 | Guard de autenticação básico: whitelist de e-mails, sessão de 8 h, idle de 20 min |
| `guard1.js` | 137 | Guard com controle por grupo: busca perfil no Firestore, bloqueia inativos e grupo Administrativo |
| `sidebar.js` | 222 | Toggle mobile, destaque do item ativo, exibição de usuário no rodapé, permissões de links por grupo |
| `platform-detector.js` | 443 | Detecção de OS (iOS, Android, desktop), 15+ recursos do browser, aplica classes CSS ao `<html>` |
| `push-notifications.js` | 276 | Registro de token FCM no Firestore, toast de notificação foreground |
| `busca-global.js` | 616 | Motor de busca unificada em 7 fontes, lazy load com cache em memória, normalização CNPJ/texto |
| `cvs1.js` | 534 | Processamento e exibição de dados de estabelecimentos regulados (módulo CVS) |
| `regulados1.js` | 408 | Lógica de exibição de entidades reguladas — filtros, ordenação, histórico |
| `version.js` | 30 | Fonte única de verdade para `APP_VERSION` ('2.5.1'); preenche `#appVersion` em todas as páginas |
| `header-loader.js` | 152 | Gerador dinâmico de header topbar com título e botão de retorno |

---

## 4. Sistema de Design e CSS

### 4.1 Arquitetura CSS

Importação obrigatória em ordem: `design-tokens.css` → `base.css` → `components.css` → `layouts.css` → CSS específico da página.

| Arquivo | Linhas | Responsabilidade |
|---------|--------|-----------------|
| `design-tokens.css` | 327 | Todos os tokens (cores, tipografia, espaçamento, sombras, z-index, transições). Suporte a dark mode e otimizações iOS/Android |
| `base.css` | 674 | Reset global, tipografia base, links, formulários, acessibilidade (focus visible), print styles |
| `components.css` | 786 | Botões, cards, tabelas (DataTables), badges, modais, toasts, spinners de loading, paginação |
| `layouts.css` | 692 | Layout 2 colunas (sidebar 240px + conteúdo), off-canvas mobile, safe area insets para iOS |
| `sidebar.css` | 389 | Menu lateral: itens de navegação, hover, item ativo, rodapé de usuário, `.is-disabled` para links bloqueados |
| `header-component.css` | 272 | Topbar sticky mobile: botão hambúrguer, título da página, botões iOS-style |

### 4.2 Dark mode e plataformas

- **Dark mode automático:** via `@media (prefers-color-scheme: dark)` em `design-tokens.css`, sem toggle manual
- **iOS:** safe area insets para notch/Dynamic Island, fonte San Francisco, bordas mais arredondadas
- **Android:** fonte Roboto, cores Material Design 3, espaçamento compacto
- **Desktop:** sidebar fixa à esquerda (240px), conteúdo principal ocupa o restante
- **Mobile (≤768px):** sidebar off-canvas com animação slide, overlay clicável, topbar com hambúrguer

---

## 5. Segurança e Autenticação

### 5.1 Modelo de autenticação

Autenticação via **Firebase Authentication com Google Sign-In (OAuth 2.0)**. O e-mail autenticado é verificado em uma **whitelist hardcoded** no `js/guard.js` (~46 e-mails). O `guard1.js` adicionalmente consulta o Firestore em `usuarios/{email}` para verificar os campos `ativo` e `grupo`.

### 5.2 Gestão de sessão (client-side)

| Parâmetro | Valor | Implementação |
|-----------|-------|---------------|
| Duração máxima | 8 horas | `SESSION_MAX_MIN = 480` em `guard.js` |
| Timeout de inatividade | 20 minutos | Rastreado via eventos `mousemove`, `keydown`, `touchstart` |
| Armazenamento | `sessionStorage` | Chaves: `visa_session_start`, `visa_last_active`, `visa_user` |
| Renovação | A cada interação | Função `touchActivity()` atualiza `visa_last_active` |

### 5.3 Controle de acesso por grupo

| Grupo (Firestore) | Páginas permitidas |
|-------------------|-------------------|
| Fiscal | Todas exceto `admin.html` e `indicadores.html` |
| Administrador | Todas as páginas |
| Administrativo | Bloqueado por `guard1.js` |

Os links da sidebar são desabilitados visualmente (classe `.is-disabled`) imediatamente no `DOMContentLoaded`, antes da resposta do Firestore.

### 5.4 Segurança do Firebase

- **API Key pública:** projetada para ser pública; proteção real via **Firestore Security Rules** (exigem usuário autenticado)
- **Service Account:** armazenada no **GitHub Secrets** (`FIREBASE_SERVICE_ACCOUNT`), nunca comitada
- **`.gitignore`:** exclui `*service-account*.json` e `*.key.json`
- **LGPD:** dados pessoais (e-mail, nome) armazenados apenas para fins operacionais

---

## 6. Camada de Dados

### 6.1 Arquivos CSV

Todos os dados operacionais são arquivos CSV versionados no Git, servidos pelo GitHub Pages e parseados no browser via **PapaParse**.

| Arquivo | Tamanho | Conteúdo |
|---------|---------|---------|
| `inspecoes.csv` | 19 MB | Histórico completo de inspeções sanitárias |
| `alvara.csv` | 8,2 MB | Alvarás sanitários emitidos (número, emissão, validade, cancelamento) |
| `regulados.csv` | 7,9 MB | Cadastro de estabelecimentos regulados (CNPJ, razão social, CNAE, endereço) |
| `requerimento.csv` | 3,7 MB | OS do tipo Requerimento (OS, motivo, prazo, fiscal, status) |
| `alvlib.csv` | 3,7 MB | Biblioteca histórica de alvarás |
| `oficio.csv` | 2,0 MB | OS do tipo Ofício (regulado, CNPJ, motivo, prazo, cancelamento) |
| `denuncia.csv` | 1,3 MB | Denúncias sanitárias (objeto, prazo, fiscal) |
| `rdpf.csv` | 736 KB | Relatório de Documentação de Propriedade e Fornecedores |
| `tramitacao.csv` | 529 KB | Tramitação de protocolos |
| `protocolo.csv` | 531 KB | Protocolos administrativos |
| `bairros.csv` | 136 KB | Bairros do município (código, nome, zona, geometria) |
| `cnae.csv` | 26 KB | Código Nacional de Atividades Econômicas |
| `login.csv` | 5,7 KB | Usuários do sistema |

### 6.2 Arquivos JSON

| Arquivo | Propósito |
|---------|----------|
| `data/os_snapshot.json` | Estado das notificações enviadas (deduplicação). Atualizado pelo GitHub Actions após cada ciclo. |
| `data/index_regulados.json` | Índice de busca dos estabelecimentos regulados — carregado pelo `busca-global.js`. |
| `data/his/{prefix}/{codigo}.json` | Histórico de inspeções por estabelecimento. |

### 6.3 Modelo de dados Firestore

```
Coleção: usuarios
  Documento ID: {email do usuário, lowercase}
  Campos:
    nome:              string   — nome de exibição
    email:             string   — igual ao ID do documento
    ativo:             boolean  — se o acesso está habilitado
    grupo:             string   — "Fiscal" | "Administrador" | "Administrativo"
    fcmTokens:         string[] — tokens FCM de todos os dispositivos
    notificationOptIn: boolean  — consentimento de notificações push
    dispositivos:      map      — dispositivos registrados
      {chave}:
        sistemaOperacional: string
        navegador:          string
        fabricante:         string
        modelo:             string
        resolucao:          string
        ultimoAcesso:       string  — timestamp ISO
        fcmToken:           string|null  — token vinculado ao dispositivo
```

**Formato da chave do dispositivo:**  
`norm(SO)_norm(Navegador)_norm(Fabricante)_norm(Modelo)` (fallback: `_norm(Resolução)`)  
Exemplo: `windows11_chrome_1920x1080`

### 6.4 Cache e atualização

- **Cache busting via query string:** CSVs carregados com `?d=YYYY-MM-DD`, forçando nova requisição diária
- **Cache de memória:** `busca-global.js` guarda os dados em variável de módulo; `limparCacheBusca()` chamada no logout
- **Service Worker (Network First):** tenta sempre a rede; cache como fallback offline. Nome: `visa-v2.5.1`

---

## 7. Sistema de Notificações

### 7.1 Canais de notificação

| Canal | Tecnologia | Workflow | Formato |
|-------|-----------|---------|---------|
| Push Web | Firebase Cloud Messaging (FCM) | `notify-os.yml` | Notificação push nativa no dispositivo |
| E-mail | Gmail SMTP via Nodemailer | `notify-email-os.yml` | E-mail HTML com OS agrupadas por fiscal |

### 7.2 Gatilhos por prazo de OS

| Gatilho | Dias restantes | Horário (BRT) |
|---------|---------------|---------------|
| `VENCE_HOJE` | 0 dias | 08:30 |
| `AMANHA` | 1 dia | 08:30 |
| `RECUPERACAO` | 2–4 dias | 08:30 (cobre fins de semana) |
| `PRAZO_5D` | 5 dias | 08:30 |

Os workflows rodam adicionalmente às 12:30 e 16:30 BRT para novos cadastros ao longo do dia.

### 7.3 Deduplicação

O `data/os_snapshot.json` rastreia quais OS já receberam notificação (campos `notif_enviada` para FCM e `email_notif_enviada` para e-mail). Após cada ciclo, o arquivo é commitado pelo GitHub Actions, garantindo estado persistente sem duplicatas.

### 7.4 Registro de tokens FCM

O `push-notifications.js` atualiza atomicamente o array `fcmTokens[]` e o campo `dispositivos.<chave>.fcmToken` na mesma operação Firestore, permitindo saber exatamente qual dispositivo gerou qual token e facilitando remoção por dispositivo.

---

## 8. Progressive Web App (PWA)

### 8.1 Configuração

| Parâmetro | Valor |
|-----------|-------|
| Nome | Vigilância Sanitária - Anápolis |
| Nome curto | VISA Anápolis |
| `start_url` | `/VISA/` |
| `display` | `standalone` (sem barra de endereço do browser) |
| `theme_color` | `#004aad` |
| `background_color` | `#ffffff` |
| Ícones | 192×192 e 512×512 px (PNG) |
| Estratégia de cache | Network First — usa rede; cache como fallback offline |
| Nome do cache | `visa-v2.5.1` |

### 8.2 Service Workers

- **`service-worker.js`:** PWA principal — Network First, `skipWaiting()` para atualização imediata, compatível com iOS e Android
- **`firebase-messaging-sw.js`:** SW do FCM — recebe notificações push em background/closed

### 8.3 Detecção de plataforma (`platform-detector.js`)

| Classe CSS | Condição |
|-----------|---------|
| `.ios-device` | iOS (iPhone, iPad, iPod Touch) |
| `.android-device` | Android |
| `.desktop-device` | Windows, macOS, Linux |
| `.mobile-device` | Qualquer dispositivo móvel |
| `.pwa-mode` | App instalado (`display-mode: standalone`) |

O detector expõe `window.platform` com 15+ capacidades detectadas (Touch, Push API, Service Worker, Vibration, Backdrop Filter, Dark Mode, Reduced Motion, tipo de conexão, DPR, safe area insets).

---

## 9. Automação (GitHub Actions)

### 9.1 Workflows

| Workflow | Gatilho | Função |
|----------|---------|--------|
| `notify-os.yml` | Push nos CSVs + cron 3×/dia (seg–sex) | Envia push FCM para OS com prazo próximo; atualiza snapshot |
| `notify-email-os.yml` | Push nos CSVs + cron 3×/dia | Envia e-mail HTML por fiscal com OS pendentes |
| `test-notify.yml` | Manual (`workflow_dispatch`) | Envia push de teste para todos os usuários com token |
| `test-email-notify.yml` | Manual | Envia e-mail de teste para verificar SMTP |
| `reset-optin-sem-token.yml` | Manual | Reseta `notificationOptIn` de usuários sem token FCM válido |

### 9.2 Scripts de notificação (`.github/scripts/`)

Escritos em **Node.js puro** (sem dependências além de `firebase-admin` e `nodemailer`). O parser de CSV é implementado manualmente.

**Fluxo do `notify-os.js`:**
1. Parsear os 5 CSVs de OS (requerimento, ofício, denúncia, protocolo, tramitação)
2. Carregar o snapshot anterior (`os_snapshot.json`)
3. Calcular `diasParaPrazo` para cada OS
4. Identificar o gatilho adequado (`VENCE_HOJE`, `AMANHA`, `RECUPERACAO`, `PRAZO_5D`)
5. Agrupar OS por fiscal responsável
6. Enviar notificações FCM (multicast por lista de tokens)
7. Atualizar snapshot e commitar de volta ao repositório

### 9.3 Segredos utilizados (GitHub Secrets)

| Segredo | Uso |
|---------|-----|
| `FIREBASE_SERVICE_ACCOUNT` | JSON da service account do Firebase Admin SDK |
| `SMTP_USER` | E-mail Gmail para envio via SMTP |
| `SMTP_PASSWORD` | App Password do Gmail (2FA obrigatório) |

---

## 10. Busca Global Unificada

### 10.1 Visão geral

O `busca-global.js` (módulo ES6) pesquisa **7 fontes de dados simultâneas** a partir do dashboard, retornando resultados categorizados sem precisar navegar entre páginas.

### 10.2 Fontes de busca

| Fonte | Arquivo | O que retorna |
|-------|---------|---------------|
| Regulados | `data/index_regulados.json` | Estabelecimentos por razão social, fantasia ou CNPJ/CPF |
| Ordens de Serviço | `data/requerimento.csv` | OS ativas (não atendidas/canceladas), mais recente por regulado |
| Protocolos | `data/protocolo.csv` + `tramitacao.csv` | Protocolos com dados do requerente e status (JOIN) |
| Denúncias | `data/denuncia.csv` | Denúncias ativas |
| Ofícios | `data/oficio.csv` | Ofícios ativos (não cancelados/arquivados) |
| Alvarás | `data/alvara.csv` via índice | Alvará mais recente por regulado (por ano de exercício) |

### 10.3 Características técnicas

- **Lazy load:** dados carregados apenas na primeira busca; mantidos em `_cacheBusca` durante a sessão
- **Normalização:** remoção de acentos (NFD), pontuação e zeros à esquerda de CNPJ
- **Resultado máximo:** 5 itens por categoria; link "Ver todos" quando há mais
- **Trigger:** Enter ou clique no botão (não busca ao digitar)
- **Mínimo de caracteres:** 3 para iniciar a busca
- **Logout:** `limparCacheBusca()` limpa o cache em memória

---

## 11. Pontos de Atenção e Melhorias Futuras

### 11.1 Dívida técnica identificada

| Item | Impacto | Recomendação |
|------|---------|-------------|
| **Whitelist de e-mails hardcoded** em `js/guard.js` | Adicionar usuário exige edição de código-fonte e novo deploy | Migrar para campo `ativo` no Firestore (parcialmente implementado via `guard1.js`) |
| **`inspecoes.csv` (19 MB) carregado integralmente** | Pode ser perceptível em conexões lentas | Criar índice JSON pré-calculado similar ao `index_regulados.json` |
| **Sidebar colapsável não implementado** | Navegação com muitos itens sem agrupamento visual | Implementar accordion (plano detalhado em `CLAUDE.md` e `docs/PROJETO_EXCELENCIA_UNIFICADO.md`) |
| **Sincronização manual de dados** | CSVs atualizados manualmente, sem integração com sistema-fonte | Automatizar sincronização via API ou script agendado |
| **jQuery residual em algumas páginas** | Dependência desnecessária no projeto vanilla JS | Migrar gradualmente para Vanilla JS puro |

### 11.2 Pontos fortes

- ✅ **Zero infraestrutura própria:** hospedagem, CI/CD e banco via plataformas gratuitas (GitHub Pages, Firebase Spark)
- ✅ **PWA com suporte offline:** funciona com sinal instável, ideal para uso em campo
- ✅ **Notificações proativas:** fiscais recebem alertas de prazo sem precisar verificar o sistema
- ✅ **Design system consistente:** CSS custom properties garantem coerência e dark mode automático
- ✅ **Sem build step:** qualquer arquivo editado é deployado com um `git push`
- ✅ **Detecção de plataforma:** UI adaptada para iOS, Android e desktop

### 11.3 Roadmap identificado

| Item | Status | Prioridade |
|------|--------|-----------|
| Sidebar colapsável (accordion por seções) | Planejado | Alta |
| Índice de inspeções para reduzir carga do browser | Planejado | Média |
| Migração completa de whitelist para Firestore | Parcial | Média |
| Eliminação do jQuery residual | Em andamento | Baixa |
| Integração automatizada com sistema-fonte de dados | Não iniciado | Alta |
| Testes automatizados (unitários/E2E) | Não iniciado | Média |

---

## 12. Conclusão

O **VISA Anápolis** é uma aplicação web institucional madura e funcional, que demonstra que é possível construir uma solução de gestão operacional robusta com tecnologias simples e custo zero de infraestrutura.

A escolha por um **stack minimalista** (HTML + CSS + Vanilla JS + Firebase + GitHub Pages) reduz a superfície de falhas, elimina dependências de build e facilita a manutenção por um time reduzido.

Os principais diferenciais técnicos são:
- **Arquitetura serverless completa** — sem servidores para provisionar ou manter
- **Sistema de notificações dual-canal automatizado** — push FCM + e-mail via GitHub Actions
- **Busca global unificada** em 7 fontes com lazy loading e normalização inteligente
- **Design system baseado em tokens CSS** com dark mode e otimizações por plataforma (iOS/Android)

Os pontos de atenção mais críticos são a **gestão manual dos CSVs** (sem integração com sistema-fonte) e a **whitelist hardcoded de e-mails**, ambos com plano de melhoria identificado e parcialmente em andamento.

---

*Documento gerado em março/2026 · VISA Anápolis v2.5.1 · Vigilância Sanitária — Anápolis-GO*
