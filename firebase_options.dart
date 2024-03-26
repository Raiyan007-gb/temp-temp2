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
    apiKey: 'AIzaSyB_SAtMFNnM7sOlVg2WWEcbRQKFfMxg4wo',
    appId: '1:404625750871:web:c85e92345938b75add9c12',
    messagingSenderId: '404625750871',
    projectId: 'blueberry-19a73',
    authDomain: 'blueberry-19a73.firebaseapp.com',
    storageBucket: 'blueberry-19a73.appspot.com',
    measurementId: 'G-4JFP26690S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACd6BivYm6ox5P2RCCDnuo5XM5vO7j2Lc',
    appId: '1:404625750871:android:6bdd7880b6ac011fdd9c12',
    messagingSenderId: '404625750871',
    projectId: 'blueberry-19a73',
    storageBucket: 'blueberry-19a73.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAeMsd7dTftSDNIj3yuSuf5qGOZ3fYPSyw',
    appId: '1:404625750871:ios:76d81543ab5e97dddd9c12',
    messagingSenderId: '404625750871',
    projectId: 'blueberry-19a73',
    storageBucket: 'blueberry-19a73.appspot.com',
    androidClientId: '404625750871-5am05jo6r1r87h2duif8q6ojc8r14fd1.apps.googleusercontent.com',
    iosClientId: '404625750871-05k251on8f36cvclfqfledfqbn1jhp93.apps.googleusercontent.com',
    iosBundleId: 'com.example.blueberryai.blueberryai',
  );
}