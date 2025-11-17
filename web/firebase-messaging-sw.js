importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyADI6YGnk2_CXdqeZtFIVub_fFuF88Sul8",
  authDomain: "megastation-43475.firebaseapp.com",
  projectId: "megastation-43475",
  storageBucket: "megastation-43475.firebasestorage.app",
  messagingSenderId: "528326047070",
  appId: "1:528326047070:web:07425907cb4bc9c0c3cbcf",
  measurementId: "G-1G1V7HHZMS"
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
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});