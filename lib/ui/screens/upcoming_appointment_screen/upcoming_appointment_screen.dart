import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/appointment_response_model.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
import 'package:mirl/ui/common/table_calender_widget/table_calender.dart';

class UpcomingAppointmentScreen extends ConsumerStatefulWidget {
  final int role;

  const UpcomingAppointmentScreen({super.key, required this.role});

  @override
  ConsumerState createState() => _UpcomingAppointmentScreenState();
}

class _UpcomingAppointmentScreenState extends ConsumerState<UpcomingAppointmentScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(upcomingAppointmentProvider).upcomingAppointmentApiCall(showLoader: true, showListLoader: false, role: widget.role);
    });

    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(upcomingAppointmentProvider).reachedLastPage;
        if (!isLoading) {
          ref.read(upcomingAppointmentProvider).upcomingAppointmentApiCall(showLoader: false, showListLoader: false, role: widget.role);
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
              child: CupertinoActivityIndicator(radius: 12, color: ColorConstants.primaryColor),
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
                        upcomingRead.getSelectedDate(selectedDay, widget.role);
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
                          ? upcomingWatch.selectedDate.toString().toLocalFullDateWithSuffix() ?? ''
                          : upcomingWatch.dateList.isNotEmpty
                              ? upcomingWatch.dateList.first.toLocalFullDateWithSuffix() ?? ''
                              : '',
                      titleColor: ColorConstants.buttonTextColor,
                    ),
                  ).addPaddingX(20),
                  if (upcomingWatch.upcomingAppointment.isNotEmpty) ...[
                    if (upcomingWatch.isListLoading ?? false) ...[
                      Center(child: CupertinoActivityIndicator(radius: 12, color: ColorConstants.primaryColor)),
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
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            text: '${LocaleKeys.user.tr().toUpperCase()}: ',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter),
                                            children: [
                                              TextSpan(
                                                  text: upcomingWatch.upcomingAppointment[index].detail?.name ?? LocaleKeys.anonymous.tr(),
                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
                                            ],
                                          ),
                                        ),
                                        5.0.spaceY,
                                        RichText(
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            text: '${LocaleKeys.time.tr()}: ',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '${upcomingWatch.upcomingAppointment[index].startTime?.to12HourTimeFormat().toUpperCase() ?? ''} - ${upcomingWatch.upcomingAppointment[index].endTime?.to12HourTimeFormat().toUpperCase() ?? ''}',
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
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter),
                                            children: [
                                              TextSpan(
                                                  text: '${upcomingWatch.upcomingAppointment[index].duration.toString()} ${LocaleKeys.minutes.tr()}',
                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
                                            ],
                                          ),
                                        ),
                                        10.0.spaceY,
                                      ],
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
                                12.0.spaceY,
                                Row(
                                  children: [
                                    Visibility(
                                      visible: widget.role == '1',
                                      replacement: SizedBox.shrink(),
                                      child: PrimaryButton(
                                        title: LocaleKeys.startCall.tr(),
                                        width: 150,
                                        onPressed: () {},
                                        fontSize: 10,
                                        titleColor: ColorConstants.textColor,
                                        buttonColor: ColorConstants.yellowLightColor,
                                      ).addMarginLeft(14),
                                    ),
                                    PrimaryButton(
                                      title: LocaleKeys.cancelAppointment.tr(),
                                      width: 150,
                                      onPressed: () => context.toPushNamed(
                                        RoutesConstants.canceledAppointmentOptionScreen,
                                        args: CancelArgs(
                                            appointmentData: AppointmentData(
                                                id: upcomingWatch.upcomingAppointment[index].id, expertDetail: ExpertDetail(id: upcomingWatch.upcomingAppointment[index].expertId)),
                                            role: widget.role,
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
                  ]
                ],
              ),
            ),
    );
  }
}
