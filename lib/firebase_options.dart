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
    apiKey: 'AIzaSyAbvYfWXdaf8bC-jmgIEKto3rRmuFL_-kw',
    appId: '1:137203139928:web:5d1699df1a7acdfeff912d',
    messagingSenderId: '137203139928',
    projectId: 'identity-5de1f',
    authDomain: 'identity-5de1f.firebaseapp.com',
    storageBucket: 'identity-5de1f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0I2gaeVndL8B8jN7zG7d-sIvys51yDf4',
    appId: '1:137203139928:android:195198fc55b4ffccff912d',
    messagingSenderId: '137203139928',
    projectId: 'identity-5de1f',
    storageBucket: 'identity-5de1f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTsZLOrjwrl0iKBsjA3BxB0Je3NGoLupc',
    appId: '1:137203139928:ios:b3b24fc82d638208ff912d',
    messagingSenderId: '137203139928',
    projectId: 'identity-5de1f',
    storageBucket: 'identity-5de1f.appspot.com',
    androidClientId: '137203139928-qg126s1oc6l0jnc6a2mr82t4t1cdgsvq.apps.googleusercontent.com',
    iosClientId: '137203139928-aa08b1l5oiup5bfhihqb25obt58kc3af.apps.googleusercontent.com',
    iosBundleId: 'com.yolinx.gofast',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBTsZLOrjwrl0iKBsjA3BxB0Je3NGoLupc',
    appId: '1:137203139928:ios:b3b24fc82d638208ff912d',
    messagingSenderId: '137203139928',
    projectId: 'identity-5de1f',
    storageBucket: 'identity-5de1f.appspot.com',
    androidClientId: '137203139928-qg126s1oc6l0jnc6a2mr82t4t1cdgsvq.apps.googleusercontent.com',
    iosClientId: '137203139928-aa08b1l5oiup5bfhihqb25obt58kc3af.apps.googleusercontent.com',
    iosBundleId: 'com.yolinx.gofast',
  );
}