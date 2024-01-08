import 'package:flutter_timezone/flutter_timezone.dart';

class CommonMethods {
  /// get current time zone
  static Future<String> getCurrentTimeZone() async {
    return await FlutterTimezone.getLocalTimezone();
  }
}
