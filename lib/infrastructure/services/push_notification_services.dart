import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/extra_service_model.dart';
import 'package:mirl/infrastructure/services/call_kit_service.dart';
import 'package:mirl/mirl_app.dart';
import 'package:uuid/uuid.dart';

class PushNotificationService {
  static final PushNotificationService singleton = PushNotificationService._internal();

  factory PushNotificationService() {
    return singleton;
  }

  PushNotificationService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> setupFlutterNotifications() async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await getFirebaseToken();
  }

  Future initialise() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    /// TODO For handling notification when the app is in terminated state
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
      log('TS Message title: ${message?.notification?.title}, body: ${message?.notification?.body}, data: ${message?.data}');
      onMessageOpened(message);
    });

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
        try {
          log('Message: ========${message?.notification?.title}, body: ${message?.notification?.body}, data: ${message?.data}');

          RemoteNotification? notification = message?.notification;
          AndroidNotification? android = message?.notification?.android;

          if (message?.data['key'] == NotificationTypeEnum.connectAndroidCall.name) {
            ExtraResponseModel extraResponseModel = ExtraResponseModel.fromJson(message?.data ?? {});
             showCallkitIncoming(uuid: const Uuid().v4().toString(), extraResponseModel: extraResponseModel);
          } else if (message?.data['key'] == NotificationTypeEnum.autoLogout.name) {
            CommonMethods.autoLogout();
          } else {
            if (notification != null && android != null) {
              flutterLocalNotificationsPlugin.show(
                  notification.hashCode,
                  notification.title,
                  notification.body,
                  const NotificationDetails(
                      android: AndroidNotificationDetails("high_importance_channel", "High Importance Notifications",
                          channelDescription: "This channel is used for important notifications.", importance: Importance.max, icon: "@drawable/notification_logo"),
                      iOS: DarwinNotificationDetails(presentSound: true)),
                  payload: jsonEncode(message?.data));
            }
          }
        } catch (e) {
          log('FireBase onMessage.lister Exception: $e');
        }
      });
    } else {
      log('User declined or has not accepted notification permission');
    }

    /// TODO For handling notification when the app is in background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      log('BS Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');
      onMessageOpened(message);
    });
  }

  void onMessageOpened(RemoteMessage? message) {
    if (message?.data != null) {}
  }

  Future getFirebaseToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    SharedPrefHelper.saveFirebaseToken(token);
  }
}
