import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';

class CommonMethods {
  /// Use to change current focus
  static void changeFocus({FocusNode? currentFocusNode, FocusNode? nexFocusNode}) {
    if (currentFocusNode?.hasFocus == true) {
      currentFocusNode?.unfocus();
      nexFocusNode?.requestFocus();
    } else {
      nexFocusNode?.requestFocus();
    }
  }
}
