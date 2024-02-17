import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/appointment_response_model.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
import 'package:mirl/ui/common/table_calender_widget/table_calender.dart';

class UpcomingAppointmentScreen extends ConsumerStatefulWidget {
  const UpcomingAppointmentScreen({super.key});

  @override
  ConsumerState createState() => _UpcomingAppointmentScreenState();
}

class _UpcomingAppointmentScreenState extends ConsumerState<UpcomingAppointmentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(upcomingAppointmentProvider).upcomingAppointmentApiCall(showLoader: true, showListLoader: false);
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
                      if (upcomingWatch.dateList.contains(selectedDay.toString().toLocalDate())) {
                        upcomingRead.getSelectedDate(selectedDay);
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
                    titleColor: ColorConstants.textColor,
                  ),
                  20.0.spaceY,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BodySmallText(
                      title:
                          upcomingWatch.selectedDate != null ? upcomingWatch.selectedDate.toString().toLocalFullDate() ?? '' :
                          upcomingWatch.dateList.isNotEmpty ? upcomingWatch.dateList.first.toLocalFullDate() ?? '' : '',
                      titleColor: ColorConstants.textColor,
                    ),
                  ).addPaddingX(20),
                  20.0.spaceY,
                  if (upcomingWatch.upcomingAppointment.isNotEmpty) ...[
                    if (upcomingWatch.isListLoading ?? false) ...[
                      Center(child: CupertinoActivityIndicator(radius: 12, color: ColorConstants.primaryColor)),
                    ] else ...[
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: upcomingWatch.upcomingAppointment.length,
                        itemBuilder: (context, index) {
                          final data = upcomingWatch.upcomingAppointment[index];
                          return ShadowContainer(
                            isShadow: false,
                            borderColor: ColorConstants.dropDownBorderColor,
                            backgroundColor: ColorConstants.yellowButtonColor,
                            border: 5,
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                            child: Row(
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
                                        text: '${LocaleKeys.user.tr()}: ',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter),
                                        children: [
                                          TextSpan(text: data.detail?.name ?? '', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
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
                                              text: '${data.startTime?.to12HourTimeFormat().toUpperCase() ?? ''} - ${data.endTime?.to12HourTimeFormat().toUpperCase() ?? ''}',
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
                                              text: ' ${data.duration.toString()} ${LocaleKeys.minutes.tr()}',
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
                                        ],
                                      ),
                                    ),
                                    10.0.spaceY,
                                    PrimaryButton(
                                      title: LocaleKeys.cancelAppointment.tr(),
                                      width: 150,
                                      onPressed: () => context.toPushNamed(
                                        RoutesConstants.canceledAppointmentOptionScreen,
                                        args: CancelArgs(appointmentData: AppointmentData(id: data.id, expertDetail: ExpertDetail(id: data.expertId)), role: '2', fromUser: false),
                                      ),
                                      fontSize: 10,
                                      titleColor: ColorConstants.textColor,
                                      buttonColor: ColorConstants.yellowLightColor,
                                    )
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(offset: Offset(2, 5), color: ColorConstants.blackColor.withOpacity(0.3), spreadRadius: 2, blurRadius: 2),
                                  ], shape: BoxShape.circle),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: NetworkImageWidget(
                                      imageURL: data.detail?.profileImage ?? '',
                                      boxFit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => 20.0.spaceY,
                      )
                    ]
                  ] else ...[
                    BodySmallText(
                        title: 'No Upcoming Appointment',
                        titleColor: ColorConstants.textColor,
                        titleTextAlign: TextAlign.center,
                        maxLine: 2,
                        fontFamily: FontWeightEnum.w400.toInter)
                  ]
                ],
              ),
            ),
    );
  }
}
