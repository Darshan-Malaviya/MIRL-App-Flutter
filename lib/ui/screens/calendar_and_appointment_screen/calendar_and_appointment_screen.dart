import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/table_calender_widget/table_calender.dart';
import 'package:table_calendar/table_calendar.dart';

class ViewCalendarAppointment extends ConsumerStatefulWidget {
  const ViewCalendarAppointment({super.key});

  @override
  ConsumerState createState() => _ViewCalendarAppointmentState();
}

class _ViewCalendarAppointmentState extends ConsumerState<ViewCalendarAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TableCalenderRangeWidget(
      onDateSelected: (selectedDay, focusedDay) {
        print(selectedDay);
      },
      selectedDay: DateTime.now(),
      scheduleDateList: [19, 16, 26, 32],
    ));
  }
}
