// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyBF6ki2GwZIMojROU1usSOjkzn52qBXIgw',
    appId: '1:1885056775:web:e99b203e3f8eea31005fa2',
    messagingSenderId: '1885056775',
    projectId: 'flutterfiresample-14d9e',
    authDomain: 'flutterfiresample-14d9e.firebaseapp.com',
    storageBucket: 'flutterfiresample-14d9e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzhG9sBrGVqOkSsbkWrW55VuyC9aFNkSg',
    appId: '1:1885056775:android:84068f94870a3c37005fa2',
    messagingSenderId: '1885056775',
    projectId: 'flutterfiresample-14d9e',
    storageBucket: 'flutterfiresample-14d9e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZeG9Oo8_lY7hU0PzGOyLXj5UXxqSKmAk',
    appId: '1:1885056775:ios:478337090ac95cf6005fa2',
    messagingSenderId: '1885056775',
    projectId: 'flutterfiresample-14d9e',
    storageBucket: 'flutterfiresample-14d9e.appspot.com',
    iosClientId: '1885056775-sgrt556gjkguakmvic78h9i01muodl5k.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFireApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAZeG9Oo8_lY7hU0PzGOyLXj5UXxqSKmAk',
    appId: '1:1885056775:ios:478337090ac95cf6005fa2',
    messagingSenderId: '1885056775',
    projectId: 'flutterfiresample-14d9e',
    storageBucket: 'flutterfiresample-14d9e.appspot.com',
    iosClientId: '1885056775-sgrt556gjkguakmvic78h9i01muodl5k.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFireApp',
  );
}
