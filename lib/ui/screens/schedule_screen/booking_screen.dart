import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/upcoming_appointment_response_model.dart';
import 'package:mirl/infrastructure/providers/schedule_call_provider.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';

class BookingConfirmScreen extends ConsumerStatefulWidget {
  const BookingConfirmScreen({super.key});

  @override
  ConsumerState createState() => _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends ConsumerState<BookingConfirmScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(scheduleCallProvider).getTimeZone();
      // ref.read(scheduleCallProvider).convertCurrentToUtc("Asia/Kolkata");
    });
  }

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
          CustomScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                stretch: true,
                backgroundColor: ColorConstants.whiteColor,
                pinned: true,
                surfaceTintColor: ColorConstants.whiteColor,
                expandedHeight: 400.0,
                leading: SizedBox.shrink(),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [StretchMode.zoomBackground],
                  expandedTitleScale: 1.1,
                  collapseMode: CollapseMode.pin,
                  title: Container(
                    padding: EdgeInsets.only(top: 18, bottom: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConstants.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: HeadlineMediumText(
                      title: LocaleKeys.bookingConfirm.tr(),
                      fontSize: 30,
                      titleColor: ColorConstants.bottomTextColor,
                      titleTextAlign: TextAlign.center,
                      maxLine: 2,
                    ),
                  ),
                  titlePadding: EdgeInsets.zero,
                  background: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: NetworkImageWidget(
                      imageURL: scheduleWatch.appointmentData?.expertDetail?.expertProfile ?? '',
                      isNetworkImage: true,
                      boxFit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child:    SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      BodyLargeText(
                        title: '${LocaleKeys.bookingDescription.tr()} ${scheduleWatch.appointmentData?.expertDetail?.expertName?.toUpperCase() ?? ''}.',
                        titleColor: ColorConstants.blueColor,
                        fontFamily: FontWeightEnum.w400.toInter,
                        maxLine: 5,
                        titleTextAlign: TextAlign.center,
                      ),
                      26.0.spaceY,
                      BodyLargeText(
                        title: LocaleKeys.bookingDetail.tr(),
                        fontSize: 15,
                        titleColor: ColorConstants.blueColor,
                      ),
                      30.0.spaceY,
                      ShadowContainer(
                        shadowColor: Color(0x33000000),
                        offset: Offset(0, 2),
                        border: 5,
                        height: 45,
                        padding: EdgeInsets.zero,
                        width: MediaQuery.of(context).size.width,
                        backgroundColor: ColorConstants.buttonColor,
                        child: Center(
                          child: BodyMediumText(
                            title: scheduleWatch.appointmentData?.date?.toDisplayDateWithMonth() ?? '',
                            fontSize: 15,
                            titleColor: ColorConstants.buttonTextColor,
                          ),
                        ),
                      ),
                      30.0.spaceY,
                      ShadowContainer(
                        shadowColor: Color(0x33000000),
                        offset: Offset(0, 2),
                        border: 5,
                        height: 85,
                        padding: EdgeInsets.zero,
                        width: MediaQuery.of(context).size.width,
                        backgroundColor: ColorConstants.buttonColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BodySmallText(
                              title:
                              '${scheduleWatch.appointmentData?.startTime?.to24HourTimeFormatLocal().toLowerCase() ?? ''} - ${scheduleWatch.appointmentData?.endTime?.to24HourTimeFormatLocal().toLowerCase() ?? ''}',
                              fontSize: 13,
                              titleColor: ColorConstants.buttonTextColor,
                            ),
                            8.0.spaceY,
                            BodySmallText(
                              title: '${LocaleKeys.duration.tr()}: ${(scheduleWatch.appointmentData?.duration ?? 0) ~/ 60 } ${LocaleKeys.minutes.tr()}',
                              fontSize: 13,
                              titleColor: ColorConstants.buttonTextColor,
                            ),
                          ],
                        ),
                      ),
                      20.0.spaceY,
                      LabelSmallText(
                        title: '${LocaleKeys.yourTimeZone.tr()}: ${scheduleWatch.userLocalTimeZone}',
                        titleColor: ColorConstants.blueColor,
                        fontFamily: FontWeightEnum.w400.toInter,
                      ),
                      if (scheduleWatch.appointmentData?.expertTimezone?.isNotEmpty ?? false) ...[
                        10.0.spaceY,
                        LabelSmallText(
                          //title: '${LocaleKeys.expertTimeZone.tr()}: CENTRAL TIME (UTC -6:00)',
                          title: '${LocaleKeys.expertTimeZone.tr()}: ${scheduleWatch.expertUtcDateTime ?? ''}',
                          titleColor: ColorConstants.blueColor,
                          fontFamily: FontWeightEnum.w400.toInter,
                        ),
                      ],
                      30.0.spaceY,
                      PrimaryButton(
                        title: LocaleKeys.checkNotification.tr(),
                        onPressed: () => context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 2),
                        buttonColor: ColorConstants.yellowButtonColor,
                        fontSize: 15,
                      ),
                      20.0.spaceY,
                      PrimaryButton(
                        title: LocaleKeys.cancelBooking.tr(),
                        onPressed: () {
                          context.toPushNamed(
                            RoutesConstants.canceledAppointmentOptionScreen,
                            args: CancelArgs(
                                appointmentData: GetUpcomingAppointment(
                                  id: scheduleWatch.appointmentData?.id,
                                  expertId: scheduleWatch.appointmentData?.expertDetail?.id,
                                  userId: int.parse(SharedPrefHelper.getUserId),
                                  startTime: scheduleWatch.appointmentData?.startTime,
                                  endTime: scheduleWatch.appointmentData?.endTime,
                                  duration: scheduleWatch.appointmentData?.duration.toString(),
                                  date: scheduleWatch.appointmentData?.date,
                                ),
                                role: 1,
                                fromScheduled: true),
                          );
                        },
                        buttonColor: ColorConstants.yellowButtonColor,
                        fontSize: 15,
                      ),
                      20.0.spaceY,
                    ],
                  ),
                ).addAllPadding(28),
              )
            ],
          )
          // DraggableScrollableSheet(
          //   initialChildSize: 0.6,
          //   minChildSize: 0.6,
          //   maxChildSize: 0.86,
          //   builder: (BuildContext context, myScrollController) {
          //     return bottomSheetView(scheduleWatch, myScrollController);
          //   },
          // ),
        ],
      ),
    );
  }

  Widget bottomSheetView(ScheduleCallProvider scheduleWatch, ScrollController controller) {
    return
      Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        color: ColorConstants.whiteColor,
      ),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeadlineMediumText(
              title: LocaleKeys.bookingConfirm.tr(),
              fontSize: 30,
              titleColor: ColorConstants.bottomTextColor,
            ),
            22.0.spaceY,
            BodyLargeText(
              title: '${LocaleKeys.bookingDescription.tr()} ${scheduleWatch.appointmentData?.expertDetail?.expertName?.toUpperCase() ?? ''}.',
              titleColor: ColorConstants.blueColor,
              fontFamily: FontWeightEnum.w400.toInter,
              maxLine: 5,
              titleTextAlign: TextAlign.center,
            ),
            26.0.spaceY,
            BodyLargeText(
              title: LocaleKeys.bookingDetail.tr(),
              fontSize: 15,
              titleColor: ColorConstants.blueColor,
            ),
            30.0.spaceY,
            ShadowContainer(
              shadowColor: Color(0x33000000),
              offset: Offset(0, 2),
              border: 5,
              height: 45,
              padding: EdgeInsets.zero,
              width: MediaQuery.of(context).size.width,
              backgroundColor: ColorConstants.buttonColor,
              child: Center(
                child: BodyMediumText(
                  title: scheduleWatch.appointmentData?.date?.toDisplayDateWithMonth() ?? '',
                  fontSize: 15,
                  titleColor: ColorConstants.buttonTextColor,
                ),
              ),
            ),
            30.0.spaceY,
            ShadowContainer(
              shadowColor: Color(0x33000000),
              offset: Offset(0, 2),
              border: 5,
              height: 85,
              padding: EdgeInsets.zero,
              width: MediaQuery.of(context).size.width,
              backgroundColor: ColorConstants.buttonColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BodySmallText(
                    title:
                        '${scheduleWatch.appointmentData?.startTime?.to24HourTimeFormatLocal().toLowerCase() ?? ''} - ${scheduleWatch.appointmentData?.endTime?.to24HourTimeFormatLocal().toLowerCase() ?? ''}',
                    fontSize: 13,
                    titleColor: ColorConstants.buttonTextColor,
                  ),
                  8.0.spaceY,
                  BodySmallText(
                    title: '${LocaleKeys.duration.tr()}: ${(scheduleWatch.appointmentData?.duration ?? 0) ~/ 60 } ${LocaleKeys.minutes.tr()}',
                    fontSize: 13,
                    titleColor: ColorConstants.buttonTextColor,
                  ),
                ],
              ),
            ),
            20.0.spaceY,
            LabelSmallText(
              title: '${LocaleKeys.yourTimeZone.tr()}: ${scheduleWatch.userLocalTimeZone}',
              titleColor: ColorConstants.blueColor,
              fontFamily: FontWeightEnum.w400.toInter,
            ),
            if (scheduleWatch.appointmentData?.expertTimezone?.isNotEmpty ?? false) ...[
              10.0.spaceY,
              LabelSmallText(
                //title: '${LocaleKeys.expertTimeZone.tr()}: CENTRAL TIME (UTC -6:00)',
                title: '${LocaleKeys.expertTimeZone.tr()}: ${scheduleWatch.appointmentData?.expertTimezone ?? ''}',
                titleColor: ColorConstants.blueColor,
                fontFamily: FontWeightEnum.w400.toInter,
              ),
            ],
            30.0.spaceY,
            PrimaryButton(
              title: LocaleKeys.checkNotification.tr(),
              onPressed: () => context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 2),
              buttonColor: ColorConstants.yellowButtonColor,
              fontSize: 15,
            ),
            20.0.spaceY,
            PrimaryButton(
              title: LocaleKeys.cancelBooking.tr(),
              onPressed: () {
                context.toPushNamed(
                  RoutesConstants.canceledAppointmentOptionScreen,
                  args: CancelArgs(
                      appointmentData: GetUpcomingAppointment(
                        id: scheduleWatch.appointmentData?.id,
                        expertId: scheduleWatch.appointmentData?.expertDetail?.id,
                        userId: int.parse(SharedPrefHelper.getUserId),
                        startTime: scheduleWatch.appointmentData?.startTime,
                        endTime: scheduleWatch.appointmentData?.endTime,
                        duration: scheduleWatch.appointmentData?.duration.toString(),
                        date: scheduleWatch.appointmentData?.date,
                      ),
                      role: 1,
                      fromScheduled: true),
                );
              },
              buttonColor: ColorConstants.yellowButtonColor,
              fontSize: 15,
            ),
            20.0.spaceY,
          ],
        ),
      ).addAllPadding(28),
    );
  }
}
