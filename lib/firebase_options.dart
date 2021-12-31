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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCT1chrS5BHnn1BUjwE5FdT9bWVz6F79LI',
    appId: '1:1095626926654:android:797b5d0f38539461ba3f6f',
    messagingSenderId: '1095626926654',
    projectId: 'monerate',
    storageBucket: 'monerate.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOHlbk44PUKKwmiA_7s_U4Smp1Myzisfk',
    appId: '1:1095626926654:ios:b798afc0c100e8afba3f6f',
    messagingSenderId: '1095626926654',
    projectId: 'monerate',
    storageBucket: 'monerate.appspot.com',
    iosClientId:
        '1095626926654-65e0r92e9te75lf3ptk9rng6caaf7g1q.apps.googleusercontent.com',
    iosBundleId: 'com.k5924.monerate',
  );
}
