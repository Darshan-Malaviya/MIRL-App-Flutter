import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/demo_file.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/providers/schedule_call_provider.dart';
import 'package:mirl/ui/common/button_widget/fees_action_button.dart';

class WeeklyAvailability extends ConsumerStatefulWidget {
  const WeeklyAvailability({super.key});

  @override
  ConsumerState createState() => _WeeklyAvailabilityState();
}

class _WeeklyAvailabilityState extends ConsumerState<WeeklyAvailability> {
  @override
  Widget build(BuildContext context) {
    final scheduleProviderWatch = ref.watch(scheduleCallProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TitleMediumText(
            title: LocaleKeys.weeklyAvailability.tr(),
            fontSize: 18,
            fontWeight: FontWeight.w700,
            titleColor: ColorConstants.bottomTextColor),
        27.0.spaceY,
        ListView.builder(
            itemCount: scheduleProviderWatch.weekAvailability.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => slotWidget(
                    dayText: scheduleProviderWatch.weekAvailability[index].weekDay,
                    dayTimeText: scheduleProviderWatch.weekAvailability[index].dayTime)
                .addPaddingY(12)).addPaddingX(15),
        40.0.spaceY,
        Image.asset(ImageConstants.line),
        40.0.spaceY,
        TitleSmallText(
          title: LocaleKeys.pickDateAndTime.tr(),
          titleTextAlign: TextAlign.center,
          titleColor: ColorConstants.bottomTextColor,
        ),
        22.0.spaceY,
        TableRangeExample(),
        22.0.spaceY,
        BodyMediumText(
          title: LocaleKeys.durationOfAppointment.tr(),
          fontSize: 15,
          fontWeight: FontWeight.w700,
          titleColor: ColorConstants.blueColor,
        ),
        21.0.spaceY,
        durationWidget(scheduleProviderWatch),
        10.0.spaceY,
        TitleSmallText(title: LocaleKeys.maxCallDuration.tr()),
        23.0.spaceY,
        setTimeWidget(),
        11.0.spaceY,
        PrimaryButton(
          title: LocaleKeys.scheduleAppointment.tr(),
          onPressed: () {},
          titleColor: ColorConstants.blueColor,
        ).addPaddingXY(paddingX: 29, paddingY: 12),
      ],
    );
  }

  Widget slotWidget({required String dayText, required String dayTimeText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            alignment: Alignment.center,
            height: 25,
            width: 100,
            decoration: BoxDecoration(
              color: ColorConstants.scheduleCallColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: ColorConstants.dropDownBorderColor),
            ),
            child: BodySmallText(
              title: dayText,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            )),
        49.0.spaceX,
        Container(
            alignment: Alignment.center,
            height: 25,
            width: 178,
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorConstants.dropDownBorderColor),
            ),
            child: BodySmallText(
              title: dayTimeText,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            )),
      ],
    );
  }

  Widget durationWidget(ScheduleCallProvider scheduleCallProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FeesActionButtonWidget(
          onTap: () {
            scheduleCallProvider.incrementCallDuration();
          },
          icons: Icons.add,
          isDisable: scheduleCallProvider.callDuration == 30,
        ),
        19.0.spaceX,
        PrimaryButton(
          height: 45,
          width: 148,
          title: '${scheduleCallProvider.callDuration} ${LocaleKeys.minutes.tr()}',
          onPressed: () {},
          buttonColor: ColorConstants.buttonColor,
        ),
        19.0.spaceX,
        FeesActionButtonWidget(
          onTap: () {
            scheduleCallProvider.decrementCallDuration();
          },
          icons: Icons.remove,
          isDisable: scheduleCallProvider.callDuration == 10,
        ),
      ],
    );
  }

  Widget setTimeWidget() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 340,
          height: 122,
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
          height: 90,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => timeContainer().addPaddingX(13),
          ),
        )
      ],
    );
  }

  Widget timeContainer() {
    return Container(
      alignment: Alignment.center,
      width: 164,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
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
      child: TitleSmallText(
        title: '10:30AM',
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
