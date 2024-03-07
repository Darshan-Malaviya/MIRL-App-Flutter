import 'dart:convert';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mirl/infrastructure/commons/enums/notification_color_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/notification_data_model.dart';
import 'package:mirl/infrastructure/models/response/cancel_appointment_response_model.dart';
import 'package:mirl/mirl_app.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';

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

      NotificationData notificationData = NotificationData.fromJson(payloadData);
      if (notificationData.key == NotificationTypeEnum.appointmentConfirmed.name) {
        NavigationService.context.toPushNamed(RoutesConstants.viewCalendarAppointment,
            args: AppointmentArgs(role: int.parse(notificationData.role.toString()), fromNotification: true, selectedDate: notificationData.date));
      } else if (notificationData.key == NotificationTypeEnum.appointmentCancelled.name) {
        NotificationData notificationData = NotificationData.fromJsonCanceled(payloadData);
        NavigationService.context.toPushNamed(RoutesConstants.canceledNotificationScreen,
            args: CancelArgs(
              role: int.parse(notificationData.role.toString()),
              cancelDate: notificationData.date,
              cancelData: CancelAppointmentData(
                startTime: notificationData.startTime,
                endTime: notificationData.endTime,
                duration: int.parse(notificationData.duration ?? '0'),
                name: notificationData.name,
                profileImage: notificationData.profile,
              ),
            ));
      }
    }
  }
}
