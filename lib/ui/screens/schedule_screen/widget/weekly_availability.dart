import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/ui/common/shimmer_widgets/available_time_shimmer.dart';
import 'package:mirl/ui/common/table_calender_widget/table_calender.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/providers/schedule_call_provider.dart';
import 'package:mirl/ui/common/button_widget/fees_action_button.dart';
import 'package:pinput/pinput.dart';

import '../../../common/shimmer_widgets/slots_shimmer_widget.dart';

class WeeklyAvailability extends ConsumerStatefulWidget {
  const WeeklyAvailability({super.key});

  @override
  ConsumerState createState() => _WeeklyAvailabilityState();
}

class _WeeklyAvailabilityState extends ConsumerState<WeeklyAvailability> {
  @override
  Widget build(BuildContext context) {
    final scheduleProviderWatch = ref.watch(scheduleCallProvider);
    final scheduleProviderRead = ref.read(scheduleCallProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TitleMediumText(title: LocaleKeys.weeklyAvailability.tr(), fontSize: 18, titleColor: ColorConstants.bottomTextColor),
        27.0.spaceY,
        scheduleProviderWatch.isLoadingAvailable
            ? AvailableTimeShimmer().addPaddingX(20)
            : Column(
                children: List.generate(scheduleProviderWatch.weekAvailability.length, (index) {
                  final data = scheduleProviderWatch.weekAvailability[index];
                  return slotWidget(
                          dayText: data.dayOfWeek?.toUpperCase() ?? '', dayTimeText: '${data.startTime?.toLocalTimeFromUtc() ?? ''} - ${data.endTime?.toLocalTimeFromUtc() ?? ''}')
                      .addPaddingY(12);
                }),
              ).addPaddingX(20),
        40.0.spaceY,
        Image.asset(ImageConstants.line),
        20.0.spaceY,
        TitleSmallText(
          title: LocaleKeys.pickDateAndTime.tr(),
          titleTextAlign: TextAlign.center,
          titleColor: ColorConstants.bottomTextColor,
        ),
        22.0.spaceY,
        TableCalenderRangeWidget(
          onDateSelected: (selectedDay, focusedDay) {
            scheduleProviderRead.getSelectedDate(selectedDay);
            print(selectedDay);
          },
          selectedDay: scheduleProviderWatch.selectedDate,
          fromUpcomingAppointment: false,
        ),
        22.0.spaceY,
        BodyMediumText(
          title: LocaleKeys.durationOfAppointment.tr(),
          fontSize: 15,
          titleColor: ColorConstants.blueColor,
        ),
        16.0.spaceY,
        durationWidget(scheduleProviderWatch),
        10.0.spaceY,
        BodySmallText(title: '${LocaleKeys.maxCallDuration.tr()} 30 ${LocaleKeys.minutes.tr()}', fontFamily: FontWeightEnum.w500.toInter),
        23.0.spaceY,
        generateSlotTime(scheduleProviderWatch),
        11.0.spaceY,
        PrimaryButton(
          height: 55,
          title: LocaleKeys.scheduleAppointment.tr(),
          onPressed: () async {
            if (scheduleProviderWatch.selectedSlotData != null) {
              scheduleProviderRead.getPayValue();
              final result = await context.toPushNamed(RoutesConstants.scheduleAppointmentScreen);
              if (result == 'callApi') {
                scheduleProviderRead.getSlotsApi();
              }
            } else {
              FlutterToast().showToast(msg: LocaleKeys.pleaseSelectSlot.tr());
            }
          },
          fontSize: 15,
          titleColor: ColorConstants.blueColor,
        ).addPaddingXY(paddingX: 29, paddingY: 12),
      ],
    );
  }

  Widget slotWidget({required String dayText, required String dayTimeText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: 120,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: ColorConstants.yellowButtonColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: ColorConstants.dropDownBorderColor),
            ),
            child: Center(
              child: BodySmallText(
                title: dayText,
                titleColor: ColorConstants.buttonTextColor,
                /*      shadows: [
                  Shadow(
                    blurRadius: 8.0,
                    offset: Offset(0,3),
                    color: ColorConstants.blackColor.withOpacity(0.3),
                  )
                ],*/
              ),
            )),
        20.0.spaceX,
        Expanded(
          child: Container(
              width: 200,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorConstants.dropDownBorderColor),
                /*         boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                  BoxShadow(
                    color: ColorConstants.blackColor.withOpacity(0.3),
                    spreadRadius: 0.0,
                    blurRadius: 4.0,
                    offset: Offset(0, 0),
                  ),
                ],*/
              ),
              child: Center(
                child: BodySmallText(
                  title: dayTimeText,
                  fontFamily: FontWeightEnum.w600.toInter,
                  titleColor: ColorConstants.blackColor,
                ),
              )),
        ),
      ],
    );
  }

  Widget durationWidget(ScheduleCallProvider scheduleCallProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FeesActionButtonWidget(
          onTap: () => scheduleCallProvider.decrementCallDuration(),
          icons: ImageConstants.minus,
          isDisable: scheduleCallProvider.callDuration == 10,
        ),
        20.0.spaceX,
        PrimaryButton(
          height: 45,
          width: 148,
          title: '${scheduleCallProvider.callDuration} ${LocaleKeys.minutes.tr()}',
          onPressed: () {},
          buttonColor: ColorConstants.buttonColor,
        ),
        20.0.spaceX,
        FeesActionButtonWidget(
          onTap: () => scheduleCallProvider.incrementCallDuration(),
          icons: ImageConstants.plus,
          isDisable: scheduleCallProvider.callDuration == 30,
        ),
      ],
    );
  }

  Widget generateSlotTime(ScheduleCallProvider scheduleCallWatch) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 70),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
              ),
              BoxShadow(
                color: ColorConstants.lightPurpleColor,
                spreadRadius: 0.0,
                blurRadius: 4.0,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: scheduleCallWatch.isLoadingSlot
              ? SlotsShimmer()
              : scheduleCallWatch.slotList.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemCount: scheduleCallWatch.slotList.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemBuilder: (BuildContext context, int index) {
                        final data = scheduleCallWatch.slotList[index];
                        return OnScaleTap(
                          onPress: () {
                            ref.read(scheduleCallProvider).getSelectedSlotData(data, index);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: data.isSelected == true ? ColorConstants.primaryColor : ColorConstants.transparentColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                ),
                                BoxShadow(
                                  color: ColorConstants.buttonColor,
                                  spreadRadius: 0.0,
                                  blurRadius: 4.0,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                TitleSmallText(
                                  title: index.toString(),
                                  fontSize: 15,
                                ),
                                TitleSmallText(
                                  title: data.startTimeUTC?.to12HourTimeFormat() ?? '',
                                  fontSize: 15,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => 20.0.spaceX,
                    )
                  : Center(
                      child: BodyMediumText(
                        title: LocaleKeys.noSlotAvailable.tr(),
                        titleColor: ColorConstants.primaryColor,
                      ),
                    ),
        )
      ],
    );
  }
}
