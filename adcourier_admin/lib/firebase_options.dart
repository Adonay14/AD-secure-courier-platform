// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyCAi0WBoE2u0KOZepJVoV6Y0aJGYfqSXgc",
      authDomain: "ad-courier.firebaseapp.com",
      projectId: "ad-courier",
      storageBucket: "ad-courier.firebasestorage.app",
      messagingSenderId: "44671729689",
      appId: "1:44671729689:web:0103a338362b1e0a092a88",
      measurementId: "G-L4HH39ZB4S"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAi0WBoE2u0KOZepJVoV6Y0aJGYfqSXgc',
    appId: '1:44671729689:android:0ab2170ff902004c092a88',
    messagingSenderId: '44671729689',
    projectId: 'ad-courier',
    storageBucket: 'ad-courier.firebasestorage.app',
  );

}