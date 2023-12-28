import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/validations/email_validator.dart';

extension ValidationExtension on String {
  String? toEmptyStringValidation({String? msg}) {
    if (trim().isEmpty) {
      return msg;
    }
    return null;
  }

  // String? toConfPasswordValidation(String password, String confPassword) {
  //   if (password.trim() != confPassword.trim()) {
  //     return StringConstants.passwordDoesNotMatch;
  //   }
  //   return null;
  // }
  //
  // String? toPasswordValidation() {
  //   if (trim().isEmpty) {
  //     return StringConstants.requiredPassword;
  //   } else if (!RegExp(RegexConstants.passwordRegex).hasMatch(this)) {
  //     return StringConstants.requiredPasswordInPattern;
  //   }
  //   return null;
  // }

  String? toEmailValidation() {
    if (trim().isEmpty) {
      return StringConstants.requiredEmail;
    } else if (!EmailValidator.validate(this)) {
      return StringConstants.emailIsNotInProperFormat;
    }
    return null;
  }

// String? toValidateAmount(int value) {
//   if (trim().isEmpty) {
//     return StringConstants.requiredAmount;
//   } else if (int.parse(this) > value) {
//     return StringConstants.validateAmount;
//   }
//   return null;
// }
//
// String? toValidateAFSCCode() {
//   if (trim().isEmpty) {
//     return StringConstants.requiredRoutingNumber;
//   } else if (!RegExp(RegexConstants.afscCodeRegex).hasMatch(this)) {
//     return StringConstants.validateAFSCCode;
//   }
//   return null;
// }

/*  String? nameLengthValidation({String? msg, int minLength = 0, maxLength = 0}) {
    if (trim().isEmpty) {
      return msg;
    }
    if (trim().length < minLength || trim().length > maxLength) {
      return '${LocaleKeys.minimumLength.tr()} $minLength ${LocaleKeys.characterAndMaximum.tr()} $maxLength ${LocaleKeys.characterAreAllowed.tr()}';
    }
    return null;
  }

  String? notesValidation() {
    if (trim().length > 200) {
      return LocaleKeys.maximumCharacterAllowed.tr();
    }
    return null;
  }

  String? emptyDigitValidation({String? msg, int? stringLength}) {
    if (trim().isEmpty) {
      return msg;
    }
    if ((trim().length) > (stringLength ?? 40)) {
      return "Maximum ${stringLength.toString()} digits allowed";
    }
    return null;
  }

  String? emailValidation() {
    if (trim().isEmpty) {
      return LocaleKeys.requiredEmail.tr();
    } else if (!EmailValidator.validate(this)) {
      return LocaleKeys.emailIsNotInProperFormat.tr();
    }
    return null;
  }

  String? mobileNumberValidation() {
    if (trim().isEmpty) {
      return LocaleKeys.requiredPhoneNumber.tr();
    }
    if ((trim().length) < 7) {
      return LocaleKeys.phonePhoneIsNotValid.tr();
    }
    if ((trim().length) > 15) {
      return LocaleKeys.phonePhoneIsNotValid.tr();
    }
    return null;
  }

  String? passwordValidation() {
    if (trim().isEmpty) {
      return LocaleKeys.requiredPassword.tr();
    } else if (!RegExp(RegexConstants.passwordRegex).hasMatch(this)) {
      return LocaleKeys.requiredPasswordInPattern.tr();
    }
    return null;
  }

  String? newPasswordValidation() {
    if (trim().isEmpty) {
      return LocaleKeys.requiredNewPassword.tr();
    } else if (!RegExp(RegexConstants.passwordRegex).hasMatch(this)) {
      return LocaleKeys.requiredPasswordInPattern.tr();
    }
    return null;
  }

  String? confPasswordValidation(String password, String confPassword) {
    if (password.trim() != confPassword.trim()) {
      return LocaleKeys.passwordDoesNotMatch.tr();
    }
    return null;
  }

  String? linkValidation(String? msg) {
    if (trim().isEmpty) {
      return msg;
    } else if (!RegExp(RegexConstants.link).hasMatch(this)) {
      return msg;
    }
    return null;
  }*/
}
