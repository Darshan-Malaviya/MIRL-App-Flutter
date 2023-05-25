//-1.0 means not parsed
import 'dart:developer';

double parseDoubleValue(var value) {
  try {
    if (value is String) {
      if (value.isNotEmpty) {
        return double.parse(value);
      }
    }
    if (value is int) {
      return value + 0.0;
    }
    if (value is double) {
      return value;
    }
  } catch (e) {
    log(e.toString());
  }
  return -1.0;
}

//-1 means not parsed
int parseIntValue(var value) {
  try {
    if (value is String) {
      if (value.isNotEmpty) {
        return int.parse(value);
      }
    }
    if (value is double) {
      return value.toInt();
    }
    if (value is int) {
      return value;
    }
  } catch (e) {
    log(e.toString());
  }
  return -1;
}
