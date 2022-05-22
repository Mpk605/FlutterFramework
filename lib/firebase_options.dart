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
    apiKey: 'AIzaSyDLw7ygy4lg8KGPDv-FARfdrfT1yRkG2fg',
    appId: '1:738732961243:web:58fee0bd87fede243acbfe',
    messagingSenderId: '738732961243',
    projectId: 'tp4flutter-c7f83',
    authDomain: 'tp4flutter-c7f83.firebaseapp.com',
    storageBucket: 'tp4flutter-c7f83.appspot.com',
    measurementId: 'G-W9R2X3SYEL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNQXk13CRwMo1KIYNNcoSh5xF8I3-T3oU',
    appId: '1:738732961243:android:a973d1989d0afcf43acbfe',
    messagingSenderId: '738732961243',
    projectId: 'tp4flutter-c7f83',
    storageBucket: 'tp4flutter-c7f83.appspot.com',
  );
}