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

  /// 5:20
  String toLocalTimeFromUtc() {
    try {
      DateTime localTime = DateFormat('HH:mm:ss').parse(this, true).toLocal();
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
      return dateTime.toString();
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

  DateTime? toLocaleFromUtc() {
    try {
      DateTime now = DateTime.now();
      DateTime localTime = DateFormat('HH:mm:ss').parse(this, true).toLocal();
      debugPrint('localTime=====================${localTime}');
      debugPrint('this=====================$this');
      DateTime setTimeOfDay = DateTime(now.year, now.month, now.day, localTime.hour, localTime.minute);
      debugPrint('setTimeOfDay=====================$setTimeOfDay');

      return setTimeOfDay;
    } catch (e) {
      Logger().d("Exception on toLocaleFromStringUtc : $e");
    }
    return null;
  }

  ///December 21, 2023
  String? toDisplayDateWithMonth() {
    try {
      DateTime localTime = DateFormat('yyyy-mm-dd').parse(this, true).toLocal();
      String date = DateFormat.yMMMMd().format(localTime);
      return date;
    } catch (e) {
      Logger().d("Exception on toLocaleFromStringUtc : $e");
    }
    return null;
  }
}
