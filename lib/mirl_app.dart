import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/enums/notification_color_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/services/local_notification.dart';
import 'package:mirl/infrastructure/services/push_notification_services.dart';

late StateProvider<FlavorConfig> flavorConfigProvider;

FlavorConfig? flavorConfig;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  log('Back Message: ${message?.notification?.title}, body: ${message?.notification?.body}, data: ${message?.data}');
  if (message?.data['key'] == NotificationTypeEnum.autoLogout.name) {
    CommonMethods.autoLogout();
  }
}

class MirlApp {
  static initializeApp(FlavorConfig flavorConfig) async {
    await WidgetsFlutterBinding.ensureInitialized();
    await SharedPrefHelper.init();
    await AppPathProvider.initPath();
    await EasyLocalization.ensureInitialized();
    flavorConfigProvider = StateProvider<FlavorConfig>((ref) => flavorConfig);

    await Firebase.initializeApp(options: DefaultFirebaseOptions.firebaseOptionConfig(appId: flavorConfig.appIdForIOS, iosBundleId: flavorConfig.iosBundleId));

    await PushNotificationService.singleton.setupFlutterNotifications();
    await PushNotificationService.singleton.initialise();
    LocalNotification.singleton.localNotificationInitialize();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }
}
