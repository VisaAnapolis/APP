// ============================================================
// push-notifications.js
// Módulo responsável por:
//   1. Solicitar permissão de notificação ao usuário
//   2. Obter o token FCM do dispositivo
//   3. Salvar/atualizar o token na coleção "usuarios" do Firestore
//      (campo: fcmTokens — array para suportar múltiplos dispositivos)
// ============================================================

const VAPID_KEY =
  'BE9_750iCXVu1uz9bOsvlVZIeAPpujMOcGAbBQa-uzFnKs7-RTROCMNASyf9KrNoRSibXo4RFIpzffiMXwgyVaQ';

/**
 * Resolve o path base do SW a partir da URL atual.
 * Funciona em GitHub Pages (/VISA/), localhost e qualquer subpath.
 */
function _resolverScopeSW() {
  try {
    const pathname = location.pathname; // ex: /VISA/index.html ou /VISA/
    // Extrai tudo até a última barra
    const base = pathname.substring(0, pathname.lastIndexOf('/') + 1);
    return {
      swPath: base + 'firebase-messaging-sw.js',
      scope:  base
    };
  } catch (_) {
    return { swPath: '/firebase-messaging-sw.js', scope: '/' };
  }
}

/**
 * Inicializa o Firebase Messaging e registra o token FCM do usuário.
 *
 * @param {object} firebaseApp  - Instância já inicializada do Firebase App
 * @param {string} userEmail    - E-mail do usuário autenticado (chave do doc no Firestore)
 * @param {boolean|null} userOptedIn - true = aceitou, false = recusou, null = silencioso
 * @returns {Promise<string|null>} Token FCM ou null em caso de falha/negação
 */
export async function initPushNotifications(firebaseApp, userEmail, userOptedIn) {
  try {
    // Verifica suporte do navegador
    if (!('Notification' in window)) {
      console.warn('[Push] Navegador não suporta notificações.');
      return null;
    }
    if (!('serviceWorker' in navigator)) {
      console.warn('[Push] Service Worker não suportado.');
      return null;
    }

    // Solicita permissão (só exibe diálogo se ainda não foi decidido)
    const permission = await Notification.requestPermission();
    if (permission !== 'granted') {
      console.info('[Push] Permissão negada pelo usuário.');
      return null;
    }

    // Importa módulos Firebase dinamicamente (mesma versão do projeto)
    const { getMessaging, getToken, onMessage } =
      await import('https://www.gstatic.com/firebasejs/10.12.0/firebase-messaging.js');
    const { getFirestore, doc, setDoc } =
      await import('https://www.gstatic.com/firebasejs/10.12.0/firebase-firestore.js');

    // Resolve o path do SW dinamicamente (funciona em qualquer subpath/domínio)
    const { swPath, scope } = _resolverScopeSW();

    // Aguarda qualquer SW em estado "installing" ou "waiting" antes de registrar
    // Isso evita corrida de condição após desregistro forçado na atualização de versão
    const swExistente = await navigator.serviceWorker.getRegistration(scope);
    if (swExistente && swExistente.installing) {
      await new Promise(resolve => {
        swExistente.installing.addEventListener('statechange', function handler(e) {
          if (e.target.state === 'activated') {
            this.removeEventListener('statechange', handler);
            resolve();
          }
        });
      });
    }

    const swReg = await navigator.serviceWorker.register(swPath, { scope });
    console.log('[Push] Service Worker FCM registrado:', swReg.scope);

    const messaging = getMessaging(firebaseApp);

    // Obtém o token FCM para este dispositivo/navegador
    const token = await getToken(messaging, {
      vapidKey:                  VAPID_KEY,
      serviceWorkerRegistration: swReg
    });

    if (!token) {
      console.warn('[Push] Token FCM não obtido (permissão pendente?).');
      return null;
    }

    console.log('[Push] Token FCM obtido:', token.substring(0, 20) + '...');

    // Salva o token no Firestore usando setDoc + merge:true
    // Isso CRIA o documento se não existir, ou ATUALIZA se já existir.
    // updateDoc lançaria erro se o documento não existisse.
    const db = getFirestore(firebaseApp);
    const emailKey = (userEmail || '').toLowerCase().trim();

    if (emailKey) {
      const updateData = {
        // arrayUnion via setDoc+merge não é suportado diretamente;
        // usamos getDoc + spread manual para garantir deduplicação
        fcmTokens: await _mergeToken(db, emailKey, token)
      };

      // Só grava notificationOptIn se foi explicitamente true/false (modal)
      if (userOptedIn === true || userOptedIn === false) {
        updateData.notificationOptIn = userOptedIn;
      }

      await setDoc(doc(db, 'usuarios', emailKey), updateData, { merge: true });
      console.log('[Push] Token salvo no Firestore para:', emailKey);
    }

    // Listener para mensagens com app em foreground (aba ativa)
    onMessage(messaging, (payload) => {
      console.log('[Push] Mensagem em foreground:', payload);
      _exibirNotificacaoForeground(payload);
    });

    return token;

  } catch (err) {
    console.error('[Push] Erro ao inicializar notificações:', err);
    return null;
  }
}

/**
 * Lê os tokens existentes do Firestore e retorna o array atualizado (sem duplicatas).
 * Substitui arrayUnion, que não funciona com setDoc+merge de forma confiável
 * quando o documento pode não existir ainda.
 */
async function _mergeToken(db, emailKey, novoToken) {
  try {
    const { doc, getDoc } = await import('https://www.gstatic.com/firebasejs/10.12.0/firebase-firestore.js');
    const snap = await getDoc(doc(db, 'usuarios', emailKey));
    const tokensExistentes = snap.exists() ? (snap.data().fcmTokens || []) : [];
    if (tokensExistentes.includes(novoToken)) return tokensExistentes;
    return [...tokensExistentes, novoToken];
  } catch (_) {
    return [novoToken];
  }
}

/**
 * Exibe uma notificação visual discreta quando o app está em foreground.
 *
 * IMPORTANTE: O servidor envia apenas o campo "data" (sem "notification").
 * Por isso, priorizamos payload.data para garantir o texto personalizado
 * (número da OS, motivo, prazo). payload.notification é usado apenas como
 * fallback de segurança, alinhando o comportamento com o firebase-messaging-sw.js.
 */
function _exibirNotificacaoForeground(payload) {
  const d = payload.data ?? {};
  const n = payload.notification ?? {};

  const notifTitle = d.title || n.title || 'VISA Anápolis';
  const notifBody  = d.body  || n.body  || 'Novas Ordens de Serviço disponíveis.';
  const notifUrl   = d.url   || n.url   || null;

  _mostrarToast(notifTitle, notifBody, notifUrl);
}

/**
 * Cria um toast (banner) no canto da tela para notificações em foreground.
 */
function _mostrarToast(titulo, mensagem, url) {
  const anterior = document.getElementById('visa-push-toast');
  if (anterior) anterior.remove();

  const toast = document.createElement('div');
  toast.id = 'visa-push-toast';
  toast.style.cssText = `
    position: fixed;
    bottom: 24px;
    right: 24px;
    z-index: 99999;
    background: #004aad;
    color: #fff;
    border-radius: 12px;
    padding: 16px 20px;
    max-width: 340px;
    box-shadow: 0 8px 32px rgba(0,0,0,0.25);
    font-family: system-ui, -apple-system, 'Segoe UI', Roboto, Arial, sans-serif;
    font-size: 0.95em;
    cursor: pointer;
    animation: visaToastIn 0.3s ease;
  `;

  toast.innerHTML = `
    <style>
      @keyframes visaToastIn {
        from { opacity:0; transform: translateY(20px); }
        to   { opacity:1; transform: translateY(0); }
      }
    </style>
    <div style="font-weight:700; margin-bottom:6px;">🔔 ${titulo}</div>
    <div style="opacity:0.9;">${mensagem}</div>
    <div style="margin-top:10px; font-size:0.85em; opacity:0.7;">Clique para ver as OSs</div>
  `;

  toast.addEventListener('click', () => {
    toast.remove();
    if (url) window.location.href = url;
    else if (!window.location.pathname.endsWith('os.html')) {
      window.location.href = location.origin + location.pathname.replace(/\/[^/]*$/, '/') + 'index.html';
    }
  });

  document.body.appendChild(toast);

  // Auto-remove após 8 segundos
  setTimeout(() => { if (toast.parentNode) toast.remove(); }, 8000);
}
