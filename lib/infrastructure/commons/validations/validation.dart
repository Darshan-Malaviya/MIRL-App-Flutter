import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boilerplate_may_2023/generated/locale_keys.g.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';

String? emptyStringValidation({String? value, String? msg, int? stringLength}) {
  if (value?.isEmpty ?? false) {
    return msg;
  }
  if ((value?.length ?? 0) > (stringLength ?? 40)) {
    return "Maximum ${stringLength.toString()} characters allowed";
  }
  return null;
}

String? emptyDigitValidation({String? value, String? msg, int? stringLength}) {
  if (value?.isEmpty ?? false) {
    return msg;
  }
  if ((value?.length ?? 0) > (stringLength ?? 40)) {
    return "Maximum ${stringLength.toString()} digits allowed";
  }
  return null;
}

String? emailValidation(String? value) {
  if (value?.isEmpty ?? false) {
    return LocaleKeys.requiredEmail.tr();
  } else if (!EmailValidator.validate(value ?? '')) {
    return LocaleKeys.emailIsNotInProperFormat.tr();
  }
  return null;
}

String? mobileNumberValidation({String? value}) {
  if (value?.isEmpty ?? false) {
    return LocaleKeys.requiredPhoneNumber.tr();
  }
  if ((value?.length ?? 0) < 7) {
    return LocaleKeys.phonePhoneIsNotValid.tr();
  }
  if ((value?.length ?? 0) > 12) {
    return LocaleKeys.phonePhoneIsNotValid.tr();
  }
  return null;
}

String? passwordValidation(String? value) {
  if (value?.isEmpty ?? false) {
    return LocaleKeys.requiredPassword.tr();
  } else if (!RegExp(RegexConstants.passwordRegex).hasMatch(value ?? '')) {
    return LocaleKeys.requiredPasswordInPattern.tr();
  }
  return null;
}

String? newPasswordValidation(String? value) {
  if (value?.isEmpty ?? false) {
    return LocaleKeys.requiredNewPassword.tr();
  } else if (!RegExp(RegexConstants.passwordRegex).hasMatch(value ?? '')) {
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

String? linkValidation(String? value, String? msg) {
  if (value?.isEmpty ?? false) {
    return msg;
  } else if (!RegExp(RegexConstants.link).hasMatch(value ?? '')) {
    return msg;
  }
  return null;
}
