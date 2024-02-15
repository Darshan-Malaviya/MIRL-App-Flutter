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
      return 'It should be at least 5 character long';
    } /*else if (!RegExp(RegexConstants.onlyCharacter).hasMatch(this)) {
      return validatedMsg;
    }*/
    return null;
  }
}
