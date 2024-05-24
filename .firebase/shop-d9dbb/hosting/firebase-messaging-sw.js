importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-messaging.js");
firebase.initializeApp({
  apiKey: 'AIzaSyBW35i7xpTR-jA-N-HyWmlU4DPuUeulMdc',
      appId: '1:103357185550:web:4286d97aa49212c7bec65f',
      messagingSenderId: '103357185550',
      projectId: 'naturebeatz-af459',
      authDomain: 'naturebeatz-af459.firebaseapp.com',
      storageBucket: 'naturebeatz-af459.appspot.com',
      measurementId: 'G-DFK3EZT2W5',
});
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});