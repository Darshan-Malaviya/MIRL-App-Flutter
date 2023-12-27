import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static firebaseOptionConfig({String? appId, String? iosBundleId, String? iosClientId}) {
    if (Platform.isIOS || Platform.isMacOS) {
      return FirebaseOptions(
          appId: appId ?? '1:123033805966:ios:ec61db6b22f44a9a3215df',
          apiKey: 'AIzaSyDBFE3NSVbLC5BycJbik0EW5RsI1QAU8ZE',
          projectId: 'mirlcom',
          messagingSenderId: '123033805966',
          // GCM sender id in google service-info.plist file
          iosBundleId: iosBundleId,
          iosClientId: iosClientId ?? "123033805966-32ie9m2baveh8f0me1v09gn0uf127m56.apps.googleusercontent.com");
    } else {
      /// android
      return const FirebaseOptions(
        appId: '1:123033805966:android:51f1eedb6fc9d9873215df',
        apiKey: 'AIzaSyD2FIgsSBYlfSRexuwpZ0-q8zvPDTbCdN8',
        projectId: 'mirlcom',
        messagingSenderId: '123033805966', // this is project number in google-service.json file
      );
    }
  }
}
