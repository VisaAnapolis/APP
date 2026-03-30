// ============================================================
// Service Worker — VISA Anápolis
// Estratégia: Network First (sempre busca a versão mais recente
// da rede; usa cache apenas como fallback offline).
//
// Isso resolve o problema histórico de usuários presos em versões
// antigas do app, especialmente em PWAs no iOS e Android.
// ============================================================

const CACHE_NAME = 'visa-v2.5.9';

// Assume controle imediatamente, sem aguardar abas serem fechadas
self.addEventListener('install', () => self.skipWaiting());
self.addEventListener('activate', (e) => e.waitUntil(self.clients.claim()));

// ── Network First: tenta a rede, cai para cache apenas se offline ──
self.addEventListener('fetch', (event) => {
  // Ignora requisições não-GET e extensões do Chrome
  if (event.request.method !== 'GET') return;
  if (event.request.url.startsWith('chrome-extension://')) return;

  event.respondWith(
    fetch(event.request)
      .then((networkResponse) => {
        // Resposta da rede obtida: atualiza o cache e retorna
        if (networkResponse && networkResponse.status === 200) {
          const responseClone = networkResponse.clone();
          caches.open(CACHE_NAME).then((cache) => {
            cache.put(event.request, responseClone);
          });
        }
        return networkResponse;
      })
      .catch(() => {
        // Offline: tenta servir do cache como fallback
        return caches.match(event.request);
      })
  );
});
