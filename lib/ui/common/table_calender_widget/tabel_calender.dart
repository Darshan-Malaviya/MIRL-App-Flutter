import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/table_calender_widget/table_border.dart';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class TableCalenderRangeWidget extends StatefulWidget {
  @override
  _TableCalenderRangeWidgetState createState() => _TableCalenderRangeWidgetState();
}

class _TableCalenderRangeWidgetState extends State<TableCalenderRangeWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      availableGestures: AvailableGestures.horizontalSwipe,
      calendarStyle: CalendarStyle(
        tableBorder: TableBorderDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
       ),
        outsideDecoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
        ),
        defaultTextStyle: TextStyle(fontFamily: FontWeightEnum.w700.toInter, fontSize: 14, color: ColorConstants.buttonTextColor),
        disabledTextStyle: TextStyle(fontFamily: FontWeightEnum.w700.toInter, fontSize: 14, color: ColorConstants.disableColor),
        weekendTextStyle: TextStyle(fontFamily: FontWeightEnum.w700.toInter, fontSize: 14, color: ColorConstants.buttonTextColor),
      ),
      headerStyle: HeaderStyle(rightChevronVisible: false, leftChevronVisible: false, formatButtonVisible: false, titleCentered: true),
      calendarBuilders: CalendarBuilders(
        rangeHighlightBuilder: (context, day, isWithinRange) {
          if ((_rangeStart != day && _rangeEnd != day) && isWithinRange) {
            return rangeTextContainer(day: day);
          } else {
            return Container(
              decoration: BoxDecoration(
                color: ColorConstants.transparentColor,
              ),
            );
          }
        },
        rangeEndBuilder: (context, day, focusedDay) {
          return rangeTextContainer(
            day: day,
            borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
          );
        },
        rangeStartBuilder: (context, day, focusedDay) {
          return rangeTextContainer(
            day: day,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
          );
        },
        headerTitleBuilder: (context, day) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: ColorConstants.yellowButtonColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: ColorConstants.dropDownBorderColor),
                  ),
                  child: Center(
                    child: BodyMediumText(
                      title: DateFormat.MMMM().format(DateTime(day.year, day.month - 1, day.day)),
                      fontFamily: FontWeightEnum.w700.toInter,
                      titleColor: ColorConstants.buttonTextColor,
                    ),
                  ),
                ),
              ),
              5.0.spaceX,
              Container(
                height: 60,
                width: 160,
                decoration: BoxDecoration(
                  color: ColorConstants.yellowButtonColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: ColorConstants.dropDownBorderColor),
                ),
                child: Center(
                  child: BodyMediumText(
                    title: DateFormat.MMMM().format(day),
                    fontFamily: FontWeightEnum.w700.toInter,
                    titleColor: ColorConstants.buttonTextColor,
                  ),
                ),
              ),
              5.0.spaceX,
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: ColorConstants.yellowButtonColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: ColorConstants.dropDownBorderColor),
                  ),
                  child: Center(
                    child: BodyMediumText(
                      title: DateFormat.MMMM().format(DateTime(day.year, day.month + 1, day.day)),
                      fontFamily: FontWeightEnum.w700.toInter,
                      titleColor: ColorConstants.buttonTextColor,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        selectedBuilder: (context, day, event) {
          return Center(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: ColorConstants.yellowButtonColor,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: ColorConstants.disableColor, blurRadius: 8)],
              ),
              child: Center(
                child: BodyMediumText(
                  title: day.day.toString(),
                  titleColor: ColorConstants.buttonTextColor,
                  fontFamily: FontWeightEnum.w700.toInter,
                ),
              ),
            ),
          );
        },
        disabledBuilder: (context, day, focusedDay) {
          return Container();
        },
      ),
      calendarFormat: _calendarFormat,
      rangeSelectionMode: _rangeSelectionMode,
      daysOfWeekHeight: 50,
      startingDayOfWeek: StartingDayOfWeek.monday,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w700.toInter, fontSize: 16),
        weekendStyle: TextStyle(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w700.toInter, fontSize: 16),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            _rangeStart = null; // Important to clean those
            _rangeEnd = null;
            _rangeSelectionMode = RangeSelectionMode.toggledOff;
          });
        }
      },
      onRangeSelected: (start, end, focusedDay) {
        setState(() {
          _selectedDay = null;
          _focusedDay = focusedDay;
          _rangeStart = start;
          _rangeEnd = end;
          _rangeSelectionMode = RangeSelectionMode.toggledOn;
        });
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    ).addPaddingX(20);
  }

  Widget rangeTextContainer({required DateTime day, BorderRadius? borderRadius}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: ColorConstants.primaryColor.withOpacity(0.5),
      ),
      child: Center(child: BodyMediumText(title: day.day.toString(), fontFamily: FontWeightEnum.w700.toInter, titleColor: ColorConstants.buttonTextColor)),
    );
  }
}
