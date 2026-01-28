# CHANGELOG — VISA Anápolis

Este documento registra as alterações publicadas no WebCVS/VISA App.
Horários em **Horário de Brasília (UTC−3)**.

---

## v2.0.8 — 28/01/2026 19:56 (Horário de Brasília – UTC−3)

### Correções críticas (tela inicial / index.html)
- **Corrigido o atraso/intermitência no reconhecimento do perfil** ao entrar no sistema (desktop e mobile), que exigia “clicar em um link e voltar” para o perfil aparecer corretamente.
- **Unificação do fluxo de inicialização** de autenticação/perfil para evitar disputa de ordem (race condition) entre:
  - autenticação Firebase,
  - verificação de e-mail autorizado (allowlist),
  - leitura do perfil no Firestore (`usuarios`).
- **Central de Trabalho passa a aparecer rapidamente**, sem depender do perfil, **mantendo segurança**: links sensíveis ficam “travados” até o perfil ser carregado.

### Controle de permissões por perfil (Firestore)
- Regras reforçadas para renderização condicional:
  - **Fiscal:** mostra resumo de OS pendentes (e oculta indicadores gerenciais).
  - **Administrador:** mostra indicadores gerenciais (e oculta resumo de OS).
  - **Administrativo:** oculta indicadores e resumo de OS (conteúdo institucional apenas).
- **Links sensíveis por perfil**:
  - `rmpf.html` e `inspecoes.html`: exigem perfil válido.
  - `admin.html`: exclusivo de Administrador.
- Mantida a arquitetura em **duas camadas**:
  1) Firebase Auth + allowlist de e-mails (entrada)
  2) Perfil no Firestore (permissões e visibilidade)

### Resiliência em rede ruim (praia / 4G / Wi-Fi instável)
- **Adicionado timeout + retry** para busca do perfil no Firestore:
  - Em caso de lentidão, o app informa “Conexão lenta — tentando novamente…”.
  - Realiza uma nova tentativa controlada (sem travar a central).
  - Se ainda falhar, mantém comportamento seguro: não libera links sensíveis sem perfil confirmado.

### Estabilidade e compatibilidade (HTML/CSS/JS)
- **Removida duplicidade do PapaParse** (biblioteca estava incluída 2 vezes via CDNs diferentes).
  - Reduz risco de comportamento inconsistente em alguns dispositivos.
  - Reduz downloads desnecessários no mobile.
- **Correções de HTML/CSS inconsistentes** (tags/chaves sobressalentes) que podem causar diferenças de renderização entre navegadores/dispositivos.
- Correção do erro em runtime:
  - `ReferenceError: setUserInfoLoadingText is not defined`.

### Observações operacionais
- Service Worker permanece **mínimo (sem cache de fetch)** para privilegiar previsibilidade durante a fase de evolução rápida do sistema (evita “PWA preso em versão antiga”).
- Próxima etapa planejada (ainda NÃO aplicada nesta versão):
  - **Cache curto do perfil** (por e-mail, TTL baixo e limpeza no logout), com atenção especial a desktops compartilhados.

---

## v2.0.7 — (baseline anterior)
- Versão anterior de referência (antes das correções críticas de carregamento do perfil).
