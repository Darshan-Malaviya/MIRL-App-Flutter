import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';

enum CallTypeEnum { callRequest, requestWaiting, requestApproved, requestDeclined, requestTimeout, receiverRequested,
  multiCallRequest, multiRequestWaiting, multiRequestApproved, multiRequestDeclined, multiRequestTimeout, multiReceiverRequested,
}

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

      case CallTypeEnum.multiCallRequest:
        return ColorConstants.callRequestColor;
      case CallTypeEnum.multiRequestWaiting:
        return ColorConstants.yellowButtonColor;
      case CallTypeEnum.multiRequestApproved:
        return ColorConstants.greenColor;
      case CallTypeEnum.multiRequestDeclined:
        return ColorConstants.redColor;
      case CallTypeEnum.multiRequestTimeout:
        return ColorConstants.sliderColor;
      case CallTypeEnum.multiReceiverRequested:
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

      case CallTypeEnum.multiCallRequest:
        return LocaleKeys.confirmMultiCall.tr();
      case CallTypeEnum.multiRequestWaiting:
        return LocaleKeys.multiCallWaiting.tr();
      case CallTypeEnum.multiRequestApproved:
        return LocaleKeys.multiCallApprove.tr();
      case CallTypeEnum.multiRequestDeclined:
        return LocaleKeys.multiCallDecline.tr();
      case CallTypeEnum.multiRequestTimeout:
        return LocaleKeys.multiCallTimeOut.tr();
      case CallTypeEnum.multiReceiverRequested:
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

      case CallTypeEnum.multiCallRequest:
        return LocaleKeys.goBack.tr().toUpperCase();
      case CallTypeEnum.multiRequestWaiting:
        return LocaleKeys.cancel.tr().toUpperCase();
      case CallTypeEnum.multiRequestApproved:
        return LocaleKeys.confirmExpert.tr().toUpperCase();
      case CallTypeEnum.multiRequestDeclined:
        return LocaleKeys.goBack.tr().toUpperCase();
      case CallTypeEnum.multiRequestTimeout:
        return LocaleKeys.goBack.tr().toUpperCase();
      case CallTypeEnum.multiReceiverRequested:
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

      case CallTypeEnum.multiCallRequest:
        return LocaleKeys.confirm.tr().toUpperCase();
      case CallTypeEnum.multiRequestWaiting:
        return '';
      case CallTypeEnum.multiRequestApproved:
        return '';
      case CallTypeEnum.multiRequestDeclined:
        return '';
      case CallTypeEnum.multiRequestTimeout:
        return LocaleKeys.tryAgain.tr().toUpperCase();

      case CallTypeEnum.multiReceiverRequested:
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

      case CallTypeEnum.multiCallRequest:
        return LocaleKeys.areYouReady.tr().toUpperCase();
        case CallTypeEnum.multiRequestWaiting:
        return LocaleKeys.multiConnectRequest.tr().toUpperCase();
      case CallTypeEnum.multiRequestApproved:
        return LocaleKeys.areYouReady.tr().toUpperCase();
      case CallTypeEnum.multiRequestDeclined:
        return LocaleKeys.multiConnectRequest.tr().toUpperCase();
      case CallTypeEnum.multiRequestTimeout:
        return LocaleKeys.multiConnectRequest.tr().toUpperCase();
      case CallTypeEnum.multiReceiverRequested:
        return LocaleKeys.multiConnectRequest.tr().toUpperCase();

      default:
        return LocaleKeys.instantCallRequest.tr().toUpperCase();
    }
  }

}
