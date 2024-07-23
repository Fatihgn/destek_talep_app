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
    apiKey: 'AIzaSyCnJkTXIEZlq4wcJjBYD_TGQMYEfEW4ZoY',
    appId: '1:916617049293:web:ffc3ee4f1ecd3a325ca584',
    messagingSenderId: '916617049293',
    projectId: 'destek-talep',
    authDomain: 'destek-talep.firebaseapp.com',
    storageBucket: 'destek-talep.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDIlrgo5t5KDpfhEd3c9KO06nExNaK2fio',
    appId: '1:916617049293:android:17e7006c9a3b88815ca584',
    messagingSenderId: '916617049293',
    projectId: 'destek-talep',
    storageBucket: 'destek-talep.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCoAgw73oYNYwC9DlR7N7N8D7Lar1dHNK8',
    appId: '1:916617049293:ios:879d585e6c0702255ca584',
    messagingSenderId: '916617049293',
    projectId: 'destek-talep',
    storageBucket: 'destek-talep.appspot.com',
    iosBundleId: 'com.example.destekTalepApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCoAgw73oYNYwC9DlR7N7N8D7Lar1dHNK8',
    appId: '1:916617049293:ios:a642b97c50dd86eb5ca584',
    messagingSenderId: '916617049293',
    projectId: 'destek-talep',
    storageBucket: 'destek-talep.appspot.com',
    iosBundleId: 'com.example.destekTalepApp.RunnerTests',
  );
}
