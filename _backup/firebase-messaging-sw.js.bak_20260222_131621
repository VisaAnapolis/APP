// ============================================================
// Firebase Cloud Messaging — Service Worker
// Obrigatório na raiz do site para receber notificações push
// mesmo com o app fechado / em background.
//
// IMPORTANTE: O servidor envia APENAS o campo "data" (sem "notification").
// Isso evita que o Android exiba a mensagem padrão do sistema.
// Este Service Worker é o ÚNICO responsável por exibir a notificação.
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
// Como o servidor envia apenas "data", este handler é sempre acionado.
messaging.onBackgroundMessage((payload) => {
  console.log('[SW] Mensagem em background recebida:', JSON.stringify(payload));

  // Lê o título e corpo do campo "data" (enviado pelo notify-os.js)
  const d = payload.data || {};
  const notifTitle = d.title || 'VISA Anápolis';
  const notifBody  = d.body  || 'Novas Ordens de Serviço disponíveis.';
  const notifUrl   = d.url   || 'https://garrado.github.io/VISA/os.html';
  const osNum      = d.osNum || 'update';

  const notifOptions = {
    body:    notifBody,
    icon:    'https://garrado.github.io/VISA/icons/visa-192.png',
    badge:   'https://garrado.github.io/VISA/icons/visa-192.png',
    tag:     `visa-prazo-${osNum}`,
    renotify: true,
    requireInteraction: false,
    data:    { url: notifUrl }
  };

  console.log('[SW] Exibindo notificação:', notifTitle, '|', notifBody);
  return self.registration.showNotification(notifTitle, notifOptions);
});

// ── Clique na notificação: abre/foca a aba correta ──
self.addEventListener('notificationclick', (event) => {
  event.notification.close();

  const targetUrl = (event.notification.data && event.notification.data.url)
    ? event.notification.data.url
    : 'https://garrado.github.io/VISA/os.html';

  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then((windowClients) => {
      for (const client of windowClients) {
        if (client.url.includes('/VISA/') && 'focus' in client) {
          return client.focus();
        }
      }
      if (clients.openWindow) {
        return clients.openWindow(targetUrl);
      }
    })
  );
});
