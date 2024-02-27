import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';

enum CallRequestTypeEnum { callRequest, requestWaiting, requestApproved, requestDeclined, requestTimeout, receiverRequested,
  multiCallRequest, multiRequestWaiting, multiRequestApproved, multiRequestDeclined, multiRequestTimeout, multiReceiverRequested,
}

extension CallRequestTypeEnumExtension on CallRequestTypeEnum {
  Color get typeName {
    switch (this) {
      case CallRequestTypeEnum.callRequest:
        return ColorConstants.callRequestColor;
        case CallRequestTypeEnum.requestWaiting:
        return ColorConstants.yellowButtonColor;
      case CallRequestTypeEnum.requestApproved:
        return ColorConstants.greenColor;
      case CallRequestTypeEnum.requestDeclined:
        return ColorConstants.redColor;
      case CallRequestTypeEnum.requestTimeout:
        return ColorConstants.sliderColor;
      case CallRequestTypeEnum.receiverRequested:
        return ColorConstants.greenColor;

      case CallRequestTypeEnum.multiCallRequest:
        return ColorConstants.callRequestColor;
      case CallRequestTypeEnum.multiRequestWaiting:
        return ColorConstants.yellowButtonColor;
      case CallRequestTypeEnum.multiRequestApproved:
        return ColorConstants.greenColor;
      case CallRequestTypeEnum.multiRequestDeclined:
        return ColorConstants.redColor;
      case CallRequestTypeEnum.multiRequestTimeout:
        return ColorConstants.sliderColor;
      case CallRequestTypeEnum.multiReceiverRequested:
        return ColorConstants.callRequestColor;
      default:
        return ColorConstants.callRequestColor;
    }
  }

  String get descriptionName {
    switch (this) {
      case CallRequestTypeEnum.callRequest:
        return LocaleKeys.requestCallDesc.tr();
      case CallRequestTypeEnum.requestWaiting:
        return LocaleKeys.requestWaitingDesc.tr();
      case CallRequestTypeEnum.requestApproved:
        return LocaleKeys.requestApprovedDesc.tr();
      case CallRequestTypeEnum.requestDeclined:
        return LocaleKeys.requestDeclineDesc.tr();
      case CallRequestTypeEnum.requestTimeout:
        return LocaleKeys.requestTimeoutDesc.tr();
      case CallRequestTypeEnum.receiverRequested:
        return LocaleKeys.ringingDesc.tr();

      case CallRequestTypeEnum.multiCallRequest:
        return LocaleKeys.confirmMultiCall.tr();
      case CallRequestTypeEnum.multiRequestWaiting:
        return LocaleKeys.multiCallWaiting.tr();
      case CallRequestTypeEnum.multiRequestApproved:
        return LocaleKeys.multiCallApprove.tr();
      case CallRequestTypeEnum.multiRequestDeclined:
        return LocaleKeys.multiCallDecline.tr();
      case CallRequestTypeEnum.multiRequestTimeout:
        return LocaleKeys.multiCallTimeOut.tr();
      case CallRequestTypeEnum.multiReceiverRequested:
        return LocaleKeys.multiConnectRequestDesc.tr();
      default:
        return LocaleKeys.requestCallDesc.tr();
    }
  }


  String get secondButtonName {
    switch (this) {
      case CallRequestTypeEnum.callRequest:
        return LocaleKeys.goBack.tr().toUpperCase();
      case CallRequestTypeEnum.requestWaiting:
        return LocaleKeys.cancel.tr().toUpperCase();
      case CallRequestTypeEnum.requestApproved:
        return LocaleKeys.continueText.tr().toUpperCase();
      case CallRequestTypeEnum.requestDeclined:
        return LocaleKeys.goBack.tr().toUpperCase();
      case CallRequestTypeEnum.requestTimeout:
        return LocaleKeys.goBack.tr().toUpperCase();
      case CallRequestTypeEnum.receiverRequested:
        return LocaleKeys.sorryBusy.tr().toUpperCase();

      case CallRequestTypeEnum.multiCallRequest:
        return LocaleKeys.goBack.tr().toUpperCase();
      case CallRequestTypeEnum.multiRequestWaiting:
        return LocaleKeys.cancel.tr().toUpperCase();
      case CallRequestTypeEnum.multiRequestApproved:
        return LocaleKeys.confirmExpert.tr().toUpperCase();
      case CallRequestTypeEnum.multiRequestDeclined:
        return LocaleKeys.goBack.tr().toUpperCase();
      case CallRequestTypeEnum.multiRequestTimeout:
        return LocaleKeys.goBack.tr().toUpperCase();
      case CallRequestTypeEnum.multiReceiverRequested:
        return LocaleKeys.sorryBusy.tr().toUpperCase();
      default:
        return LocaleKeys.goBack.tr().toUpperCase();
    }
  }


  String get firstButtonName {
    switch (this) {
      case CallRequestTypeEnum.callRequest:
        return LocaleKeys.requestCall.tr().toUpperCase();
      case CallRequestTypeEnum.requestWaiting:
        return '';
      case CallRequestTypeEnum.requestApproved:
        return '';
      case CallRequestTypeEnum.requestDeclined:
        return '';
      case CallRequestTypeEnum.requestTimeout:
        return LocaleKeys.tryAgain.tr().toUpperCase();
      case CallRequestTypeEnum.receiverRequested:
        return LocaleKeys.yesCallMe.tr().toUpperCase();

      case CallRequestTypeEnum.multiCallRequest:
        return LocaleKeys.confirm.tr().toUpperCase();
      case CallRequestTypeEnum.multiRequestWaiting:
        return '';
      case CallRequestTypeEnum.multiRequestApproved:
        return '';
      case CallRequestTypeEnum.multiRequestDeclined:
        return '';
      case CallRequestTypeEnum.multiRequestTimeout:
        return '';
      case CallRequestTypeEnum.multiReceiverRequested:
        return LocaleKeys.yesCallMe.tr().toUpperCase();
      default:
        return '';
    }
  }

  String get titleName {
    switch (this) {
      case CallRequestTypeEnum.callRequest:
        return LocaleKeys.instantCallRequest.tr().toUpperCase();
      case CallRequestTypeEnum.requestWaiting:
        return LocaleKeys.instantCallRequest.tr().toUpperCase();
      case CallRequestTypeEnum.requestApproved:
        return LocaleKeys.requestApproved.tr().toUpperCase();
      case CallRequestTypeEnum.requestDeclined:
        return LocaleKeys.requestDeclined.tr().toUpperCase();
      case CallRequestTypeEnum.requestTimeout:
        return LocaleKeys.requestTimeOut.tr().toUpperCase();
      case CallRequestTypeEnum.receiverRequested:
        return LocaleKeys.instantCallRequest.tr().toUpperCase();

      case CallRequestTypeEnum.multiCallRequest:
        return LocaleKeys.areYouReady.tr().toUpperCase();
        case CallRequestTypeEnum.multiRequestWaiting:
        return LocaleKeys.multiConnectRequest.tr().toUpperCase();
      case CallRequestTypeEnum.multiRequestApproved:
        return LocaleKeys.multiConnectRequest.tr().toUpperCase();
      case CallRequestTypeEnum.multiRequestDeclined:
        return LocaleKeys.multiConnectRequest.tr().toUpperCase();
      case CallRequestTypeEnum.multiRequestTimeout:
        return LocaleKeys.multiConnectRequest.tr().toUpperCase();
      case CallRequestTypeEnum.multiReceiverRequested:
        return LocaleKeys.multiConnectRequest.tr().toUpperCase();

      default:
        return LocaleKeys.instantCallRequest.tr().toUpperCase();
    }
  }

}
