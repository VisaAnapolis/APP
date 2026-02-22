// ============================================================
// Firebase Cloud Messaging — Service Worker
// Obrigatório na raiz do site para receber notificações push
// mesmo com o app fechado / em background.
// ============================================================

importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey:            "AIzaSyDo473puJesZ9rr3IBoX5AWczCIMuKBTrg",
  authDomain:        "visam-3a30b.firebaseapp.com",
  projectId:         "visam-3a30b",
  messagingSenderId: "308899251430",
  appId:             "1:308899251430:web:0053cdbd0bed7f0de76727"
});

const messaging = firebase.messaging();

// ── Notificação em background (app fechado / aba inativa) ──
messaging.onBackgroundMessage((payload) => {
  console.log('[SW] Mensagem em background recebida:', payload);

  // Tenta extrair título e corpo de múltiplas fontes
  let notifTitle = 'VISA Anápolis';
  let notifBody = 'Novas Ordens de Serviço disponíveis.';

  // Prioridade 1: notification (campo padrão do FCM)
  if (payload.notification) {
    notifTitle = payload.notification.title || notifTitle;
    notifBody = payload.notification.body || notifBody;
  }

  // Prioridade 2: data (campos redundantes para Android)
  if (payload.data) {
    if (payload.data.title) notifTitle = payload.data.title;
    if (payload.data.body) notifBody = payload.data.body;
  }

  // Prioridade 3: android (campos específicos para Android)
  if (payload.android && payload.android.notification) {
    if (payload.android.notification.title) notifTitle = payload.android.notification.title;
    if (payload.android.notification.body) notifBody = payload.android.notification.body;
  }

  const icon = (payload.notification && payload.notification.icon) || '/VISA/icons/visa-192.png';
  const data = payload.data || { url: '/VISA/os.html' };

  const notifOptions = {
    body:  notifBody,
    icon:  icon,
    badge: '/VISA/icons/visa-192.png',
    tag:   `visa-prazo-${data.osNum || 'update'}`,  // tag única por OS
    renotify: true,
    requireInteraction: false,
    data:  data
  };

  console.log('[SW] Exibindo notificação:', { title: notifTitle, options: notifOptions });
  self.registration.showNotification(notifTitle, notifOptions);
});

// ── Clique na notificação: abre/foca a aba correta ──
self.addEventListener('notificationclick', (event) => {
  event.notification.close();

  const targetUrl = (event.notification.data && event.notification.data.url)
    ? event.notification.data.url
    : '/VISA/os.html';

  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then((windowClients) => {
      // Se já há uma aba aberta com a URL, foca nela
      for (const client of windowClients) {
        if (client.url.includes('/VISA/') && 'focus' in client) {
          return client.focus();
        }
      }
      // Caso contrário, abre nova aba
      if (clients.openWindow) {
        return clients.openWindow(targetUrl);
      }
    })
  );
});
