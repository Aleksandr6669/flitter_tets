'use strict';

const CACHE_NAME = 'flutter-app-cache-{{flutter_service_worker_version}}';
// The ASSETS_TO_CACHE list is populated by the Flutter build process.
const ASSETS_TO_CACHE = [
  '/',
  'index.html',
  'main.dart.js',
  'manifest.json',
  'favicon.png',
  'icons/Icon-192.png',
  'icons/Icon-512.png',
  ...{{flutter_assets}}
];


self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log('Service Worker: Caching app shell');
      // The addAll() method is atomic. If any of the files fail to be added, the entire operation fails.
      return cache.addAll(ASSETS_TO_CACHE);
    })
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          // We are deleting all caches except for the current one.
          if (cacheName !== CACHE_NAME) {
            console.log('Service Worker: Deleting old cache', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});

self.addEventListener('fetch', (event) => {
  const requestUrl = new URL(event.request.url);

  // Bypass Firestore requests. Let the Firestore SDK handle its own caching and offline logic.
  if (requestUrl.hostname === 'firestore.googleapis.com') {
    // Respond with a network request.
    event.respondWith(fetch(event.request));
    return;
  }

  // For other requests, use a cache-first strategy.
  event.respondWith(
    caches.match(event.request).then((response) => {
      // If the resource is in the cache, return it.
      if (response) {
        return response;
      }
      // If the resource is not in the cache, fetch it from the network.
      return fetch(event.request);
    })
  );
});
