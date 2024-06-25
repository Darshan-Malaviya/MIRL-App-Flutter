import 'package:logger/logger.dart';

extension TimeDuration on Duration {
  String toTimeString() {
    try {
      final minutes = this.inMinutes.remainder(Duration.minutesPerHour).toString().padLeft(2, '0');
      final seconds = this.inSeconds.remainder(Duration.secondsPerMinute).toString().padLeft(2, '0');
      return "$minutes:$seconds";
    } catch (e) {
      Logger().d("Exception on toTimeString : $e");
    }
    return '';
  }
}
