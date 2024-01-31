extension TimeDuration on Duration {
  String toHHmmss() {
    var microseconds = inMicroseconds;

    var hours = microseconds ~/ Duration.microsecondsPerHour;
    microseconds = microseconds.remainder(Duration.microsecondsPerHour);

    if (microseconds < 0) microseconds = -microseconds;

    var minutes = microseconds ~/ Duration.microsecondsPerMinute;
    microseconds = microseconds.remainder(Duration.microsecondsPerMinute);

    var minutesPadding = minutes < 10 ? "0" : "";

    var seconds = microseconds ~/ Duration.microsecondsPerSecond;
    microseconds = microseconds.remainder(Duration.microsecondsPerSecond);

    var secondsPadding = seconds < 10 ? "0" : "";

    String value = ' ${this.inMinutes.remainder(60).toString()}:${(this.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';
    return value;

/*    return "$hours:"
        "$minutesPadding$minutes";*/
  }
}
