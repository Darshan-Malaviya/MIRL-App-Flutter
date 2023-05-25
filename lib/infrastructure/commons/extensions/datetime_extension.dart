import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
import 'package:logger/logger.dart';

extension DateTimeFormatter on String {
  String toTimeFormat() {
    try {
      DateTime timeStamp = DateTime.parse(this);
      var output = DateFormat('hh:mm a').format(timeStamp);
      return output;
    } catch (e) {
      Logger().d("Exception on timeformat : $e");
    }
    return '';
  }
}
