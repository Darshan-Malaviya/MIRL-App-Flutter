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
      return StringConstants.requiredEmail;
    } else if (!EmailValidator.validate(this)) {
      return StringConstants.emailIsNotInProperFormat;
    }
    return null;
  }

  String? toMirlIdValidation(String? msg, String? validatedMsg) {
    if (trim().isEmpty) {
      return msg;
    } else if (this.length < 5) {
      return LocaleKeys.charactersLong.tr();
    } else if(this.length > 15) {
      return 'Username overload! Trim to 15, pretty please?';
    }
    /*else if (!RegExp(RegexConstants.onlyCharacter).hasMatch(this)) {
      return validatedMsg;
    }*/
    return null;
  }
}
