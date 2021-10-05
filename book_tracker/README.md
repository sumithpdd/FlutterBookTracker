# book_tracker

A flutter book tracker project.

## Getting Started

Track books with flutter and firebase

## pakages

hexcolor

For firebase and firestore add these packages
cloud_firestore
cupertino_icons
firebase_auth
firebase_core

Also modify index.html for latest firebase and firestore support. add after body.

```javascript
<script src="https://www.gstatic.com/firebasejs/9.1.1/firebase-app-compat.js"></script>
    <script src="https://www.gstatic.com/firebasejs/9.1.1/firebase-firestore-compat.js"></script>
    <script src="https://www.gstatic.com/firebasejs/9.1.1/firebase-auth-compat.js"></script>
    <script>
        // Your web app's Firebase configuration
        // For Firebase JS SDK v7.20.0 and later, measurementId is optional
        var firebaseConfig = {
            apiKey: "",
            authDomain: "",
            databaseURL: "",
            projectId: "",
            storageBucket: "",
            messagingSenderId: "",
            appId: "",
            measurementId: ""
        };

        // Initialize Firebase
        const firebaseApp = firebase.initializeApp(firebaseConfig);
        const db = firebaseApp.firestore();
        const auth = firebaseApp.auth();
    </script>
```
