import 'package:logger/logger.dart';

/// convert int to bool
extension IntToBoolFormatter on int {
  /// 0 or 1
  bool toIntToBoolFormat() {
    try {
      switch (this) {
        case 0:
          return false;
        case 1:
          return true;
      }
    } catch (e) {
      Logger().d("Exception occurred on toIntToBoolFormat : $e");
    }
    return false;
  }
}


/// convert String to bool
extension StringToBoolFormatter on String {
  /// 0 or 1
  bool toStringToBoolFormat() {
    try {
      int value = int.parse(this);
      switch (value) {
        case 0:
          return false;
        case 1:
          return true;
      }
    } catch (e) {
      Logger().d("Exception occurred on toStringToBoolFormat : $e");
    }
    return false;
  }
}