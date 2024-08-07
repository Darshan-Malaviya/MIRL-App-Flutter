import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_status_enum.dart';

extension StringFormating on String {
  String toCapitalizeAllWord() {
    var result = this[0].toUpperCase();
    for (int i = 1; i < length; i++) {
      if (this[i - 1] == " ") {
        result = result + this[i].toUpperCase();
      } else {
        result = result + this[i];
      }
    }
    return result;
  }

  String numberToCallRequestStatus() {
    switch (this) {
      case "1":
        return CallRequestStatusEnum.waiting.name;
      case '2':
        return CallRequestStatusEnum.accept.name;
      case "3":
        return CallRequestStatusEnum.decline.name;
      case '4':
        return CallRequestStatusEnum.timeout.name;
      case "5":
        return CallRequestStatusEnum.cancel.name;
      case "6":
        return CallRequestStatusEnum.choose.name;
      case '7':
        return CallRequestStatusEnum.notChoose.name;
      default:
        return '';
    }

  }

  Color numberToCallRequestStatusColor() {
    switch (this) {
      case "1":
        return ColorConstants.yellowButtonColor;
      case "2":
        return ColorConstants.greenDarkColor;
      case "3":
        return ColorConstants.callsPausedColor;
      case "4":
        return ColorConstants.callsPausedColor;
      case "5":
        return ColorConstants.callsPausedColor;
      case "6":
        return ColorConstants.greenDarkColor;
      case "7":
        return ColorConstants.callsPausedColor;
      default:
        return ColorConstants.whiteColor;
    }
  }


  Color numberToCallRequestStatusBGColor() {
    switch (this) {
      case "1":
        return ColorConstants.whiteColor;
      case "2":
        return ColorConstants.whiteColor;
      case "3":
        return ColorConstants.redMediumColor;
      case "4":
        return ColorConstants.redMediumColor;
      case "5":
        return ColorConstants.redMediumColor;
      case "6":
        return ColorConstants.yellowMediumColor;
      case "7":
        return ColorConstants.whiteColor;
      default:
        return ColorConstants.whiteColor;
    }
  }

  String  callRequestStatusToString() {
    switch (this) {
      case "1":
        return LocaleKeys.waiting.tr();
      case "2":
        return LocaleKeys.callMe.tr();
      case "3":
        return LocaleKeys.declined.tr();
      case "4":
        return LocaleKeys.noResponse.tr();
      case "5":
        return LocaleKeys.noResponse.tr();
      case "6":
        return LocaleKeys.chosen.tr();
      case "7":
        return LocaleKeys.notChosen.tr();
      default:
        return LocaleKeys.noResponse.tr();
    }
  }
}
