import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

enum NotificationTypeEnum {
  connectAndroidCall,
  autoLogout,
  blocked,
  appointmentConfirmed,
  appointmentCancelled,
  multipleConnect,
  instantCall,
  multipleConnectTheChosenOne,
  multiConnectRequestUser,
  multiConnectExpertChosenUser,
  multiConnectRequestConfirmUser,
  multiConnectExpertBusyUser,
  appointmentIn1min,
  appointmentIn30min,
  appointmentRemainder,
  multipleConnectRequestExpert,
  noList,
  expertDeclineRequestCall
}

extension NotificationTypeExtension on String {
  Color get statusToColor {
    NotificationTypeEnum selectedType = NotificationTypeEnum.values.firstWhere((e) => e.name == this);
    switch (selectedType) {
      case NotificationTypeEnum.appointmentConfirmed:
        return ColorConstants.yellowButtonColor;
      case NotificationTypeEnum.appointmentCancelled:
        return ColorConstants.yellowButtonColor;
      case NotificationTypeEnum.appointmentIn1min:
        return ColorConstants.yellowButtonColor;
      case NotificationTypeEnum.appointmentRemainder:
        return ColorConstants.yellowButtonColor;
      case NotificationTypeEnum.appointmentIn30min:
        return ColorConstants.yellowButtonColor;

      /// instant call
      case NotificationTypeEnum.instantCall:
        return ColorConstants.requestCallNowColor;
      case NotificationTypeEnum.expertDeclineRequestCall:
        return ColorConstants.requestCallNowColor;

      /// Multi call
      case NotificationTypeEnum.multipleConnect:
        return ColorConstants.callRequestColor;
      case NotificationTypeEnum.multipleConnectTheChosenOne:
        return ColorConstants.callRequestColor;
      case NotificationTypeEnum.multiConnectRequestUser:
        return ColorConstants.callRequestColor;
      case NotificationTypeEnum.multiConnectExpertChosenUser:
        return ColorConstants.callRequestColor;
      case NotificationTypeEnum.multiConnectRequestConfirmUser:
        return ColorConstants.callRequestColor;
      case NotificationTypeEnum.multiConnectExpertBusyUser:
        return ColorConstants.callRequestColor;
      case NotificationTypeEnum.multipleConnectRequestExpert:
        return ColorConstants.callRequestColor;

      case NotificationTypeEnum.noList:
        return ColorConstants.transparentColor;
      default:
        return ColorConstants.lemonYellowColor;
    }
  }
}
