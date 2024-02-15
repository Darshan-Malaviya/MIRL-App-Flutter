import 'package:flutter/material.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';

enum CallTypeEnum { callRequest, requestApproved, requestDeclined, requestTimeout, receiverRequested, multiConnectReceiverRequested }

extension CallTypeEnumExtension on CallTypeEnum {
  Color get typeName {
    switch (this) {
      case CallTypeEnum.callRequest:
        return ColorConstants.callRequestColor;
      case CallTypeEnum.requestApproved:
        return ColorConstants.greenColor;
      case CallTypeEnum.requestDeclined:
        return ColorConstants.redColor;
      case CallTypeEnum.requestTimeout:
        return ColorConstants.sliderColor;
      case CallTypeEnum.receiverRequested:
        return ColorConstants.callRequestColor;
      case CallTypeEnum.multiConnectReceiverRequested:
        return ColorConstants.greenColor;
      default:
        return ColorConstants.callRequestColor;
    }
  }
}
