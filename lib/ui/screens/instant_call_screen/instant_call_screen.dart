import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_status_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/time_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';
import 'package:mirl/infrastructure/commons/utils/value_notifier_utils.dart';
import 'package:mirl/ui/screens/instant_call_screen/arguments/instance_call_dialog_arguments.dart';


class InstantCallRequestDialog extends ConsumerStatefulWidget {
  final InstanceCallDialogArguments args;

  const InstantCallRequestDialog({super.key, required this.args});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InstantCallRequestDialog();
}

class _InstantCallRequestDialog extends ConsumerState<InstantCallRequestDialog> {
  Timer? _timer;

  @override
  void initState() {
    bgCallEndTrigger.addListener(() {
      if (bgCallEndTrigger.value > 1) {
        startTimer();
      }
      if(instanceCallEnumNotifier.value == CallTypeEnum.callRequest
          || instanceCallEnumNotifier.value == CallTypeEnum.requestWaiting
          || instanceCallEnumNotifier.value == CallTypeEnum.receiverRequested){
        if( bgCallEndTrigger.value == 0){
          _timer?.cancel();
          ref.read(socketProvider).updateRequestStatusEmit(
              expertId: widget.args.expertId,
              userId: widget.args.userID,
              callStatusEnum: CallStatusEnum.timeout,
              callRoleEnum: widget.args.expertId == SharedPrefHelper.getUserId.toString()
                  ? CallRoleEnum.expert
                  : CallRoleEnum.user);
          instanceCallEnumNotifier.value = CallTypeEnum.requestTimeout;
        }
      }
    });
    super.initState();
  }

  void startTimer() {
    _timer?.cancel();
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (bgCallEndTrigger.value == 0) {
          timer.cancel();
          _timer?.cancel();
         // bgCallEndTrigger.value = 20;
        } else {
          bgCallEndTrigger.value--;
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
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBarWidget(
          preferSize: 0,
        ),
        backgroundColor: ColorConstants.whiteColor,
        body: ValueListenableBuilder(
          valueListenable: instanceCallEnumNotifier,
          builder: (BuildContext context, CallTypeEnum value, Widget? child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                40.0.spaceY,
                if( (instanceCallEnumNotifier.value == CallTypeEnum.callRequest
                    || instanceCallEnumNotifier.value == CallTypeEnum.requestWaiting
                || instanceCallEnumNotifier.value == CallTypeEnum.receiverRequested
                    || instanceCallEnumNotifier.value == CallTypeEnum.multiConnectReceiverRequested))...[
                  TitleLargeText(
                    title: instanceCallEnumNotifier.value.titleName,
                    fontSize: 20,
                    titleTextAlign: TextAlign.center,
                    titleColor: ColorConstants.primaryColor,
                  ),
                  10.0.spaceY,
                  if(bgCallEndTrigger.value > 1)...[
                    ValueListenableBuilder(
                        valueListenable: bgCallEndTrigger,
                        builder: (BuildContext context, int value, Widget? child) {
                          return DisplayLargeText(
                              title: Duration(seconds: value).toTimeString(),
                              fontSize: 65,
                              titleColor: ColorConstants.primaryColor);
                        }),
                  ]
                ] else ... [
                  TitleLargeText(
                    title: instanceCallEnumNotifier.value.titleName,
                    fontSize: 30,
                    maxLine: 3,
                    titleTextAlign: TextAlign.center,
                    titleColor: ColorConstants.primaryColor,
                  ),
                ],
                16.0.spaceY,
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(RadiusConstant.alertdialogRadius),
                      color: instanceCallEnumNotifier.value.typeName,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 6),
                            color: ColorConstants.borderColor.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2)
                      ]),
                  child: Column(
                    children: [
                      20.0.spaceY,
                      BodySmallText(
                        title: instanceCallEnumNotifier.value.descriptionName,
                        titleColor: ColorConstants.textColor,
                        titleTextAlign: TextAlign.center,
                        maxLine: 10,
                      ),
                      20.0.spaceY,
                      ShadowContainer(
                        shadowColor: ColorConstants.blackColor.withOpacity(0.5),
                        border: 25,
                        width: 136,
                        height: 189,
                        padding: EdgeInsets.zero,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: NetworkImageWidget(
                                imageURL: widget.args.image ?? '',
                                height: 122,
                                width: 95,
                                boxFit: BoxFit.cover,
                              ),
                            ),
                            10.0.spaceY,
                            BodyMediumText(
                              title: widget.args.name ?? '',
                              fontFamily: FontWeightEnum.w600.toInter,
                              titleColor: ColorConstants.textColor,
                              titleTextAlign: TextAlign.center,
                              maxLine: 2,
                            )
                          ],
                        ).addPaddingXY(paddingX: 16, paddingY: 16),
                      ),
                      20.0.spaceY,
                      (instanceCallEnumNotifier.value == CallTypeEnum.requestWaiting
                          || instanceCallEnumNotifier.value == CallTypeEnum.requestApproved
                       || instanceCallEnumNotifier.value == CallTypeEnum.requestDeclined)
                          ? Center(
                              child: PrimaryButton(
                                title: instanceCallEnumNotifier.value.secondButtonName,
                                width: 130,
                                onPressed: widget.args.onSecondBtnTap ?? () => Navigator.pop(context),
                                buttonColor: widget.args.secondBtnColor ?? ColorConstants.primaryColor,
                                titleColor: ColorConstants.textColor,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: PrimaryButton(
                                    title: instanceCallEnumNotifier.value.secondButtonName,
                                   // width: 130,
                                    onPressed: widget.args.onSecondBtnTap ?? () => Navigator.pop(context),
                                    buttonColor: widget.args.secondBtnColor ?? ColorConstants.primaryColor,
                                    titleColor: ColorConstants.textColor,
                                  ),
                                ).addVisibility(instanceCallEnumNotifier.value.secondButtonName.isNotEmpty),
                                8.0.spaceX,
                                Flexible(
                                  child: PrimaryButton(
                                    //width: 130,
                                    title: instanceCallEnumNotifier.value.firstButtonName,
                                    onPressed: widget.args.onFirstBtnTap ?? () {},
                                    buttonColor: ColorConstants.primaryColor,
                                    titleColor: ColorConstants.textColor,
                                  ),
                                ).addVisibility(instanceCallEnumNotifier.value.firstButtonName.isNotEmpty)
                              ],
                            ),
                      16.0.spaceY,
                    ],
                  ).addPaddingX(20),
                ).addPaddingX(16),
                30.0.spaceY,
                Visibility(
                  visible: instanceCallEnumNotifier.value == CallTypeEnum.requestDeclined ||
                      instanceCallEnumNotifier.value == CallTypeEnum.requestTimeout ||
                      instanceCallEnumNotifier.value == CallTypeEnum.receiverRequested,
                  replacement: SizedBox.shrink(),
                  child: TitleSmallText(
                    title: LocaleKeys.viewOtherExpert.tr(),
                    fontFamily: FontWeightEnum.w400.toInter,
                    titleTextAlign: TextAlign.center,
                    titleColor: ColorConstants.textColor,
                  ),
                ),
                20.0.spaceY,
                Visibility(
                  visible: instanceCallEnumNotifier.value == CallTypeEnum.receiverRequested ||
                      instanceCallEnumNotifier.value == CallTypeEnum.multiConnectReceiverRequested,
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
          },
        ).addPaddingXY(paddingX: 20, paddingY: 20),
      ),
    );
  }
}
