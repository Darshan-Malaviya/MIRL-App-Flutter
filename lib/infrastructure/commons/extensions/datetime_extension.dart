import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// convert date and time form timestamp
extension DateTimeFormatter on String {
  /// 01/06/2023
  String toDateFormat() {
    try {
      DateTime timeStamp = DateTime.parse(this);
      var output = DateFormat('dd/MM/yyyy').format(timeStamp);
      return output;
    } catch (e) {
      Logger().d("Exception occurred on toDateFormat : $e");
    }
    return '';
  }

  /// 01/06/2023 12:15 PM
  String toDateTimeFormat() {
    try {
      DateTime timeStamp = DateTime.parse(this);
      var output = DateFormat('dd/MM/yyyy hh:mm a').format(timeStamp);
      return output;
    } catch (e) {
      Logger().d("Exception occurred on toDateTimeFormat : $e");
    }
    return '';
  }

  ///14:00
  String to24HourTimeFormat() {
    try {
      DateTime timeStamp = DateTime.parse(this);
      var output = DateFormat('HH:mm').format(timeStamp);
      return output;
    } catch (e) {
      Logger().d("Exception occurred on to24HourTimeFormat : $e");
    }
    return '';
  }

  /// 10:10 AM
  String to12HourTimeFormat() {
    try {
      DateTime timeStamp = DateTime.parse(this).toLocal();
      var output = DateFormat('hh:mm a').format(timeStamp);
      return output;
    } catch (e) {
      Logger().d("Exception occurred on to12HourTimeFormat : $e");
    }
    return '';
  }

  /// 5:20 from UTC
  String toLocalTimeFromUtc() {
    try {
      DateTime localTime = DateTime.parse(this).toLocal();
      var output = DateFormat('hh:mm a').format(localTime);
      return output;
    } catch (e) {
      Logger().d("Exception occurred on toLocalTimeFromUtc : $e");
    }
    return '';
  }

  /// UTC time format
  String toUTCDateTimeFormat() {
    try {
      int intValue = int.parse(this);
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(intValue, isUtc: true);
      return dateTime.toIso8601String();
    } catch (e) {
      Logger().d("Exception occurred on toUTCDateTimeFormat : $e");
    }
    return '';
  }

  /// Local time format -  01/06/2023 12:15 PM
  /// required this UTC format to convert local
  /// 2023-04-27 04:31:00.000Z
  String toLocalDateTimeFormat() {
    try {
      DateTime dateTime = DateTime.parse(this);
      DateTime timeStamp = dateTime.toLocal();
      var output = DateFormat('dd/MM/yyyy hh:mm a').format(timeStamp);
      return output;
    } catch (e) {
      Logger().d("Exception occurred on toLocalDateTimeFormat : $e");
    }
    return '';
  }

  /// local date from Utc 2024-04-01 03:30:00.000
  DateTime? toLocaleFromUtcStart() {
    try {
      DateTime now = DateTime.now();
      DateTime localTime = DateTime.parse(this).toLocal();
      DateTime setTimeOfDay = DateTime(now.year, now.month, now.day, localTime.hour, localTime.minute);
      return setTimeOfDay;
    } catch (e) {
      Logger().d("Exception on toLocaleFromUtcStart : $e");
    }
    return null;
  }

  /// local date from Utc 2024-04-01 03:30:00.000
  DateTime? toLocaleFromUtcForEnd(String startTime) {
    try {
      DateTime now = DateTime.now();
      DateTime endLocalTime = DateTime.parse(this).toLocal();
      DateTime startLocalTime = DateTime.parse(startTime).toLocal();
      String value1 = DateFormat('h:mm').format(endLocalTime);
      String value2 = DateFormat('h:mm').format(startLocalTime);
      if (value1 == value2) {
        DateTime setTimeOfDay = DateTime(now.year, now.month, now.day + 1, endLocalTime.hour, endLocalTime.minute);
        return setTimeOfDay;
      } else {
        DateTime setTimeOfDay = DateTime(now.year, now.month, now.day, endLocalTime.hour, endLocalTime.minute);
        return setTimeOfDay;
      }
    } catch (e) {
      Logger().d("Exception on toLocaleFromUtcForEnd : $e");
    }
    return null;
  }

  ///December 21, 2023
  String? toDisplayDateWithMonth() {
    try {
      DateTime localTime = DateTime.parse(this).toLocal();
      String date = DateFormat('MMMM d, yyyy').format(localTime);
      return date;
    } catch (e) {
      Logger().d("Exception on toLocaleFromStringUtc : $e");
    }
    return null;
  }

  /// local date 2024-2-21
  String? toLocalDate() {
    try {
      DateTime localTime = DateFormat('yyyy-MM-dd').parse(this, true).toLocal();
      return DateFormat('yyyy-MM-dd').format(localTime);
    } catch (e) {
      Logger().d("Exception on toLocalDate : $e");
    }
    return null;
  }

  /// 15TH NOVEMBER 2023
  String? toLocalFullDateWithSuffix() {
    try {
      DateTime localTime = DateTime.parse(this).toLocal();
      String formattedDate = DateFormat('d MMMM yyyy').format(localTime);
      formattedDate = formattedDate.replaceFirstMapped(RegExp(r'\b(\d{1,2})\b'), (match) => '${match.group(1)}${getDaySuffix(int.parse(match.group(1)!))}');

      String finalDate = '$formattedDate';
      return finalDate.toUpperCase();
    } catch (e) {
      Logger().d("Exception on toLocalFullDateWithSuffix : $e");
    }
    return null;
  }

  /// 15 NOVEMBER 2023
  String? toLocalFullDateWithoutSuffix() {
    try {
      DateTime localTime = DateTime.parse(this).toLocal();
      String formattedDate = DateFormat('dd MMMM yyyy').format(localTime);
      return formattedDate;
    } catch (e) {
      Logger().d("Exception on toLocalFullDateWithoutSuffix : $e");
    }
    return null;
  }

  /// nov 26 2023
  String? toLocalEarningDate() {
    try {
      DateTime localTime = DateTime.parse(this).toLocal();
      String formattedDate = DateFormat(' MMM dd yyyy').format(localTime);
      return formattedDate;
    } catch (e) {
      Logger().d("Exception on toLocalEarningDate : $e");
    }
    return null;
  }

/* String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);
    final years = difference.inDays ~/ 365;
    print((difference.inDays - (years * 365)) ~/ 30);

    if ((difference.inDays / 7).floor() >= 5) {
      return '5w';
    } else if ((difference.inDays / 7).floor() >= 4) {
      return '4w';
    } else if ((difference.inDays / 7).floor() >= 3) {
      return '3w';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '2w';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return '1w';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hr ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hr ago' : 'An hr ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} mins ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 mins ago' : 'A mins ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} sec ago';
    } else {
      return 'Just now';
    }
  }*/
}
//DateTime.now().subtract(Duration(days:1)),

String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'TH';
  }
  switch (day % 10) {
    case 1:
      return 'ST';
    case 2:
      return 'ND';
    case 3:
      return 'RD';
    default:
      return 'TH';
  }
}
