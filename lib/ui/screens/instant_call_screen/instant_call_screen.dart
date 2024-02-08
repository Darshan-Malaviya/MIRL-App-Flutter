import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/time_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';

ValueNotifier<int> bgCallEndTrigger = ValueNotifier<int>(20);

class InstantCallRequestDialog extends ConsumerStatefulWidget {
  final String image, name, title, desc;
  final String firstBTnTitle;
  final String secondBtnTile;
  final VoidCallback onFirstBtnTap;
  final VoidCallback? onSecondBtnTap;
  final Color? bgColor;
  final Color? secondBtnColor;
  final String callTypeEnum;

  const InstantCallRequestDialog(
      {super.key,
      required this.name,
      required this.image,
      required this.title,
      required this.desc,
      required this.callTypeEnum,
      required this.firstBTnTitle,
      required this.secondBtnTile,
      required this.onFirstBtnTap,
      this.onSecondBtnTap,
      this.bgColor,
      this.secondBtnColor});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InstantCallRequestDialog();
}

class _InstantCallRequestDialog extends ConsumerState<InstantCallRequestDialog> {
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
        TitleLargeText(
          title: widget.title,
          fontSize: 20,
          titleColor: ColorConstants.primaryColor,
        ),
        10.0.spaceY,
        ValueListenableBuilder(
            valueListenable: bgCallEndTrigger,
            builder: (BuildContext context, int value, Widget? child) {
              return DisplayLargeText(title: Duration(seconds: value).toTimeString(), fontSize: 65, titleColor: ColorConstants.primaryColor);
            }),
        16.0.spaceY,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RadiusConstant.alertdialogRadius),
              color: ColorConstants.yellowButtonColor,
              boxShadow: [BoxShadow(offset: Offset(0, 6), color: ColorConstants.borderColor.withOpacity(0.5), spreadRadius: 1, blurRadius: 2)]),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              32.0.spaceY,
              BodySmallText(
                title: widget.desc,
                titleColor: ColorConstants.textColor,
                titleTextAlign: TextAlign.center,
                maxLine: 10,
              ),
              20.0.spaceY,
              ShadowContainer(
                shadowColor: ColorConstants.blackColor.withOpacity(0.5),
                border: 25,
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: NetworkImageWidget(
                        imageURL: widget.image,
                        height: 120,
                        width: 95,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                    10.0.spaceY,
                    BodyMediumText(
                      title: widget.name,
                      fontFamily: FontWeightEnum.w600.toInter,
                      titleColor: ColorConstants.textColor,
                      titleTextAlign: TextAlign.center,
                      maxLine: 2,
                    )
                  ],
                ).addPaddingXY(paddingX: 16, paddingY: 16),
              ),
              32.0.spaceY,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    title: widget.secondBtnTile,
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    onPressed: widget.onSecondBtnTap ?? () => Navigator.pop(context),
                    buttonColor: widget.secondBtnColor ?? ColorConstants.primaryColor,
                    titleColor: ColorConstants.textColor,
                  ).addVisibility(widget.secondBtnTile.isNotEmpty),
                  16.0.spaceX,
                  PrimaryButton(
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    title: widget.firstBTnTitle,
                    onPressed: widget.onFirstBtnTap,
                    buttonColor: ColorConstants.primaryColor,
                    titleColor: ColorConstants.textColor,
                  ),
                ],
              ),
              16.0.spaceY,
            ],
          ),
        ),
        30.0.spaceY,
        Visibility(
          visible:
              widget.callTypeEnum == CallType.requestDeclined.name || widget.callTypeEnum == CallType.requestTimeout.name || widget.callTypeEnum == CallType.receiverRequested.name,
          replacement: SizedBox.shrink(),
          child: TitleSmallText(
            title: LocaleKeys.viewOtherExpert.tr(),
            fontFamily: FontWeightEnum.w400.toInter,
            titleColor: ColorConstants.textColor,
          ),
        ),
        20.0.spaceY,
        Visibility(
          visible:  widget.callTypeEnum == CallType.receiverRequested.name || widget.callTypeEnum == CallType.multiConnectReceiverRequested.name,
          replacement: SizedBox.shrink(),
          child: Align(
            alignment: Alignment.bottomRight,
            child: TitleSmallText(
              title: LocaleKeys.blockUser.tr(),
              fontFamily: FontWeightEnum.w400.toInter,
              titleColor: ColorConstants.callsPausedColor,
            ),
          ),
        ),
      ],
    );
  }
}
