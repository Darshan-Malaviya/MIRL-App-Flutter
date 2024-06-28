import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

extension ValidationExtension on String {
  String? toEmptyStringValidation({String? msg}) {
    if (trim().isEmpty) {
      return msg;
    }
    return null;
  }

  String? toEmailValidation() {
    if (trim().isEmpty) {
      return LocaleKeys.requiredEmail.tr();
    } else if (!EmailValidator.validate(this)) {
      return LocaleKeys.emailIsNotInProperFormat.tr();
    }
    return null;
  }

  String? toUrlValidation(urlValue) {
    RegExp regex =
    RegExp(r'^https?:\/\/(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z]{2,})+(?:\/[^\s]*)?$');
    var value = urlValue ?? "";
    if (!regex.hasMatch(value)) {
      return LocaleKeys.pleaseEnterValidUrl.tr();
    }
    return null;
  }

  String? toMirlIdValidation(String? msg, String? validatedMsg) {
    if (trim().isEmpty) {
      return msg;
    } else if (this.length < 5) {
      return LocaleKeys.charactersLong.tr();
    } else if(this.length > 15) {
      return LocaleKeys.userNameOverLoaded.tr();
    }
    /*else if (!RegExp(RegexConstants.onlyCharacter).hasMatch(this)) {
      return validatedMsg;
    }*/
    return null;
  }
  String? mobileNumberValidation({String? value}) {
    if (value?.isEmpty ?? false) {
      return LocaleKeys.requiredPhoneNumber.tr();
    }
    if ((value?.length ?? 0) < 7) {
      return LocaleKeys.phonePhoneIsNotValid.tr();
    }
    if ((value?.length ?? 0) > 15) {
      return LocaleKeys.phonePhoneIsNotValid.tr();
    }
    return null;
  }
}
