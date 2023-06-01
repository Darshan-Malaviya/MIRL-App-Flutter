import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
import 'package:flutter/cupertino.dart';

class DatePickerWidget extends StatelessWidget {
  final Function onDateTimeChanged;

  const DatePickerWidget({Key? key, required this.onDateTimeChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: TextStyle(
              color: ColorConstants.primaryColor,
              fontFamily: AppConstants.fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now().add(const Duration(seconds: 1)),
          minimumDate: DateTime.now(),
          maximumDate: DateTime.now().add(const Duration(days: 3650)),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (date) => onDateTimeChanged(date),
        ),
      ),
    );
  }
}

class TimePickerWidget extends StatelessWidget {
  final Function onDateTimeChanged;

  const TimePickerWidget({Key? key, required this.onDateTimeChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: TextStyle(
              color: ColorConstants.primaryColor,
              fontFamily: AppConstants.fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now().add(const Duration(seconds: 1)),
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (date) => onDateTimeChanged(date),
        ),
      ),
    );
  }
}
