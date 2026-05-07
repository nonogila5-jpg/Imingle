import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyAs-AMAN-AUDIO-2026-Project-Key",
      authDomain: "aman-audoi-default-rtdb.firebaseapp.com",
      databaseURL: "https://aman-audoi-default-rtdb.firebaseio.com/",
      projectId: "aman-audoi-default-rtdb",
      storageBucket: "aman-audoi-default-rtdb.appspot.com",
      messagingSenderId: "1000131633",
      appId: "1:1000131633:web:de1290a3d4884f30b80d",
    );
  }
}