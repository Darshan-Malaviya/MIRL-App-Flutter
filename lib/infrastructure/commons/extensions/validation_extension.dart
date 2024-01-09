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
}
