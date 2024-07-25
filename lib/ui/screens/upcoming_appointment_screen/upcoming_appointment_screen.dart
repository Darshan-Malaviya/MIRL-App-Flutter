import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/upcoming_appointment_response_model.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
import 'package:mirl/ui/common/table_calender_widget/table_calender.dart';

class UpcomingAppointmentScreen extends ConsumerStatefulWidget {
  final AppointmentArgs args;

  const UpcomingAppointmentScreen({super.key, required this.args});

  @override
  ConsumerState createState() => _UpcomingAppointmentScreenState();
}

class _UpcomingAppointmentScreenState extends ConsumerState<UpcomingAppointmentScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(upcomingAppointmentProvider).upcomingAppointmentApiCall(
          showLoader: true, showListLoader: false, role: widget.args.role, fromNotification: widget.args.fromNotification, date: widget.args.selectedDate ?? '');
    });

    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(upcomingAppointmentProvider).reachedLastPage;
        if (!isLoading) {
          ref.read(upcomingAppointmentProvider).upcomingAppointmentApiCall(
              showLoader: false, showListLoader: false, role: widget.args.role, fromNotification: widget.args.fromNotification, date: widget.args.selectedDate ?? '');
        } else {
          log('reach last page on get appointment list api');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final upcomingWatch = ref.watch(upcomingAppointmentProvider);
    final upcomingRead = ref.read(upcomingAppointmentProvider);

    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: upcomingWatch.isLoading ?? false
          ? Center(
              child: CupertinoActivityIndicator(radius: 16, color: ColorConstants.primaryColor),
            )
          : SingleChildScrollView(
              controller: scrollController,
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
                  ).addMarginX(20),
                  20.0.spaceY,
                  TableCalenderRangeWidget(
                    onDateSelected: (selectedDay, focusedDay) {
                      if (upcomingWatch.dateList.contains(selectedDay.toString().toLocalDate())) {
                        upcomingRead.getSelectedDate(selectedDay, widget.args.role);
                      }
                      print(selectedDay);
                    },
                    selectedDay: upcomingWatch.selectedDate,
                    scheduleDateList: upcomingWatch.dateList,
                    fromUpcomingAppointment: true,
                  ),
                  30.0.spaceY,
                  PrimaryButton(
                    title: LocaleKeys.upcomingAppointment.tr(),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    onPressed: () {},
                    titleColor: ColorConstants.buttonTextColor,
                  ),
                  20.0.spaceY,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BodySmallText(
                      title: upcomingWatch.selectedDate != null
                          ? upcomingWatch.selectedDate.toString().toLocalFullDateWithoutSuffix() ?? ''
                          : upcomingWatch.dateList.isNotEmpty
                              ? upcomingWatch.dateList.first.toLocalFullDateWithoutSuffix() ?? ''
                              : '',
                      titleColor: ColorConstants.buttonTextColor,
                    ),
                  ).addPaddingX(20),
                  if (upcomingWatch.upcomingAppointment.isNotEmpty) ...[
                    if (upcomingWatch.isListLoading ?? false) ...[
                      Center(child: CupertinoActivityIndicator(radius: 12, color: ColorConstants.primaryColor)).addMarginTop(50),
                    ] else ...[
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(20),
                        itemCount: upcomingWatch.upcomingAppointment.length + (upcomingWatch.reachedLastPage ? 0 : 1),
                        itemBuilder: (context, index) {
                          if (index == upcomingWatch.upcomingAppointment.length && upcomingWatch.upcomingAppointment.isNotEmpty == true) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Center(child: CupertinoActivityIndicator(color: ColorConstants.primaryColor)),
                            );
                          }
                          return ShadowContainer(
                            isShadow: false,
                            borderColor: ColorConstants.dropDownBorderColor,
                            backgroundColor: ColorConstants.yellowButtonColor,
                            border: 5,
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              BodySmallText(
                                                  title: '${widget.args.role == 1 ? LocaleKeys.expert.tr().toUpperCase() : LocaleKeys.user.tr().toUpperCase()}: ',
                                                  titleColor: ColorConstants.buttonTextColor,
                                                  fontFamily: FontWeightEnum.w400.toInter),
                                              Expanded(
                                                child: BodySmallText(
                                                  title: upcomingWatch.upcomingAppointment[index].detail?.name ?? LocaleKeys.anonymous.tr(),
                                                  titleColor: ColorConstants.buttonTextColor,
                                                  maxLine: 3,
                                                ),
                                              ),
                                            ],
                                          ),
                                          5.0.spaceY,
                                          RichText(
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: '${LocaleKeys.time.tr()}: ',
                                              style:
                                                  Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        '${upcomingWatch.upcomingAppointment[index].startTime?.to12HourTimeFormat().toLowerCase() ?? ''} - ${upcomingWatch.upcomingAppointment[index].endTime?.to12HourTimeFormat().toLowerCase() ?? ''}',
                                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
                                              ],
                                            ),
                                          ),
                                          5.0.spaceY,
                                          RichText(
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: '${LocaleKeys.duration.tr().toUpperCase()}: ',
                                              style:
                                                  Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter),
                                              children: [
                                                TextSpan(
                                                    text: '${int.parse(upcomingWatch.upcomingAppointment[index].duration.toString()) ~/ 60} ${LocaleKeys.minutes.tr()}',
                                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
                                              ],
                                            ),
                                          ),
                                          10.0.spaceY,
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(offset: Offset(2, 5), color: ColorConstants.blackColor.withOpacity(0.3), spreadRadius: 2, blurRadius: 2),
                                      ], shape: BoxShape.circle),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: NetworkImageWidget(
                                          imageURL: upcomingWatch.upcomingAppointment[index].detail?.profileImage ?? '',
                                          boxFit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                widget.args.role == 1 ? 12.0.spaceY : 0.0.spaceY,
                                Row(
                                  children: [
                                    Visibility(
                                      visible: widget.args.role == 1,
                                      replacement: SizedBox.shrink(),
                                      child: PrimaryButton(
                                        title: LocaleKeys.startCall.tr(),
                                        width: 150,
                                        onPressed: () {
                                          DateTime startTimeValue = DateTime.parse(upcomingWatch.upcomingAppointment[index].startTime ?? '').toLocal();
                                          DateTime endTimeValue = DateTime.parse(upcomingWatch.upcomingAppointment[index].endTime ?? '').toLocal();
                                          DateTime now = DateTime.now().toLocal();
                                          bool startTime = startTimeValue.difference(now).inHours == 0 && startTimeValue.difference(now).inMinutes <= 0;
                                          bool endTime = endTimeValue.isAfter(now);/*endTimeValue.difference(now).inHours == 0 && endTimeValue.difference(now).inMinutes >= 0;*/
                                          // startTimeValue.isBefore(now) && endTimeValue.isAfter(now)
                                          if (startTime && endTime) {
                                            ref.read(socketProvider).connectCallEmit(
                                                expertId: upcomingWatch.upcomingAppointment[index].expertId.toString(),
                                                callRequestId:
                                                upcomingWatch.upcomingAppointment[index].callRequestId.toString());
                                          } else {
                                            FlutterToast().showToast(msg: LocaleKeys.startCallToast.tr());
                                          }
                                        },
                                        fontSize: 10,
                                        titleColor: ColorConstants.textColor,
                                        buttonColor: ColorConstants.yellowLightColor,
                                      ).addMarginRight(14),
                                    ),
                                    PrimaryButton(
                                      title: LocaleKeys.cancelAppointment.tr(),
                                      width: 150,
                                      onPressed: () => context.toPushNamed(
                                        RoutesConstants.canceledAppointmentOptionScreen,
                                        args: CancelArgs(
                                            appointmentData: GetUpcomingAppointment(
                                              id: upcomingWatch.upcomingAppointment[index].id,
                                              userId: upcomingWatch.upcomingAppointment[index].userId,
                                              expertId: upcomingWatch.upcomingAppointment[index].expertId,
                                              startTime: upcomingWatch.upcomingAppointment[index].startTime,
                                              endTime: upcomingWatch.upcomingAppointment[index].endTime,
                                              duration: upcomingWatch.upcomingAppointment[index].duration.toString(),
                                              date: upcomingWatch.upcomingAppointment[index].date,
                                            ),
                                            role: widget.args.role,
                                            fromScheduled: false),
                                      ),
                                      fontSize: 10,
                                      titleColor: ColorConstants.textColor,
                                      buttonColor: ColorConstants.yellowLightColor,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => 20.0.spaceY,
                      )
                    ]
                  ] else ...[
                    BodySmallText(
                            title: LocaleKeys.noUpcomingAppointment.tr(),
                            titleColor: ColorConstants.textColor,
                            titleTextAlign: TextAlign.center,
                            fontFamily: FontWeightEnum.w400.toInter)
                        .addMarginTop(30)
                  ]
                ],
              ),
            ),
    );
  }
}
