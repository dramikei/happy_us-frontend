importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-messaging.js");

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;


firebase.initializeApp({
   apiKey: "AIzaSyDXAKiTAmT-6Mi086aF_kAbEOFu7lzEMUo",
   authDomain: "happy-us-350b1.firebaseapp.com",
   projectId: "happy-us-350b1",
   storageBucket: "happy-us-350b1.appspot.com",
   messagingSenderId: "559349755392",
   appId: "1:559349755392:web:fb0979953fa8fa582b72e5",
   measurementId: "G-6ZBY6X9M03"
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