import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static firebaseOptionConfig({String? appId, String? iosBundleId, String? iosClientId}) {
    if (Platform.isIOS || Platform.isMacOS) {
      return FirebaseOptions(
        appId: appId ?? '1:391725947281:ios:01254a31cd1f6490f22230',
        apiKey: 'AIzaSyAPROb4xiRmyU9DiLMDNPNAF4PwozRbMRo',
        projectId: 'mindscape-34e1c',
        messagingSenderId: '391725947281',
        // GCM sender id in google service-info.plist file
        iosBundleId: iosBundleId,
        iosClientId: iosClientId ?? "391725947281-ioho8b7pgkofonctaqtst19m1amm6j62.apps.googleusercontent.com"
      );
    } else {
      /// android
      return const FirebaseOptions(
        appId: '1:391725947281:android:50706c87d0c11b3af22230',
        apiKey: 'AIzaSyDVS2YMBwI3JVmGVm8hmNqsCDBSuEmBxcg',
        projectId: 'mindscape-34e1c',
        messagingSenderId: '391725947281', // this is project number in google-service.json file
      );
    }
  }
}
