import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';
import 'package:mirl/infrastructure/commons/utils/value_notifier_utils.dart';

class MultiConnectCallRequest extends ConsumerStatefulWidget {
  final String title, desc;
  final String firstBTnTitle;
  final String secondBtnTile;
  final VoidCallback onFirstBtnTap;
  final VoidCallback? onSecondBtnTap;
  final Color? bgColor;
  final Color? secondBtnColor;
  final String callTypeEnum;
  final Color? statusColor;

  const MultiConnectCallRequest(
      {super.key,
      required this.title,
      required this.desc,
      required this.callTypeEnum,
      required this.firstBTnTitle,
      required this.secondBtnTile,
      required this.onFirstBtnTap,
      this.onSecondBtnTap,
      this.bgColor,
      this.statusColor,
      this.secondBtnColor});

  @override
  ConsumerState createState() => _MultiConnectCallRequestState();
}

class _MultiConnectCallRequestState extends ConsumerState<MultiConnectCallRequest> {
  Timer? _timer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    _timer?.cancel();
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (bgCallEndTrigger.value == 0) {
          setState(() {
            timer.cancel();
            _timer?.cancel();
            bgCallEndTrigger.value = 20;
          });
        } else {
          setState(() {
            bgCallEndTrigger.value--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    bgCallEndTrigger.value = 20;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HeadlineLargeText(
          title: LocaleKeys.areYouReady.tr(),
          fontSize: 30,
          titleColor: ColorConstants.primaryColor,
        ),
        16.0.spaceY,
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 400,
              width: 320,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RadiusConstant.alertdialogRadius),
                  color: ColorConstants.yellowButtonColor,
                  boxShadow: [BoxShadow(offset: Offset(0, 6), color: ColorConstants.borderColor.withOpacity(0.5), spreadRadius: 1, blurRadius: 2)]),
            ),
            Column(
              children: [
                8.0.spaceY,
                BodySmallText(
                  title: widget.desc,
                  titleColor: ColorConstants.textColor,
                  titleTextAlign: TextAlign.center,
                  maxLine: 10,
                ),
                20.0.spaceY,
                Container(
                  color: Colors.transparent,
                  child: SizedBox(
                    height: 260,
                    child: ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemBuilder: (context, index) {
                        return ShadowContainer(
                          shadowColor: ColorConstants.blackColor.withOpacity(0.3),
                          border: 25,
                          offset: Offset(0, 6),
                          blurRadius: 3,
                          spreadRadius: 1,
                          padding: EdgeInsets.zero,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(offset: Offset(2, 5), color: ColorConstants.blackColor.withOpacity(0.3), spreadRadius: 2, blurRadius: 2),
                                ], shape: BoxShape.circle),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: NetworkImageWidget(
                                    imageURL:
                                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                    boxFit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                              ),
                              12.0.spaceY,
                              BodyMediumText(
                                title: 'Preeti\nTewari Serai',
                                fontFamily: FontWeightEnum.w600.toInter,
                                titleColor: ColorConstants.textColor,
                                titleTextAlign: TextAlign.center,
                                maxLine: 2,
                              ),
                              5.0.spaceY,
                              LabelSmallText(
                                title: '${LocaleKeys.rating.tr()} 9',
                                fontFamily: FontWeightEnum.w500.toInter,
                                fontSize: 8,
                                titleColor: ColorConstants.buttonTextColor,
                              ),
                              3.0.spaceY,
                              LabelSmallText(
                                title: '${LocaleKeys.feePerMinute.tr()} \$20',
                                fontFamily: FontWeightEnum.w500.toInter,
                                fontSize: 8,
                                titleColor: ColorConstants.buttonTextColor,
                              ),
                              5.0.spaceY,
                              BodyMediumText(
                                title: widget.callTypeEnum,
                                titleColor: widget.statusColor,
                              )
                            ],
                          ).addPaddingXY(paddingX: 20, paddingY: 16),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => 16.0.spaceX,
                    ),
                  ),
                ),
                8.0.spaceY,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrimaryButton(
                      title: widget.secondBtnTile,
                      width: 130,
                      onPressed: widget.onSecondBtnTap ?? () => Navigator.pop(context),
                      buttonColor: widget.secondBtnColor ?? ColorConstants.primaryColor,
                      titleColor: ColorConstants.textColor,
                    ).addVisibility(widget.secondBtnTile.isNotEmpty),
                    16.0.spaceX,
                    PrimaryButton(
                      width: 130,
                      title: widget.firstBTnTitle,
                      onPressed: widget.onFirstBtnTap,
                      buttonColor: ColorConstants.primaryColor,
                      titleColor: ColorConstants.textColor,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
