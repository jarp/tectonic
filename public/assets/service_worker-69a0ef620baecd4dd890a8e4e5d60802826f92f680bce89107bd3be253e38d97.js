var cacheName = 'tectonic-cache-8-31-1800';
var filesToCache = [
'/assets/images/plates/al.jpg',
'/assets/images/plates/ak.jpg',
'/assets/images/plates/az.jpg',
'/assets/images/plates/ar.jpg',
'/assets/images/plates/ca.jpg',
'/assets/images/plates/co.jpg',
'/assets/images/plates/ct.jpg',
'/assets/images/plates/de.jpg',
'/assets/images/plates/dc.jpg',
'/assets/images/plates/fl.jpg',
'/assets/images/plates/ga.jpg',
'/assets/images/plates/hi.jpg',
'/assets/images/plates/id.jpg',
'/assets/images/plates/il.jpg',
'/assets/images/plates/in.jpg',
'/assets/images/plates/ia.jpg',
'/assets/images/plates/ks.jpg',
'/assets/images/plates/ky.jpg',
'/assets/images/plates/la.jpg',
'/assets/images/plates/me.jpg',
'/assets/images/plates/md.jpg',
'/assets/images/plates/ma.jpg',
'/assets/images/plates/mi.jpg',
'/assets/images/plates/mn.jpg',
'/assets/images/plates/ms.jpg',
'/assets/images/plates/mo.jpg',
'/assets/images/plates/mt.jpg',
'/assets/images/plates/ne.jpg',
'/assets/images/plates/nv.jpg',
'/assets/images/plates/nh.jpg',
'/assets/images/plates/nj.jpg',
'/assets/images/plates/nm.jpg',
'/assets/images/plates/ny.jpg',
'/assets/images/plates/nc.jpg',
'/assets/images/plates/nd.jpg',
'/assets/images/plates/oh.jpg',
'/assets/images/plates/ok.jpg',
'/assets/images/plates/or.jpg',
'/assets/images/plates/pa.jpg',
'/assets/images/plates/ri.jpg',
'/assets/images/plates/sc.jpg',
'/assets/images/plates/sd.jpg',
'/assets/images/plates/tn.jpg',
'/assets/images/plates/tx.jpg',
'/assets/images/plates/ut.jpg',
'/assets/images/plates/vt.jpg',
'/assets/images/plates/va.jpg',
'/assets/images/plates/wa.jpg',
'/assets/images/plates/wv.jpg',
'/assets/images/plates/wi.jpg',
'/assets/images/plates/wy.jpg',
'/assets/images/plates-header.png',
'/assets/application-fe057428a263dfab9fbb517e9fe7ac5314a1638957004e56fac1f7b225834eb9.js',
'/assets/application-3a159e8a08c1d07a21cf9864d871dff0dfa02562cdd9587dedf57108191736de.css',
'/offline.html'
];

self.addEventListener('install', function(e) {
  console.log('[ServiceWorker] Install');
  e.waitUntil(
    caches.open(cacheName).then(function(cache) {
      console.log('[ServiceWorker] Caching app shell');
      return cache.addAll(filesToCache);
    })
  );
});

self.addEventListener('activate', function(e) {
  console.log('[ServiceWorker] Activate');
  e.waitUntil(
    caches.keys().then(function(keyList) {
      return Promise.all(keyList.map(function(key) {
        if (key !== cacheName && key !== dataCacheName) {
          console.log('[ServiceWorker] Removing old cache', key);
          return caches.delete(key);
        }
      }));
    })
  );
  return self.clients.claim();
});

self.addEventListener('fetch', function(e) {
  // console.log('[Service Worker] Fetch', e.request.url);

    e.respondWith(
      caches.match(e.request).then(function(response) {
        return response || fetch(e.request);
      }).catch(function() {
      return caches.match('/offline.html');
    })
    );

});
