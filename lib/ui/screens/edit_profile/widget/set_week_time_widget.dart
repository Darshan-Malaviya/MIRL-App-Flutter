import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

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
    DateFormat usHour = DateFormat("h:mm a");

    return expertWatch.isLoading
        ? Center(
            child: CupertinoActivityIndicator(radius: 12, color: ColorConstants.primaryColor),
          )
        : Column(
            children: List.generate(expertWatch.weekScheduleModel.length, (index) {
              final weekData = expertWatch.weekScheduleModel[index];
              return Column(
                children: [
                  LabelSmallText(
                      title: (weekData.isAvailable)
                          ? "${usHour.format(DateTime.fromMicrosecondsSinceEpoch(weekData.startTime.toInt() * 1000))} - "
                              "${usHour.format(DateTime.fromMicrosecondsSinceEpoch(weekData.endTime.toInt() * 1000))}"
                          : StringConstants.noTimeSchedule),
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
                        child: (weekData.isAvailable)
                            ? RangeSlider(
                                values: RangeValues(weekData.startTime, weekData.endTime),
                                activeColor: ColorConstants.yellowButtonColor,
                                inactiveColor: ColorConstants.sliderColor,
                                min: expertWatch.hourOnly.millisecondsSinceEpoch.toDouble(),
                                max: expertWatch.plusDay.millisecondsSinceEpoch.toDouble(),
                                divisions: 96,
                                onChanged: (RangeValues value) {
                                  expertRead.changeTime(index, value.start, value.end);
                                },
                              )
                            : Container(
                                height: 10,
                                margin: EdgeInsets.symmetric(horizontal: 18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: ColorConstants.sliderColor,
                                ),
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
              );
            }),
          );
  }
}
