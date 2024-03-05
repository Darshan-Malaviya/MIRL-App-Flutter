import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

enum CallHistoryEnum { instantCall, multipleConnect, appointment }

enum CallHistoryStatusEnum { complete, incomplete }

extension CallHistoryTypeEnumExtension on CallHistoryEnum {
  Color get callHistoryTypeNameColor {
    switch (this) {
      case CallHistoryEnum.instantCall:
        return ColorConstants.greenColor;
      case CallHistoryEnum.multipleConnect:
        return ColorConstants.callRequestColor;
      case CallHistoryEnum.appointment:
        return ColorConstants.sliderColor;
    }
  }

  String get callHistoryTypeName {
    switch (this) {
      case CallHistoryEnum.instantCall:
        return LocaleKeys.instantCall.tr().toUpperCase();
      case CallHistoryEnum.multipleConnect:
        return LocaleKeys.multipleConnect.tr();
      case CallHistoryEnum.appointment:
        return LocaleKeys.appointment.tr();
    }
  }
}

extension CallHistoryStatusEnumExtension on CallHistoryStatusEnum {
  Color get callHistoryStatusColor {
    switch (this) {
      case CallHistoryStatusEnum.complete:
        return ColorConstants.greenColor;
      case CallHistoryStatusEnum.incomplete:
        return ColorConstants.disableColor;
    }
  }
}
