import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyACO06kzwi9GOubGowjLdyGgpLLygXpR6Y',
    appId: '1:977500695929:web:0aa73a381f388dd63e53a8',
    messagingSenderId: '977500695929',
    projectId: 'dglai-5f88c',
    authDomain: 'dglai-5f88c.firebaseapp.com',
    storageBucket: 'dglai-5f88c.firebasestorage.app',
    measurementId: 'G-T07YZ2YT50',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBDvtJtF121kWXMM9sz1r06lrmVPn_UWQY',
    appId: '1:977500695929:android:4fd81f9306f500953e53a8',
    messagingSenderId: '977500695929',
    projectId: 'dglai-5f88c',
    storageBucket: 'dglai-5f88c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwbjQ-Q90N7x2_OibX0VC1nnSWebL9A68',
    appId: '1:977500695929:ios:80434123386413d83e53a8',
    messagingSenderId: '977500695929',
    projectId: 'dglai-5f88c',
    storageBucket: 'dglai-5f88c.firebasestorage.app',
    iosBundleId: 'com.example.dglAi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCwbjQ-Q90N7x2_OibX0VC1nnSWebL9A68',
    appId: '1:977500695929:ios:80434123386413d83e53a8',
    messagingSenderId: '977500695929',
    projectId: 'dglai-5f88c',
    storageBucket: 'dglai-5f88c.firebasestorage.app',
    iosBundleId: 'com.example.dglAi',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyACO06kzwi9GOubGowjLdyGgpLLygXpR6Y',
    appId: '1:977500695929:web:88cfba56cb8c55d73e53a8',
    messagingSenderId: '977500695929',
    projectId: 'dglai-5f88c',
    authDomain: 'dglai-5f88c.firebaseapp.com',
    storageBucket: 'dglai-5f88c.firebasestorage.app',
    measurementId: 'G-P8GZPY6R0T',
  );

}