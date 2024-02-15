import 'package:mirl/infrastructure/commons/constants/string_constants.dart';

enum WeekDayEnum { mon, tue, wed, thu, fri, sat, sun }

extension WeekDayExtension on String {
  String get weekDayString {
    int index = WeekDayEnum.values.indexWhere((element) => element.name == this);
    return switch (WeekDayEnum.values[index]) {
      WeekDayEnum.mon => StringConstants.monday,
      WeekDayEnum.tue => StringConstants.tuesday,
      WeekDayEnum.wed => StringConstants.wednesday,
      WeekDayEnum.thu => StringConstants.thursday,
      WeekDayEnum.fri => StringConstants.friday,
      WeekDayEnum.sat => StringConstants.saturday,
      WeekDayEnum.sun => StringConstants.sunday,
    };
  }
}
