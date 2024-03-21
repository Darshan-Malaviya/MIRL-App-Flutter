import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/range_slider/range_slider_widget.dart';

import '../../../common/range_slider/thumb_shape.dart';

class SetWeekTimeWidget extends ConsumerStatefulWidget {
  const SetWeekTimeWidget({super.key});

  @override
  ConsumerState createState() => _SetWeekTimeWidgetState();
}

class _SetWeekTimeWidgetState extends ConsumerState<SetWeekTimeWidget> {
  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.read(editExpertProvider);
    DateFormat usHour = DateFormat("hh:mma");

    if (expertWatch.isLoading) {
      return Center(
        child: CupertinoActivityIndicator(radius: 12, color: ColorConstants.primaryColor),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: List.generate(expertWatch.weekScheduleModel.length, (index) {
            final weekData = expertWatch.weekScheduleModel[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LabelSmallText(
                    title: (weekData.isAvailable)
                        ? "${usHour.format(DateTime.fromMillisecondsSinceEpoch(weekData.startTime.toInt())).toLowerCase()} - "
                            "${usHour.format(DateTime.fromMillisecondsSinceEpoch(weekData.endTime.toInt())).toLowerCase()}"
                        : StringConstants.noTimeSchedule),
                5.0.spaceY,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 40,
                        child: BodyMediumText(
                          title: weekData.dayName ?? '',
                          shadows: [
                            Shadow(
                              blurRadius: 12.0,
                              color: Colors.grey,
                            )
                          ],
                        )),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          (weekData.isAvailable)
                              ? RangeSliderWidget(
                                  values: RangeValues(weekData.startTime, weekData.endTime),
                                  activeColor: ColorConstants.yellowButtonColor,
                                  inactiveColor: ColorConstants.sliderColor,
                                  min: expertWatch.hourOnly.millisecondsSinceEpoch.toDouble(),
                                  max: expertWatch.plusDay.millisecondsSinceEpoch.toDouble(),
                                  divisions: 144,
                                  onChanged: (RangeValues value) {
                                    expertRead.changeTime(index, value.start, value.end);
                                  },
                                )
                              : Container(
                                  height: 10,
                                  margin: EdgeInsets.symmetric(horizontal: 24),
                                  decoration: BoxDecoration(
                                    color: ColorConstants.sliderColor,
                                  ),
                                ),
                          10.0.spaceY,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LabelSmallText(
                                title: '00:00am',
                                fontFamily: FontWeightEnum.w400.toInter,
                              ),
                              LabelSmallText(
                                title: '11:59pm',
                                fontFamily: FontWeightEnum.w400.toInter,
                              ),
                            ],
                          ).addPaddingX(20)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          activeColor: ColorConstants.primaryColor,
                          inactiveThumbColor: ColorConstants.secondaryColor,
                          activeTrackColor: ColorConstants.borderColor.withOpacity(0.2),
                          inactiveTrackColor: ColorConstants.borderColor.withOpacity(0.2),
                          trackOutlineColor: MaterialStatePropertyAll(ColorConstants.transparentColor),
                          value: (weekData.isAvailable),
                          onChanged: (value) {
                            expertRead.changeWeekAvailability(index);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ).addMarginBottom(10);
          }),
        ).addPaddingX(16),
      );
    }
  }
}
