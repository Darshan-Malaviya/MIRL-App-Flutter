import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

///1 : waiting (requested)
///2 : accept
/// 3 : decline
/// 4 : time out ( No response)
/// 5 : cancel
/// 6 : choose
/// 7 : not choose

enum CallRequestStatusEnum {
  waiting,
  accept,
  decline,
  timeout,
  cancel,
  choose,
  notChoose,
}

extension CallRequestStatusEnumExtension on CallRequestStatusEnum {
  int get callRequestStatusToNumber {
    switch (this) {
      case CallRequestStatusEnum.waiting:
        return 1;
      case CallRequestStatusEnum.accept:
        return 2;
      case CallRequestStatusEnum.decline:
        return 3;
      case CallRequestStatusEnum.timeout:
        return 4;
      case CallRequestStatusEnum.cancel:
        return 5;
      case CallRequestStatusEnum.choose:
        return 6;
      case CallRequestStatusEnum.notChoose:
        return 7;
      default:
        return 0;
    }
  }

  String get callRequestStatusToString {
    switch (this) {
      case CallRequestStatusEnum.waiting:
        return LocaleKeys.waiting.tr();
      case CallRequestStatusEnum.accept:
        return LocaleKeys.callMe.tr();
      case CallRequestStatusEnum.decline:
        return LocaleKeys.declined.tr();
      case CallRequestStatusEnum.timeout:
        return LocaleKeys.noResponse.tr();
      case CallRequestStatusEnum.cancel:
        return LocaleKeys.noResponse.tr();
      case CallRequestStatusEnum.choose:
        return LocaleKeys.chosen.tr();
      case CallRequestStatusEnum.notChoose:
        return LocaleKeys.notChosen.tr();
      default:
        return '';
    }
  }

  Color get CallReqToCardColor {
    switch (this) {
      case CallRequestStatusEnum.waiting:
        return ColorConstants.whiteColor;
      case CallRequestStatusEnum.accept:
        return ColorConstants.whiteColor;
      case CallRequestStatusEnum.decline:
        return ColorConstants.redMediumColor;
      case CallRequestStatusEnum.cancel:
        return ColorConstants.redMediumColor;
      case CallRequestStatusEnum.timeout:
        return ColorConstants.redMediumColor;
      case CallRequestStatusEnum.choose:
        return ColorConstants.yellowButtonColor;
      case CallRequestStatusEnum.notChoose:
        return ColorConstants.whiteColor;
      default:
        return ColorConstants.whiteColor;
    }
  }

  Color get CallReqToStatusColor {
    switch (this) {
      case CallRequestStatusEnum.waiting:
        return ColorConstants.yellowButtonColor;
      case CallRequestStatusEnum.accept:
        return ColorConstants.greenColor;
      case CallRequestStatusEnum.decline:
        return ColorConstants.callsPausedColor;
      case CallRequestStatusEnum.cancel:
        return ColorConstants.callsPausedColor;
      case CallRequestStatusEnum.timeout:
        return ColorConstants.callsPausedColor;
      case CallRequestStatusEnum.choose:
        return ColorConstants.greenColor;
      case CallRequestStatusEnum.notChoose:
        return ColorConstants.greenColor;
      default:
        return ColorConstants.whiteColor;
    }
  }
}
