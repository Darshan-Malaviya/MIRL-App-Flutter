import 'dart:convert';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mirl/mirl_app.dart';

class LocalNotification {
  static final LocalNotification singleton = LocalNotification._internal();

  factory LocalNotification() {
    return singleton;
  }

  LocalNotification._internal();

  Future localNotificationInitialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@drawable/notification_logo');

    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (response) {
      onSelectNotification(response);
    });
  }

  void onDidReceiveLocalNotification(int? id, String? title, String? body, String? payload) {
    // display a dialog with the notification details, tap ok to go to another page
    log("Received Notification=> id $id,Title $title, Body $body, Payload $payload");
  }

  onSelectNotification(NotificationResponse response) {
    /// TODO Push screen code or open dialog when tap on foreground and background notification
    if (response.payload != null) {
      Map<String, dynamic> payloadData = jsonDecode(response.payload ?? '');
    }
  }
}
