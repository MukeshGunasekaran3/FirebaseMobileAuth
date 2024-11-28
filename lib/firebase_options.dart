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
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCOAM2bbC3P9yQaoT341p8jONLPRaxc38s',
    appId: '1:272072906598:web:7b57461c5f590cdae65aa7',
    messagingSenderId: '272072906598',
    projectId: 'otpverify-7c78f',
    authDomain: 'otpverify-7c78f.firebaseapp.com',
    storageBucket: 'otpverify-7c78f.firebasestorage.app',
    measurementId: 'G-V93Y6KWQL3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZHZBVze4OsbVbMkEdKEwR6nCfupdj6Y4',
    appId: '1:272072906598:android:d3fda7eb6a811fe3e65aa7',
    messagingSenderId: '272072906598',
    projectId: 'otpverify-7c78f',
    storageBucket: 'otpverify-7c78f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_-o8BbwoJMBA01JdXhycwm2z7--5NpfY',
    appId: '1:272072906598:ios:09a682c0ad635634e65aa7',
    messagingSenderId: '272072906598',
    projectId: 'otpverify-7c78f',
    storageBucket: 'otpverify-7c78f.firebasestorage.app',
    iosBundleId: 'com.example.batechtask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_-o8BbwoJMBA01JdXhycwm2z7--5NpfY',
    appId: '1:272072906598:ios:09a682c0ad635634e65aa7',
    messagingSenderId: '272072906598',
    projectId: 'otpverify-7c78f',
    storageBucket: 'otpverify-7c78f.firebasestorage.app',
    iosBundleId: 'com.example.batechtask',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCOAM2bbC3P9yQaoT341p8jONLPRaxc38s',
    appId: '1:272072906598:web:09ca2e8c7c694df1e65aa7',
    messagingSenderId: '272072906598',
    projectId: 'otpverify-7c78f',
    authDomain: 'otpverify-7c78f.firebaseapp.com',
    storageBucket: 'otpverify-7c78f.firebasestorage.app',
    measurementId: 'G-75SGLZ2ZJY',
  );
}