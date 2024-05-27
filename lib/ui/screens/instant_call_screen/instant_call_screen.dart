import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_timer_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/time_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';
import 'package:mirl/ui/screens/instant_call_screen/arguments/instance_call_dialog_arguments.dart';


class InstantCallRequestDialog extends ConsumerStatefulWidget {
  final InstanceCallDialogArguments args;

  const InstantCallRequestDialog({super.key, required this.args});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InstantCallRequestDialog();
}

class _InstantCallRequestDialog extends ConsumerState<InstantCallRequestDialog> {

  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    instanceRequestTimerNotifier = ValueNotifier<int>(120);
    _timer = new Timer.periodic(
      Duration(seconds: 1), (Timer timer)  {
        if (instanceRequestTimerNotifier.value == 0) {
          timer.cancel();
          _timer?.cancel();
          if (instanceRequestTimerNotifier.value == 0 && widget.args.userID == SharedPrefHelper.getUserId.toString()) {
            instanceCallEnumNotifier.value = CallRequestTypeEnum.requestTimeout;
            ref.read(socketProvider).updateRequestStatusEmit(
                expertId: widget.args.expertId,
                userId: widget.args.userID,
                callStatusEnum: CallRequestStatusEnum.timeout,
                callRoleEnum: CallRoleEnum.user);

          }
        } else {
          instanceRequestTimerNotifier.value =  instanceRequestTimerNotifier.value - 1;
          if(widget.args.userID == SharedPrefHelper.getUserId) {
             ref.read(socketProvider).timerEmit(userId: int.parse((widget.args.userID.toString())),expertIdList: [int.parse((widget.args.expertId.toString()))],
              callRoleEnum: CallRoleEnum.user, timer:instanceRequestTimerNotifier.value, timerType: CallTimerEnum.request, requestType: 1, );
          }
        }
      },
    );
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      instanceCallEnumNotifier.addListener(() {
        if(instanceCallEnumNotifier.value == CallRequestTypeEnum.requestWaiting) {
          startTimer();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    instanceCallEnumNotifier.dispose();
    instanceRequestTimerNotifier.dispose();
    instanceRequestTimerNotifier = ValueNotifier<int>(120);
    instanceCallEnumNotifier = ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.callRequest);
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBarWidget(
          preferSize: 0,
        ),
        backgroundColor: ColorConstants.whiteColor,
        body: ValueListenableBuilder(
          valueListenable: instanceCallEnumNotifier,
          builder: (BuildContext context, CallRequestTypeEnum value, Widget? child) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  40.0.spaceY,
                  if( (instanceCallEnumNotifier.value == CallRequestTypeEnum.callRequest
                      || instanceCallEnumNotifier.value == CallRequestTypeEnum.requestWaiting
                  || instanceCallEnumNotifier.value == CallRequestTypeEnum.receiverRequested))...[
                    TitleLargeText(
                      title: instanceCallEnumNotifier.value.titleName,
                      fontSize: 20,
                      titleTextAlign: TextAlign.center,
                      titleColor: ColorConstants.primaryColor,
                    ),
                    10.0.spaceY,
                      ValueListenableBuilder(
                          valueListenable: instanceRequestTimerNotifier,
                          builder: (BuildContext context, int value, Widget? child) {
                            return DisplayLargeText(
                                title: Duration(seconds: instanceRequestTimerNotifier.value).toTimeString(),
                                fontSize: 65,
                                titleColor: ColorConstants.primaryColor);
                          }),
                  ] else ... [
                    TitleLargeText(
                      title: instanceCallEnumNotifier.value.titleName,
                      fontSize: 30,
                      maxLine: 3,
                      titleTextAlign: TextAlign.center,
                      titleColor: ColorConstants.primaryColor,
                    ),
                    23.0.spaceY,
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
                          title: instanceCallEnumNotifier.value == CallRequestTypeEnum.callRequest
                              ? "${instanceCallEnumNotifier.value.descriptionName} ${widget.args.name?.toUpperCase()}?"
                              : "${instanceCallEnumNotifier.value.descriptionName}",
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
                              if( (widget.args.name?.isNotEmpty ?? false) && (widget.args.name != 'null'))...[
                                10.0.spaceY,
                                BodyMediumText(
                                  title: widget.args.name ?? '',
                                  fontFamily: FontWeightEnum.w600.toInter,
                                  titleColor: ColorConstants.textColor,
                                  titleTextAlign: TextAlign.center,
                                  maxLine: 2,
                                ),
                              ],
                            ],
                          ).addPaddingXY(paddingX: 16, paddingY: 16),
                        ),
                        20.0.spaceY,
                        ValueListenableBuilder(
                         valueListenable: allCallDurationNotifier,
                          builder: (BuildContext context, int value, Widget? child) {
                            return Visibility(
                              visible: allCallDurationNotifier.value != 0 && (instanceCallEnumNotifier.value == CallRequestTypeEnum.requestWaiting
                                  || instanceCallEnumNotifier.value == CallRequestTypeEnum.receiverRequested),
                              replacement: SizedBox.shrink(),
                              child: TitleSmallText(
                                title: "${LocaleKeys.duration.tr()}: ${(allCallDurationNotifier.value / 60).toStringAsFixed(0)} minutes",
                                fontFamily: FontWeightEnum.w400.toInter,
                                titleTextAlign: TextAlign.center,
                                titleColor: ColorConstants.textColor,
                              ),
                            );
                          }
                        ),
                        20.0.spaceY,
                        (instanceCallEnumNotifier.value == CallRequestTypeEnum.requestWaiting
                            || instanceCallEnumNotifier.value == CallRequestTypeEnum.requestApproved
                         || instanceCallEnumNotifier.value == CallRequestTypeEnum.requestDeclined)
                            ? Center(
                                child: PrimaryButton(
                                  title: instanceCallEnumNotifier.value.secondButtonName,
                                  width: 130,
                                  onPressed: widget.args.onSecondBtnTap ?? () => Navigator.pop(context),
                                  buttonColor: ColorConstants.primaryColor,
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
                                      buttonColor: (instanceCallEnumNotifier.value == CallRequestTypeEnum.receiverRequested)
                                          ? ColorConstants.yellowButtonColor : ColorConstants.primaryColor,
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

                    visible: instanceCallEnumNotifier.value == CallRequestTypeEnum.requestDeclined ||
                        instanceCallEnumNotifier.value == CallRequestTypeEnum.requestTimeout ||
                        instanceCallEnumNotifier.value == CallRequestTypeEnum.receiverRequested ||
                        instanceCallEnumNotifier.value == CallRequestTypeEnum.requestWaiting,
                    replacement: SizedBox.shrink(),
                    child: TitleSmallText(
                      title: instanceCallEnumNotifier.value == CallRequestTypeEnum.receiverRequested
                          ? LocaleKeys.instantCallReceiver.tr()
                          : multiConnectCallEnumNotifier.value == CallRequestTypeEnum.requestWaiting
                          ? LocaleKeys.pleaseDoNotLeaveThisScreen.tr().toUpperCase()
                          : LocaleKeys.viewOtherExpert.tr(),
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleTextAlign: TextAlign.center,
                      titleColor: ColorConstants.textColor,
                      maxLine: 4,
                    ),
                  ),
                  20.0.spaceY,
                  Visibility(
                    visible: instanceCallEnumNotifier.value == CallRequestTypeEnum.receiverRequested,
                    replacement: SizedBox.shrink(),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: (){
                          NavigationService.context.toPushNamed(RoutesConstants.blockUserScreen,
                              args: BlockUserArgs(userName: widget.args.name ?? '',
                                  imageURL: widget.args.image ?? '',
                                  userId: int.parse(widget.args.userID),
                                  userRole: 2,reportName: '',isFromInstantCall: true)
                          );
                        },
                        child: TitleSmallText(
                          title: LocaleKeys.blockUser.tr(),
                          fontFamily: FontWeightEnum.w400.toInter,
                          titleColor: ColorConstants.callsPausedColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ).addPaddingXY(paddingX: 20, paddingY: 20),
      ),
    );
  }
}
