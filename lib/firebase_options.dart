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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBgxMDoRDGOtbWiLA9ZpNEfv8MUhJuhKPU',
    appId: '1:825540711084:android:62b14971734780aec60509',
    messagingSenderId: '825540711084',
    projectId: 'assignment-14c5d',
    storageBucket: 'assignment-14c5d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZOLv9XKTjqCPMheuI3x01FRk_d5deO9I',
    appId: '1:42790878860:ios:d00a493d38f84ce4f385a9',
    messagingSenderId: '42790878860',
    projectId: 'timepass-8c921',
    storageBucket: 'timepass-8c921.firebasestorage.app',
    iosBundleId: 'com.example.timepass',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDMcLmUOJVKd-UdmtSXO7VRImxOcyF0TJ8',
    appId: '1:825540711084:web:08d240994372b46ec60509',
    messagingSenderId: '825540711084',
    projectId: 'assignment-14c5d',
    authDomain: 'assignment-14c5d.firebaseapp.com',
    storageBucket: 'assignment-14c5d.firebasestorage.app',
    measurementId: 'G-4DZ4KDQFEC',
  );

}