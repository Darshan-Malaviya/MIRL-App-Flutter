import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

enum CallHistoryEnum { instantCall, multipleConnect, appointment }

enum CallHistoryStatusExpertEnum { complete, incomplete}

enum CallHistoryUserStatusEnum { complete, incomplete , refund, supportTicket }

extension CallHistoryStatusExpertExtension on CallHistoryStatusExpertEnum {
  Color get callHistoryExpertStatusColor {
    switch (this) {
      case CallHistoryStatusExpertEnum.complete:
        return ColorConstants.greenColor;
      case CallHistoryStatusExpertEnum.incomplete:
        return ColorConstants.disableColor;
    }
  }

  String get callHistoryExpertStatusText {
    switch (this) {
      case CallHistoryStatusExpertEnum.complete:
        return LocaleKeys.complete.tr();
      case CallHistoryStatusExpertEnum.incomplete:
        return LocaleKeys.incomplete.tr();
    }
  }
}

extension CallHistoryStatusUserExtension on CallHistoryUserStatusEnum {
   Color get callHistoryUserStatusColor {
    switch (this) {
      case CallHistoryUserStatusEnum.complete:
        return ColorConstants.greenColor;
      case CallHistoryUserStatusEnum.incomplete:
        return ColorConstants.disableColor;
      case CallHistoryUserStatusEnum.refund:
        return ColorConstants.greenColor;
      case CallHistoryUserStatusEnum.supportTicket:
        return ColorConstants.disableColor;
    }
  }

   String get callHistoryUserStatusText {
     switch (this) {
       case CallHistoryUserStatusEnum.complete:
         return LocaleKeys.completeUser.tr();
       case CallHistoryUserStatusEnum.incomplete:
         return LocaleKeys.incompleteUser.tr();
       case CallHistoryUserStatusEnum.refund:
         return LocaleKeys.refund.tr();
       case CallHistoryUserStatusEnum.supportTicket:
         return LocaleKeys.supportTicket.tr();
     }
   }
}



extension CallHistoryExtensionFromString on String {
  String get getCallHistoryFromString {
    switch (this) {
      case '1':
        return LocaleKeys.instantCall.tr().toUpperCase();
      case '2':
        return LocaleKeys.multipleConnect.tr().toUpperCase();
      case '3':
        return LocaleKeys.appointment.tr().toUpperCase();
      default:
        return LocaleKeys.instantCall.tr().toUpperCase();
    }
  }

  Color get getCallHistoryColorFromString {
    switch (this) {
      case '1':
        return ColorConstants.greenColor;
      case '2':
        return ColorConstants.callRequestColor;
      case '3':
        return ColorConstants.sliderColor;
      default:
        return ColorConstants.greenColor;
    }
  }


}


extension CallHistoryStatusEnumFromString on String {
  ///3,4,5 incomplete and 6 complete
  CallHistoryStatusExpertEnum get callHistoryStatusExpertFromString {
    switch (this) {
      case '1':
        return CallHistoryStatusExpertEnum.incomplete;
      case '2':
        return CallHistoryStatusExpertEnum.incomplete;
      case '3':
        return CallHistoryStatusExpertEnum.incomplete;
      case '4':
        return CallHistoryStatusExpertEnum.incomplete;
      case '5':
        return CallHistoryStatusExpertEnum.incomplete;
      case '6':
        return CallHistoryStatusExpertEnum.complete;
      default:
        return CallHistoryStatusExpertEnum.incomplete;
    }
  }
}

extension CallHistoryStatusUserEnumFromString on String {
  ///3,4,5 incomplete and 6 complete
  CallHistoryUserStatusEnum get callHistoryStatusUserFromString {
    switch (this) {
      case '1':
        return CallHistoryUserStatusEnum.incomplete;
      case '2':
        return CallHistoryUserStatusEnum.incomplete;
      case '3':
        return CallHistoryUserStatusEnum.incomplete;
      case '4':
        return CallHistoryUserStatusEnum.incomplete;
      case '5':
        return CallHistoryUserStatusEnum.incomplete;
      case '6':
        return CallHistoryUserStatusEnum.complete;
      default:
        return CallHistoryUserStatusEnum.incomplete;
    }
  }
}

