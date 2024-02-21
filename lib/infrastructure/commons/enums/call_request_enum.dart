import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';

enum CallTypeEnum { callRequest, requestWaiting, requestApproved, requestDeclined, requestTimeout, receiverRequested, multiConnectReceiverRequested }

extension CallTypeEnumExtension on CallTypeEnum {
  Color get typeName {
    switch (this) {
      case CallTypeEnum.callRequest:
        return ColorConstants.callRequestColor;
        case CallTypeEnum.requestWaiting:
        return ColorConstants.yellowButtonColor;
      case CallTypeEnum.requestApproved:
        return ColorConstants.greenColor;
      case CallTypeEnum.requestDeclined:
        return ColorConstants.redColor;
      case CallTypeEnum.requestTimeout:
        return ColorConstants.sliderColor;
      case CallTypeEnum.receiverRequested:
        return ColorConstants.greenColor;
      case CallTypeEnum.multiConnectReceiverRequested:
        return ColorConstants.callRequestColor;
      default:
        return ColorConstants.callRequestColor;
    }
  }

  String get descriptionName {
    switch (this) {
      case CallTypeEnum.callRequest:
        return LocaleKeys.requestCallDesc.tr();
      case CallTypeEnum.requestWaiting:
        return LocaleKeys.requestWaitingDesc.tr();
      case CallTypeEnum.requestApproved:
        return LocaleKeys.requestApprovedDesc.tr();
      case CallTypeEnum.requestDeclined:
        return LocaleKeys.requestDeclineDesc.tr();
      case CallTypeEnum.requestTimeout:
        return LocaleKeys.requestTimeoutDesc.tr();
      case CallTypeEnum.receiverRequested:
        return LocaleKeys.ringingDesc.tr();
      case CallTypeEnum.multiConnectReceiverRequested:
        return LocaleKeys.multiConnectRequestDesc.tr();
      default:
        return LocaleKeys.requestCallDesc.tr();
    }
  }


  String get secondButtonName {
    switch (this) {
      case CallTypeEnum.callRequest:
        return LocaleKeys.goBack.tr().toUpperCase();
      case CallTypeEnum.requestWaiting:
        return LocaleKeys.cancel.tr().toUpperCase();
      case CallTypeEnum.requestApproved:
        return LocaleKeys.continueText.tr().toUpperCase();
      case CallTypeEnum.requestDeclined:
        return LocaleKeys.goBack.tr().toUpperCase();
      case CallTypeEnum.requestTimeout:
        return LocaleKeys.goBack.tr().toUpperCase();
      case CallTypeEnum.receiverRequested:
        return LocaleKeys.sorryBusy.tr().toUpperCase();
      case CallTypeEnum.multiConnectReceiverRequested:
        return LocaleKeys.sorryBusy.tr().toUpperCase();
      default:
        return LocaleKeys.goBack.tr().toUpperCase();
    }
  }


  String get firstButtonName {
    switch (this) {
      case CallTypeEnum.callRequest:
        return LocaleKeys.requestCall.tr().toUpperCase();
      case CallTypeEnum.requestWaiting:
        return '';
      case CallTypeEnum.requestApproved:
        return '';
      case CallTypeEnum.requestDeclined:
        return '';
      case CallTypeEnum.requestTimeout:
        return LocaleKeys.tryAgain.tr().toUpperCase();
      case CallTypeEnum.receiverRequested:
        return LocaleKeys.yesCallMe.tr().toUpperCase();
      case CallTypeEnum.multiConnectReceiverRequested:
        return LocaleKeys.yesCallMe.tr().toUpperCase();
      default:
        return '';
    }
  }

  String get titleName {
    switch (this) {
      case CallTypeEnum.callRequest:
        return LocaleKeys.instantCallRequest.tr().toUpperCase();
      case CallTypeEnum.requestWaiting:
        return LocaleKeys.instantCallRequest.tr().toUpperCase();
      case CallTypeEnum.requestApproved:
        return LocaleKeys.requestApproved.tr().toUpperCase();
      case CallTypeEnum.requestDeclined:
        return LocaleKeys.requestDeclined.tr().toUpperCase();
      case CallTypeEnum.requestTimeout:
        return LocaleKeys.requestTimeOut.tr().toUpperCase();
      case CallTypeEnum.receiverRequested:
        return LocaleKeys.instantCallRequest.tr().toUpperCase();
      case CallTypeEnum.multiConnectReceiverRequested:
        return LocaleKeys.instantCallRequest.tr().toUpperCase();
      default:
        return LocaleKeys.instantCallRequest.tr().toUpperCase();
    }
  }

}
