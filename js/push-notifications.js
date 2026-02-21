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
 * Inicializa o Firebase Messaging e registra o token FCM do usuário.
 *
 * @param {object} firebaseApp  - Instância já inicializada do Firebase App
 * @param {string} userEmail    - E-mail do usuário autenticado (chave do doc no Firestore)
 * @returns {Promise<string|null>} Token FCM ou null em caso de falha/negação
 */
export async function initPushNotifications(firebaseApp, userEmail) {
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
    const { getFirestore, doc, updateDoc, arrayUnion } =
      await import('https://www.gstatic.com/firebasejs/10.12.0/firebase-firestore.js');

    // Registra o service worker do FCM (deve estar na raiz do escopo)
    const swReg = await navigator.serviceWorker.register('/VISA/firebase-messaging-sw.js', {
      scope: '/VISA/'
    });
    console.log('[Push] Service Worker FCM registrado:', swReg.scope);

    const messaging = getMessaging(firebaseApp);

    // Obtém o token FCM para este dispositivo/navegador
    const token = await getToken(messaging, {
      vapidKey:            VAPID_KEY,
      serviceWorkerRegistration: swReg
    });

    if (!token) {
      console.warn('[Push] Token FCM não obtido (permissão pendente?).');
      return null;
    }

    console.log('[Push] Token FCM obtido:', token.substring(0, 20) + '...');

    // Salva o token no Firestore (arrayUnion evita duplicatas)
    const db = getFirestore(firebaseApp);
    const emailKey = (userEmail || '').toLowerCase().trim();

    if (emailKey) {
      await updateDoc(doc(db, 'usuarios', emailKey), {
        fcmTokens: arrayUnion(token)
      });
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
 * Exibe uma notificação visual discreta quando o app está em foreground.
 * Usa a Notification API nativa (não precisa do SW neste caso).
 */
function _exibirNotificacaoForeground(payload) {
  const { title, body } = payload.notification ?? {};
  const notifTitle = title || 'VISA Anápolis';
  const notifBody  = body  || 'Novas Ordens de Serviço disponíveis.';

  // Toast visual na própria página (não intrusivo)
  _mostrarToast(notifTitle, notifBody, payload.data?.url);
}

/**
 * Cria um toast (banner) no canto da tela para notificações em foreground.
 */
function _mostrarToast(titulo, mensagem, url) {
  // Remove toast anterior se existir
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
      window.location.href = '/VISA/os.html';
    }
  });

  document.body.appendChild(toast);

  // Auto-remove após 8 segundos
  setTimeout(() => { if (toast.parentNode) toast.remove(); }, 8000);
}
