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
    apiKey: 'AIzaSyCyRojed8QV_dRWAGCwIHiu6NFxLiRqcN8',
    appId: '1:1020621847486:web:d30ac1ab852a7757d057ef',
    messagingSenderId: '1020621847486',
    projectId: 'coffee-f12cd',
    authDomain: 'coffee-f12cd.firebaseapp.com',
    storageBucket: 'coffee-f12cd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkBXTQIh8n7_pTdrssW7EweH9JJ2zu94o',
    appId: '1:1020621847486:android:57f2f988b804620ad057ef',
    messagingSenderId: '1020621847486',
    projectId: 'coffee-f12cd',
    storageBucket: 'coffee-f12cd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9pb7zHBhfNGxVB_mK-5rLXQ2uM3LruZA',
    appId: '1:1020621847486:ios:daf38b3d1245c3b6d057ef',
    messagingSenderId: '1020621847486',
    projectId: 'coffee-f12cd',
    storageBucket: 'coffee-f12cd.appspot.com',
    androidClientId: '1020621847486-q81iio1dej0mrr5r8r8fe2ubi1nhdsra.apps.googleusercontent.com',
    iosClientId: '1020621847486-5v9dcvjs0cc1rbrn15o9nrogk1nr4ehs.apps.googleusercontent.com',
    iosBundleId: 'com.example.resumeBuilder',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC9pb7zHBhfNGxVB_mK-5rLXQ2uM3LruZA',
    appId: '1:1020621847486:ios:2b7acba714b92dabd057ef',
    messagingSenderId: '1020621847486',
    projectId: 'coffee-f12cd',
    storageBucket: 'coffee-f12cd.appspot.com',
    androidClientId: '1020621847486-q81iio1dej0mrr5r8r8fe2ubi1nhdsra.apps.googleusercontent.com',
    iosClientId: '1020621847486-cti3e8625335aai139cldagph3obhhlk.apps.googleusercontent.com',
    iosBundleId: 'com.example.resumeBuilder.RunnerTests',
  );
}
