var cacheName = 'tectonic-cache-12-03-0001';
var filesToCache = [
'/img/plates/al.jpg',
'/img/plates/ak.jpg',
'/img/plates/az.jpg',
'/img/plates/ar.jpg',
'/img/plates/ca.jpg',
'/img/plates/co.jpg',
'/img/plates/ct.jpg',
'/img/plates/de.jpg',
'/img/plates/dc.jpg',
'/img/plates/fl.jpg',
'/img/plates/ga.jpg',
'/img/plates/hi.jpg',
'/img/plates/id.jpg',
'/img/plates/il.jpg',
'/img/plates/in.jpg',
'/img/plates/ia.jpg',
'/img/plates/ks.jpg',
'/img/plates/ky.jpg',
'/img/plates/la.jpg',
'/img/plates/me.jpg',
'/img/plates/md.jpg',
'/img/plates/ma.jpg',
'/img/plates/mi.jpg',
'/img/plates/mn.jpg',
'/img/plates/ms.jpg',
'/img/plates/mo.jpg',
'/img/plates/mt.jpg',
'/img/plates/ne.jpg',
'/img/plates/nv.jpg',
'/img/plates/nh.jpg',
'/img/plates/nj.jpg',
'/img/plates/nm.jpg',
'/img/plates/ny.jpg',
'/img/plates/nc.jpg',
'/img/plates/nd.jpg',
'/img/plates/oh.jpg',
'/img/plates/ok.jpg',
'/img/plates/or.jpg',
'/img/plates/pa.jpg',
'/img/plates/ri.jpg',
'/img/plates/sc.jpg',
'/img/plates/sd.jpg',
'/img/plates/tn.jpg',
'/img/plates/tx.jpg',
'/img/plates/ut.jpg',
'/img/plates/vt.jpg',
'/img/plates/va.jpg',
'/img/plates/wa.jpg',
'/img/plates/wv.jpg',
'/img/plates/wi.jpg',
'/img/plates/wy.jpg',
'/img/play_games_plate.png',
'/assets/application-fdbab63c87ec7cd33d58771861903a1ffeec1b7ffd94d9b0642b63aec70bff12.js',
'/assets/application-e113cc58d930559a6ca7d77afba9fc0e29293725ae5000e7cc215714cdcf8856.css',
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
        if (key !== cacheName) {
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
