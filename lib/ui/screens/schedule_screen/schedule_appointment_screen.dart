import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/providers/schedule_call_provider.dart';

class ScheduleAppointmentScreen extends ConsumerStatefulWidget {
  const ScheduleAppointmentScreen({super.key});

  @override
  ConsumerState createState() => _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState extends ConsumerState<ScheduleAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    final scheduleWatch = ref.watch(scheduleCallProvider);
    final scheduleRead = ref.read(scheduleCallProvider);

    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: Stack(
        children: [
          NetworkImageWidget(
            imageURL: scheduleWatch.expertData?.expertProfile ?? '',
            isNetworkImage: true,
            boxFit: BoxFit.cover,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 0.86,
            builder: (BuildContext context, myScrollController) {
              return bottomSheetView(scheduleWatch);
            },
          ),
        ],
      ),
    );
  }

  Widget bottomSheetView(ScheduleCallProvider scheduleWatch) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        color: ColorConstants.whiteColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeadlineMediumText(
              title: scheduleWatch.expertData?.expertName ?? '',
              fontSize: 30,
              titleColor: ColorConstants.bottomTextColor,
            ),
            22.0.spaceY,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    BodySmallText(
                      title: LocaleKeys.overAllRating.tr(),
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleTextAlign: TextAlign.center,
                    ),
                    10.0.spaceX,
                    HeadlineMediumText(
                      fontSize: 30,
                      title: '-',
                      titleColor: ColorConstants.overallRatingColor,
                      shadow: [Shadow(offset: Offset(0, 3), blurRadius: 4, color: ColorConstants.blackColor.withOpacity(0.3))],
                    ),
                  ],
                ),
                Row(
                  children: [
                    BodySmallText(
                      title: LocaleKeys.feesPerMinute.tr(),
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleTextAlign: TextAlign.center,
                    ),
                    10.0.spaceX,
                    HeadlineMediumText(
                      fontSize: 30,
                      title: '\$${((scheduleWatch.expertData?.fee ?? 0) / 100).toString()}',
                      titleColor: ColorConstants.overallRatingColor,
                      shadow: [Shadow(offset: Offset(0, 3), blurRadius: 4, color: ColorConstants.blackColor.withOpacity(0.3))],
                    ),
                  ],
                ),
              ],
            ),
            20.0.spaceY,
            BodyMediumText(
              title: LocaleKeys.scheduleAppointment.tr(),
              fontSize: 15,
              titleColor: ColorConstants.blueColor,
            ),
            20.0.spaceY,
            PrimaryButton(
              height: 45,
              width: 148,
              title: '${scheduleWatch.callDuration} ${LocaleKeys.minutes.tr()}',
              onPressed: () {},
              buttonColor: ColorConstants.buttonColor,
            ),
            20.0.spaceY,
            PrimaryButton(
              height: 45,
              title: '${scheduleWatch.selectedSlotData?.startTimeUTC?.to12HourTimeFormat() ?? ''},${scheduleWatch.selectedSlotData?.startTimeUTC?.toDisplayDateWithMonth()}',
              margin: EdgeInsets.symmetric(horizontal: 40),
              onPressed: () {},
              buttonColor: ColorConstants.buttonColor,
            ),
            20.0.spaceY,
            PrimaryButton(
              height: 55,
              title: 'PAY \$${scheduleWatch.totalPayAmount}',
              margin: EdgeInsets.symmetric(horizontal: 10),
              fontSize: 18,
              onPressed: () {
                ref.read(scheduleCallProvider).scheduleAppointmentApiCall(context: context);
              },
            ),
            10.0.spaceY,
            BodyMediumText(
              title: '${LocaleKeys.scheduleDescription.tr()} ${scheduleWatch.expertData?.userName ?? ''}',
              fontFamily: FontWeightEnum.w500.toInter,
              titleColor: ColorConstants.buttonTextColor,
              titleTextAlign: TextAlign.center,
            )
          ],
        ),
      ).addAllPadding(28),
    );
  }
}
