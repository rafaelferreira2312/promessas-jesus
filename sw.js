// Service Worker para Portal Jesus é o Pão da Vida
const CACHE_NAME = 'promessas-jesus-v1.0';
const urlsToCache = [
  '/',
  '/index.html',
  '/css/style.css',
  '/js/main.js',
  '/js/i18n/pt.js',
  '/js/i18n/en.js',
  '/json/config.json',
  '/json/local_verses.json',
  '/json/blog_index.json',
  '/assets/images/jesus-pao.webp',
  '/assets/images/favicon.svg',
  '/manifest.json'
];

// Instalar SW
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        console.log('Cache aberto');
        return cache.addAll(urlsToCache);
      })
  );
});

// Ativar SW
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== CACHE_NAME) {
            console.log('Removendo cache antigo:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});

// Interceptar requests
self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        // Retornar cache se disponível
        if (response) {
          return response;
        }
        return fetch(event.request);
      }
    )
  );
});
