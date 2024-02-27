import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/table_calender_widget/table_calender.dart';
import 'package:mirl/ui/screens/earning_report_screen/widget/short_report_widget.dart';

class EarningReportScreen extends ConsumerStatefulWidget {
  const EarningReportScreen({super.key});

  @override
  ConsumerState createState() => _EarningReportScreenState();
}

class _EarningReportScreenState extends ConsumerState<EarningReportScreen> {
  @override
  Widget build(BuildContext context) {
    final earningWatch = ref.watch(reportReviewProvider);
    final earningRead = ref.read(reportReviewProvider);

    return Scaffold(
      appBar: AppBarWidget(
          preferSize: 40,
          leading: InkWell(
            child: Image.asset(ImageConstants.backIcon),
            onTap: () => context.toPop(),
          ),
          trailingIcon: InkWell(
            onTap: () {},
            child: TitleMediumText(
              title: StringConstants.done,
            ).addPaddingRight(14),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.0.spaceY,
            TitleLargeText(
              title: LocaleKeys.earningReport.tr(),
              titleColor: ColorConstants.bottomTextColor,
            ),
            30.0.spaceY,
            ShortReportWidget(
              value: earningWatch.sortByReport,
              itemList: earningWatch.sortByEarningItem,
              onChanged: earningRead.setSortByReport,
            ),
            20.0.spaceY,
            TableCalenderRangeWidget(
              onDateSelected: (selectedDay, focusedDay) {
                print(selectedDay);
              },
              selectedDay: DateTime.now(),
              fromUpcomingAppointment: false,
            ),
            30.0.spaceY,
            Image.asset(ImageConstants.line),
            30.0.spaceY,
            ShadowContainer(
              height: 60,
              border: 5,
              isShadow: false,
              backgroundColor: ColorConstants.primaryColor.withOpacity(0.5),
              margin: EdgeInsets.symmetric(horizontal: 60),
              child: Center(
                child: BodyMediumText(
                  title: '${LocaleKeys.weeklyEarning.tr()}: USD \$90',
                  titleColor: ColorConstants.buttonTextColor,
                ),
              ),
            ),
            20.0.spaceY,
            BodyMediumText(
              title: '${LocaleKeys.weeklyEarning.tr()} [${'2024-02-14T05:33:05Z'.toLocalEarningDate() ?? ''}-${'2024-02-21T05:33:05Z'.toLocalEarningDate() ?? ''}]',
              titleColor: ColorConstants.buttonTextColor,
            ),
            20.0.spaceY,
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(20),
              itemCount: 5,
              itemBuilder: (context, index) {
                // final data = upcomingWatch.upcomingAppointment[index];
                return Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstants.yellowButtonColor,
                        boxShadow: [
                          BoxShadow(offset: Offset(0, 2), color: ColorConstants.disableColor, spreadRadius: 0, blurRadius: 1),
                        ],
                      ),
                      child: Center(
                        child: BodySmallText(
                          title: '${index + 1}',
                          fontFamily: FontWeightEnum.w400.toInter,
                        ),
                      ),
                    ),
                    20.0.spaceX,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            softWrap: true,
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: '${LocaleKeys.user.tr().toUpperCase()}: ',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter),
                              children: [
                                TextSpan(text: 'PREETI', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
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
                                TextSpan(text: '10:00 AM - 11:00 AM', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
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
                                TextSpan(text: '60 minutes', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
                              ],
                            ),
                          ),
                          5.0.spaceY,
                          RichText(
                            softWrap: true,
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: '${LocaleKeys.earning.tr()}: ',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter),
                              children: [
                                TextSpan(text: 'USD \$30', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
                              ],
                            ),
                          ),
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
                          imageURL: '',
                          boxFit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) => 30.0.spaceY,
            )
          ],
        ),
      ),
    );
  }
}
