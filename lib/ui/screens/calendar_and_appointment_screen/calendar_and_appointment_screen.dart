import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/table_calender_widget/table_calender.dart';

class ViewCalendarAppointment extends ConsumerStatefulWidget {
  const ViewCalendarAppointment({super.key});

  @override
  ConsumerState createState() => _ViewCalendarAppointmentState();
}

class _ViewCalendarAppointmentState extends ConsumerState<ViewCalendarAppointment> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(viewUpcomingAppointmentProvider).upcomingAppointmentApiCall(context: context, showLoader: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final upcomingWatch = ref.watch(viewUpcomingAppointmentProvider);
    final upcomingRead = ref.read(viewUpcomingAppointmentProvider);

    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleLargeText(
              title: LocaleKeys.calendarAndAppointment.tr(),
              titleColor: ColorConstants.bottomTextColor,
              maxLine: 2,
              fontSize: 20,
              titleTextAlign: TextAlign.center,
            ),
            20.0.spaceY,
            TitleSmallText(
              fontFamily: FontWeightEnum.w400.toInter,
              title: LocaleKeys.checkYourAppComingAppointment.tr(),
              titleTextAlign: TextAlign.center,
              maxLine: 5,
            ),
            20.0.spaceY,
            TableCalenderRangeWidget(
              onDateSelected: (selectedDay, focusedDay) {
                print(selectedDay);
              },
              selectedDay: DateTime.now(),
              scheduleDateList: [19, 16, 26, 32],
            )
          ],
        ),
      ),
    );
  }
}
