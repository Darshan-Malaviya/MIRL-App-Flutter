import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

enum NotificationTypeEnum { connectAndroidCall, autoLogout, blocked, appointmentConfirmed, appointmentCancelled }

extension NotificationTypeExtension on String {

  Color get statusToColor {
    NotificationTypeEnum selectedType = NotificationTypeEnum.values.firstWhere((e) => e.name == this);
    switch (selectedType) {
      case NotificationTypeEnum.appointmentConfirmed:
        return ColorConstants.lemonYellowColor;
      case NotificationTypeEnum.appointmentCancelled:
        return ColorConstants.lemonYellowColor;
      default:
        return ColorConstants.lemonYellowColor;
    }
  }
}
