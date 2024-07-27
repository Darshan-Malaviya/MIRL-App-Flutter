import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/table_calender_widget/table_border.dart';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month, 1);
final kLastDay = DateTime(kToday.year, kToday.month + 2, 0); // End of the next month

class TableCalenderRangeWidget extends StatefulWidget {
  final Function(DateTime selectedDay, DateTime focusedDay) onDateSelected;
  final DateTime? selectedDay;
  final List<String>? scheduleDateList;
  final bool fromUpcomingAppointment;

  TableCalenderRangeWidget({
    super.key,
    required this.onDateSelected,
    required this.selectedDay,
    this.scheduleDateList,
    required this.fromUpcomingAppointment,
  });

  @override
  _TableCalenderRangeWidgetState createState() => _TableCalenderRangeWidgetState();
}

class _TableCalenderRangeWidgetState extends State<TableCalenderRangeWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDay;
    _focusedDay = widget.selectedDay ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        if (widget.fromUpcomingAppointment) {
          for (var element in widget.scheduleDateList ?? []) {
            if (day.toString().toLocalDate() == element) {
              return true;
            }
          }
        } else {
          return isSameDay(_selectedDay, day);
        }
        return false;
      },
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
        defaultTextStyle: TextStyle(
          fontFamily: FontWeightEnum.w400.toInter,
          fontSize: 12,
          color: ColorConstants.buttonTextColor,
        ),
        disabledTextStyle: TextStyle(
          fontFamily: FontWeightEnum.w400.toInter,
          fontSize: 12,
          color: ColorConstants.disableColor,
        ),
        weekendTextStyle: TextStyle(
          fontFamily: FontWeightEnum.w400.toInter,
          fontSize: 12,
          color: ColorConstants.buttonTextColor,
        ),
        outsideTextStyle: TextStyle(
          color: Color(0xFFBFBFBF),
        ),
      ),
      onCalendarCreated: (pageController) {
        _pageController = pageController;
      },
      headerStyle: HeaderStyle(
        rightChevronVisible: false,
        leftChevronVisible: false,
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          if (widget.fromUpcomingAppointment) {
            if (!(widget.scheduleDateList?.contains(day.toString().toLocalDate()) ?? false)) {
              return Center(
                child: BodySmallText(
                  title: day.day.toString(),
                  titleColor: Color(0xFFBFBFBF),
                  fontFamily: FontWeightEnum.w400.toInter,
                ),
              );
            }
          }
          return null;
        },
        outsideBuilder: (context, day, focusedDay) {
          return Center(
            child: BodySmallText(
              title: day.day.toString(),
              titleColor: Color(0xFFBFBFBF),
              fontFamily: FontWeightEnum.w400.toInter,
            ),
          );
        },
        headerTitleBuilder: (context, day) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  ),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: ColorConstants.yellowButtonColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: ColorConstants.dropDownBorderColor),
                    ),
                    child: Center(
                      child: BodySmallText(
                        title: DateFormat.MMMM()
                            .format(DateTime(day.year, day.month - 1, 1))
                            .toUpperCase(),
                        titleColor: ColorConstants.buttonTextColor,
                      ),
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
                  child: BodySmallText(
                    title: DateFormat.MMMM().format(day).toUpperCase(),
                    titleColor: ColorConstants.buttonTextColor,
                  ),
                ),
              ),
              5.0.spaceX,
              Expanded(
                child: InkWell(
                  onTap: () => _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  ),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: ColorConstants.yellowButtonColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: ColorConstants.dropDownBorderColor),
                    ),
                    child: Center(
                      child: BodySmallText(
                        title: DateFormat.MMMM()
                            .format(DateTime(day.year, day.month + 1, 1))
                            .toUpperCase(),
                        titleColor: ColorConstants.buttonTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        selectedBuilder: (context, day, event) {
          if (widget.scheduleDateList != null && (day.day == widget.selectedDay?.day)) {
            return Center(
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: ColorConstants.primaryColor.withOpacity(0.3),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.disableColor,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Center(
                  child: BodySmallText(
                    title: day.day.toString(),
                    titleColor: ColorConstants.buttonTextColor,
                    fontFamily: FontWeightEnum.w400.toInter,
                  ),
                ),
              ),
            );
          }
          return Center(
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: ColorConstants.yellowButtonColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.disableColor,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Center(
                child: BodySmallText(
                  title: day.day.toString(),
                  titleColor: ColorConstants.buttonTextColor,
                  fontFamily: FontWeightEnum.w400.toInter,
                ),
              ),
            ),
          );
        },
        todayBuilder: (context, day, focusedDay) {
          if (widget.fromUpcomingAppointment) {
            if (!(widget.scheduleDateList?.contains(day.day) ?? false)) {
              return Center(
                child: BodySmallText(
                  title: day.day.toString(),
                  titleColor: Color(0xFFBFBFBF),
                  fontFamily: FontWeightEnum.w400.toInter,
                ),
              );
            }
          }
          return Center(
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor.withOpacity(0.5),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.disableColor,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Center(
                child: BodySmallText(
                  title: day.day.toString(),
                  titleColor: ColorConstants.buttonTextColor,
                  fontFamily: FontWeightEnum.w400.toInter,
                ),
              ),
            ),
          );
        },
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
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          );
        },
        rangeStartBuilder: (context, day, focusedDay) {
          return rangeTextContainer(
            day: day,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          );
        },
      ),
      calendarFormat: _calendarFormat,
      daysOfWeekHeight: 50,
      startingDayOfWeek: StartingDayOfWeek.monday,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: ColorConstants.buttonTextColor,
          fontFamily: FontWeightEnum.w700.toInter,
          fontSize: 12,
        ),
        weekendStyle: TextStyle(
          color: ColorConstants.buttonTextColor,
          fontFamily: FontWeightEnum.w700.toInter,
          fontSize: 12,
        ),
        dowTextFormatter: (date, locale) {
          return DateFormat.E(locale).format(date).toUpperCase();
        },
      ),
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            _rangeStart = null;
            _rangeEnd = null;
            _rangeSelectionMode = RangeSelectionMode.toggledOff;
          });
        }
        widget.onDateSelected(selectedDay, focusedDay);
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
      child: Center(
        child: BodySmallText(
          title: day.day.toString(),
          titleColor: ColorConstants.buttonTextColor,
          fontFamily: FontWeightEnum.w400.toInter,
        ),
      ),
    );
  }
}
