var cacheName="tectonic-cache-12-03-0001",filesToCache=["/img/plates/al.jpg","/img/plates/ak.jpg","/img/plates/az.jpg","/img/plates/ar.jpg","/img/plates/ca.jpg","/img/plates/co.jpg","/img/plates/ct.jpg","/img/plates/de.jpg","/img/plates/dc.jpg","/img/plates/fl.jpg","/img/plates/ga.jpg","/img/plates/hi.jpg","/img/plates/id.jpg","/img/plates/il.jpg","/img/plates/in.jpg","/img/plates/ia.jpg","/img/plates/ks.jpg","/img/plates/ky.jpg","/img/plates/la.jpg","/img/plates/me.jpg","/img/plates/md.jpg","/img/plates/ma.jpg","/img/plates/mi.jpg","/img/plates/mn.jpg","/img/plates/ms.jpg","/img/plates/mo.jpg","/img/plates/mt.jpg","/img/plates/ne.jpg","/img/plates/nv.jpg","/img/plates/nh.jpg","/img/plates/nj.jpg","/img/plates/nm.jpg","/img/plates/ny.jpg","/img/plates/nc.jpg","/img/plates/nd.jpg","/img/plates/oh.jpg","/img/plates/ok.jpg","/img/plates/or.jpg","/img/plates/pa.jpg","/img/plates/ri.jpg","/img/plates/sc.jpg","/img/plates/sd.jpg","/img/plates/tn.jpg","/img/plates/tx.jpg","/img/plates/ut.jpg","/img/plates/vt.jpg","/img/plates/va.jpg","/img/plates/wa.jpg","/img/plates/wv.jpg","/img/plates/wi.jpg","/img/plates/wy.jpg","/img/play_games_plate.png","/assets/application-a6bd33100278a9e5ec46e030e905615ef23f1485015f3f7619834df9388e53d6.js","/assets/application-184075424cc450785131889fff5445b97b2b535565d13b1cbd7f93dab171b09d.css","/offline.html"];self.addEventListener("install",function(e){console.log("[ServiceWorker] Install"),e.waitUntil(caches.open(cacheName).then(function(e){return console.log("[ServiceWorker] Caching app shell"),e.addAll(filesToCache)}))}),self.addEventListener("activate",function(e){return console.log("[ServiceWorker] Activate"),e.waitUntil(caches.keys().then(function(e){return Promise.all(e.map(function(e){if(e!==cacheName)return console.log("[ServiceWorker] Removing old cache",e),caches["delete"](e)}))})),self.clients.claim()}),self.addEventListener("fetch",function(e){e.respondWith(caches.match(e.request).then(function(p){return p||fetch(e.request)})["catch"](function(){return caches.match("/offline.html")}))});