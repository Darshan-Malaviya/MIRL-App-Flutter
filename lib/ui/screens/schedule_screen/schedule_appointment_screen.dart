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
            imageURL:
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
              title: 'Preeti Tewari Serai',
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
                      title: StringConstants.overallRatting,
                      fontFamily: FontWeightEnum.w400.toInter,
                    ),
                    4.0.spaceX,
                    HeadlineMediumText(
                      fontSize: 30,
                      title: '0',
                      titleColor: ColorConstants.overallRatingColor,
                    ),
                  ],
                ),
                18.0.spaceY,
                Row(
                  children: [
                    BodySmallText(
                      title: StringConstants.feePer,
                      fontFamily: FontWeightEnum.w400.toInter,
                    ),
                    4.0.spaceX,
                    HeadlineMediumText(
                      fontSize: 30,
                      title: '\$${(int.parse('0') / 100).toString()}',
                      titleColor: ColorConstants.overallRatingColor,
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
              title: '${20} ${LocaleKeys.minutes.tr()}',
              onPressed: () {},
              buttonColor: ColorConstants.buttonColor,
            ),
            20.0.spaceY,
            PrimaryButton(
              height: 45,
              title: '02:15pm, December 21, 2023',
              margin: EdgeInsets.symmetric(horizontal: 40),
              onPressed: () {},
              buttonColor: ColorConstants.buttonColor,
            ),
            20.0.spaceY,
            PrimaryButton(
              height: 55,
              title: 'PAY \$40',
              margin: EdgeInsets.symmetric(horizontal: 10),
              fontSize: 18,
              titleColor: ColorConstants.buttonTextColor,
              onPressed: () {
                context.toPushNamed(RoutesConstants.bookingConfirmScreen);
              },
            ),
            10.0.spaceY,
            BodyMediumText(
              title: '${LocaleKeys.scheduleDescription.tr()} expert name here',
              fontFamily: FontWeightEnum.w500.toInter,
              titleColor: ColorConstants.buttonTextColor,
            )
          ],
        ),
      ).addAllPadding(28),
    );
  }
}
