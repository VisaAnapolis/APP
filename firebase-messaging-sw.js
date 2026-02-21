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

  const { title, body, icon, data } = payload.notification ?? {};
  const notifTitle = title || 'VISA Anápolis';
  const notifOptions = {
    body:  body  || 'Novas Ordens de Serviço disponíveis.',
    icon:  icon  || '/VISA/icons/visa-192.png',
    badge: '/VISA/icons/visa-192.png',
    tag:   'visa-os-update',          // agrupa notificações do mesmo tipo
    renotify: true,
    data:  data  || { url: '/VISA/os.html' }
  };

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
