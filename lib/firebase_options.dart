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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
    apiKey: 'AIzaSyBD81K8rEtLGXs_MjCCyvMv0I6E-aeUpAo',
    appId: '1:1026276895469:android:8ea33e765c3846ca4bfae4',
    messagingSenderId: '1026276895469',
    projectId: 'notely-27b52',
    storageBucket: 'notely-27b52.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4DlxNrDrcAtZOOmL3GALFahq0Zb20UBE',
    appId: '1:1026276895469:ios:c200e91e273985eb4bfae4',
    messagingSenderId: '1026276895469',
    projectId: 'notely-27b52',
    storageBucket: 'notely-27b52.appspot.com',
    androidClientId: '1026276895469-n7cffkr26p8ba57i4qgsuo2v9236g3ba.apps.googleusercontent.com',
    iosClientId: '1026276895469-jd0lj3pnd3ftp8kivsolehu7o7h8sp3c.apps.googleusercontent.com',
    iosBundleId: 'com.example.notely',
  );
}