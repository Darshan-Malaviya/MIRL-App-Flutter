import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_timer_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/time_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';
import 'package:mirl/infrastructure/commons/utils/value_notifier_utils.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';
import 'package:mirl/ui/screens/multi_call_screen/arguments/multi_call_connect_request_arguments.dart';

class MultiConnectCallDialogScreen extends ConsumerStatefulWidget {
  final MultiConnectDialogArguments args;

  const MultiConnectCallDialogScreen({super.key, required this.args});

  @override
  ConsumerState createState() => _MultiConnectCallDialogScreenState();
}

class _MultiConnectCallDialogScreenState extends ConsumerState<MultiConnectCallDialogScreen> {

  Future<void> multiConnectRequestTimerFunction() async {
    await Future.delayed(const Duration(seconds: 1));
    if (multiRequestTimerNotifier.value != 0 && instanceCallEnumNotifier.value == CallTypeEnum.requestWaiting) {
      multiRequestTimerNotifier.value =  multiRequestTimerNotifier.value - 1;

      if(widget.args.userDetail?.id.toString() == SharedPrefHelper.getUserId) {
        List<int> data = ref.watch(multiConnectProvider).selectedExpertDetails.map((e) => e.id ?? 0).toList();
        ref.read(socketProvider).timerEmit(
          userId: int.parse((widget.args.userDetail?.id.toString() ?? '')),
          expertIdList: data,
          callRoleEnum: CallRoleEnum.user,
          timer:multiRequestTimerNotifier.value,
          timerType: CallTimerEnum.multiRequest, );
      }
      multiConnectRequestTimerFunction();
    } else {
      multiRequestTimerNotifier.value = -1;
      instanceCallEnumNotifier.removeListener(() {});
    }
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
   /*   await Future.delayed(Duration(minutes: 1));
      multiConnectRequestStatusNotifier.value = CallRequestStatusEnum.timeout;
      multiConnectCallEnumNotifier.value = CallTypeEnum.requestTimeout;
          ref.read(socketProvider).multiConnectStatusEmit(callStatusEnum: CallRequestStatusEnum.timeout,
          userId: widget.args.userDetail?.id.toString() ?? '',
          expertId: widget.args.expertList?.first.id.toString() ?? '',
          callRoleEnum: CallRoleEnum.user, callRequestId: SharedPrefHelper.getCallRequestId);*/

      multiRequestTimerNotifier.addListener(() {
        if (multiRequestTimerNotifier.value == 120) {
          multiConnectRequestTimerFunction();
        } else {
          if((instanceCallEnumNotifier.value == CallTypeEnum.requestWaiting && widget.args.userDetail?.id.toString() == SharedPrefHelper.getUserId)
          // || (instanceCallEnumNotifier.value == CallTypeEnum.receiverRequested && widget.args.expertId == SharedPrefHelper.getUserId)
          ) {
            if (multiRequestTimerNotifier.value == 0 && widget.args.userDetail?.id.toString() == SharedPrefHelper.getUserId) {
              instanceCallEnumNotifier.value = CallTypeEnum.requestTimeout;
              ref.read(socketProvider).multiConnectStatusEmit( callStatusEnum: CallRequestStatusEnum.timeout,
                  userId: widget.args.userDetail?.id.toString() ?? '',
                  expertId: widget.args.expertList?.first.id.toString() ?? '',
                  callRoleEnum: CallRoleEnum.user, callRequestId: SharedPrefHelper.getCallRequestId);

            }
          }
        }
      });

    });
    super.initState();
  }

  @override
  void dispose() {
    multiRequestTimerNotifier.value = -1;
    instanceCallEnumNotifier.removeListener(() {});
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
            valueListenable: multiConnectCallEnumNotifier,
            builder: (BuildContext context, CallTypeEnum value, Widget? child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  40.0.spaceY,
                  if ((multiConnectCallEnumNotifier.value == CallTypeEnum.multiCallRequest ||
                      multiConnectCallEnumNotifier.value == CallTypeEnum.multiRequestWaiting ||
                      multiConnectCallEnumNotifier.value == CallTypeEnum.multiReceiverRequested)) ...[
                    TitleLargeText(
                      title: multiConnectCallEnumNotifier.value.titleName,
                      fontSize: 20,
                      titleTextAlign: TextAlign.center,
                      titleColor: ColorConstants.primaryColor,
                    ),
                    10.0.spaceY,
                    ValueListenableBuilder(
                        valueListenable: multiRequestTimerNotifier,
                        builder: (BuildContext context, int value, Widget? child) {
                          if (multiRequestTimerNotifier.value >= 1) {
                            return DisplayLargeText(
                                title: Duration(seconds: multiRequestTimerNotifier.value).toTimeString(),
                                fontSize: 65,
                                titleColor: ColorConstants.primaryColor);
                          }
                          return SizedBox.shrink();
                        }),
                  ] else ...[
                    TitleLargeText(
                      title: multiConnectCallEnumNotifier.value.titleName,
                      fontSize: 30,
                      maxLine: 3,
                      titleTextAlign: TextAlign.center,
                      titleColor: ColorConstants.primaryColor,
                    ),
                  ],
                  16.0.spaceY,
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 330,
                        height:  360,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(RadiusConstant.alertdialogRadius),
                            color: multiConnectCallEnumNotifier.value.typeName,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 6),
                                  color: ColorConstants.borderColor.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2)
                            ]),
                      ),
                      Column(
                        children: [
                          12.0.spaceY,
                          BodySmallText(
                            title: multiConnectCallEnumNotifier.value.descriptionName,
                            titleColor: ColorConstants.textColor,
                            titleTextAlign: TextAlign.center,
                            fontFamily: FontWeightEnum.w600.toInter,
                            maxLine: 10,
                          ),
                          10.0.spaceY,
                          if (multiConnectCallEnumNotifier.value == CallTypeEnum.multiReceiverRequested) ...[
                            ShadowContainer(
                              shadowColor: ColorConstants.blackColor.withOpacity(0.25),
                              border: 25,
                              width: 95,
                              height: 122,
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 3,
                              padding: EdgeInsets.zero,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: NetworkImageWidget(
                                      imageURL: widget.args.userDetail?.userProfile ?? '',
                                      height: 90,
                                      width: 90,
                                      boxFit: BoxFit.cover,
                                    ),
                                  ),
                                  if ((widget.args.userDetail?.userName?.isNotEmpty ?? false) &&
                                      (widget.args.userDetail?.userName != 'null')) ...[
                                    10.0.spaceY,
                                    BodyMediumText(
                                      title: widget.args.userDetail?.userName ?? '',
                                      fontFamily: FontWeightEnum.w600.toInter,
                                      titleColor: ColorConstants.textColor,
                                      titleTextAlign: TextAlign.center,
                                      maxLine: 2,
                                    ),
                                  ],
                                ],
                              ).addPaddingXY(paddingX: 16, paddingY: 16),
                            ),
                          ] else ...[
                            if (widget.args.expertList?.isNotEmpty ?? false) ...[
                              SizedBox(
                                height: 204,
                                child: ListView.separated(
                                  itemCount: widget.args.expertList?.length ?? 0,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  itemBuilder: (context, index) {
                                    return ValueListenableBuilder(
                                      valueListenable: multiConnectRequestStatusNotifier,
                                        builder: (BuildContext context, CallRequestStatusEnum callRequestStatusEnum, Widget? callRequestStatusEnumChild) {
                                        print("dfghjkfghjk");
                                        print(multiConnectRequestStatusNotifier.value.callRequestStatusToString);
                                          return ShadowContainer(
                                            shadowColor: ColorConstants.blackColor.withOpacity(0.25),
                                            border: 25,
                                            width: 146,
                                            height: 204,
                                            offset: Offset(0, 4),
                                            blurRadius: 4,
                                            spreadRadius: 3,
                                            backgroundColor: multiConnectRequestStatusNotifier.value.CallReqToCardColor,
                                            padding: EdgeInsets.zero,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(2, 5),
                                                        color: ColorConstants.blackColor.withOpacity(0.3),
                                                        spreadRadius: 2,
                                                        blurRadius: 2),
                                                  ], shape: BoxShape.circle),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(50),
                                                    child: NetworkImageWidget(
                                                      imageURL: widget.args.expertList?[index].expertProfile ?? '',
                                                      boxFit: BoxFit.cover,
                                                      height: 90,
                                                      width: 90,
                                                    ),
                                                  ),
                                                ),
                                                12.0.spaceY,
                                                SizedBox(
                                                  width: 90,
                                                  child: BodyMediumText(
                                                    title: widget.args.expertList?[index].expertName ?? '',
                                                    fontFamily: FontWeightEnum.w600.toInter,
                                                    titleColor: ColorConstants.textColor,
                                                    titleTextAlign: TextAlign.center,
                                                    maxLine: 2,
                                                  ),
                                                ),
                                                2.0.spaceY,
                                                LabelSmallText(
                                                  title:
                                                  '${LocaleKeys.rating.tr()} ${widget.args.expertList?[index].overAllRating.toString() ?? "0"}',
                                                  fontFamily: FontWeightEnum.w500.toInter,
                                                  fontSize: 8,
                                                  titleColor: ColorConstants.buttonTextColor,
                                                ),
                                                2.0.spaceY,
                                                ( (widget.args.expertList?[index].fee.toString().isNotEmpty ?? false)
                                                    && (widget.args.expertList?[index].fee.toString() != "null")) ?
                                                LabelSmallText(
                                                  title:
                                                  '${LocaleKeys.feePerMinute.tr()} \$${((widget.args.expertList?[index].fee ?? 0) / 100) .toStringAsFixed(2)}',
                                                  fontFamily: FontWeightEnum.w500.toInter,
                                                  fontSize: 8,
                                                  maxLine: 2,
                                                  titleTextAlign: TextAlign.center,
                                                  titleColor: ColorConstants.buttonTextColor,
                                                ) : SizedBox.shrink(),
                                                2.0.spaceY,
                                                BodyMediumText(
                                                  title: multiConnectRequestStatusNotifier.value.callRequestStatusToString,
                                                  titleColor: multiConnectRequestStatusNotifier.value.CallReqToStatusColor,
                                                )
                                              ],
                                            ).addPaddingXY(paddingX: 20, paddingY: 4),
                                          );
                                      }
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) => 16.0.spaceX,
                                ),
                              ),
                            ] else ... [
                              Center(
                                child: BodyLargeText(
                                  title: "Not expert available!",
                                  fontFamily: FontWeightEnum.w600.toInter,
                                ),
                              ),
                            ],
                          ],
                          8.0.spaceY,
                          ValueListenableBuilder(
                              valueListenable: allCallDurationNotifier,
                              builder: (BuildContext context, int value, Widget? child) {
                                return Visibility(
                                  visible: allCallDurationNotifier.value != 0 && (multiConnectCallEnumNotifier.value == CallTypeEnum.requestWaiting
                                      || multiConnectCallEnumNotifier.value == CallTypeEnum.receiverRequested),
                                  replacement: SizedBox.shrink(),
                                  child: TitleSmallText(
                                    title: "${LocaleKeys.duration.tr()} : ${(allCallDurationNotifier.value / 60).toStringAsFixed(0)} minutes",
                                    fontFamily: FontWeightEnum.w400.toInter,
                                    titleTextAlign: TextAlign.center,
                                    titleColor: ColorConstants.textColor,
                                  ),
                                );
                              }
                          ),
                          10.0.spaceY,
                          (multiConnectCallEnumNotifier.value == CallTypeEnum.multiRequestWaiting ||
                                  multiConnectCallEnumNotifier.value == CallTypeEnum.multiRequestApproved ||
                                  multiConnectCallEnumNotifier.value == CallTypeEnum.multiRequestDeclined)
                              ? Center(
                                  child: PrimaryButton(
                                    title: multiConnectCallEnumNotifier.value.secondButtonName,
                                    width: 130,
                                    onPressed: widget.args.onSecondBtnTap ?? () => Navigator.pop(context),
                                    buttonColor:  ColorConstants.primaryColor,
                                    titleColor: ColorConstants.textColor,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: PrimaryButton(
                                        title: multiConnectCallEnumNotifier.value.secondButtonName,
                                        // width: 130,
                                        onPressed: widget.args.onSecondBtnTap ?? () => Navigator.pop(context),
                                        buttonColor: (multiConnectCallEnumNotifier.value == CallTypeEnum.multiReceiverRequested)
                                            ? ColorConstants.yellowButtonColor : ColorConstants.primaryColor,
                                        titleColor: ColorConstants.textColor,
                                      ),
                                    ).addVisibility(multiConnectCallEnumNotifier.value.secondButtonName.isNotEmpty),
                                    8.0.spaceX,
                                    Flexible(
                                      child: PrimaryButton(
                                        //width: 130,
                                        title: multiConnectCallEnumNotifier.value.firstButtonName,
                                        onPressed: widget.args.onFirstBtnTap ?? () {},
                                        buttonColor: ColorConstants.primaryColor,
                                        titleColor: ColorConstants.textColor,
                                      ),
                                    ).addVisibility(multiConnectCallEnumNotifier.value.firstButtonName.isNotEmpty)
                                  ],
                                ).addPaddingX(40),

                        ],
                      ),
                    ],
                  ),
                  30.0.spaceY,
                  Visibility(
                    visible: multiConnectCallEnumNotifier.value == CallTypeEnum.multiRequestDeclined ||
                        multiConnectCallEnumNotifier.value == CallTypeEnum.multiRequestTimeout ||
                        multiConnectCallEnumNotifier.value == CallTypeEnum.multiReceiverRequested,
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
                    visible: multiConnectCallEnumNotifier.value == CallTypeEnum.multiReceiverRequested,
                    replacement: SizedBox.shrink(),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          NavigationService.context.toPushNamed(RoutesConstants.blockUserScreen,
                              args: BlockUserArgs(
                                  userName: widget.args.userDetail?.userName ?? '',
                                  imageURL: widget.args.userDetail?.userProfile ?? '',
                                  userId: int.parse(widget.args.userDetail?.id.toString() ?? ''),
                                  userRole: 2,
                                  reportName: '',
                                  isFromInstantCall: true));
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
              ).addMarginXY(marginX: 20, marginY: 20);
            }),
      ),
    );
  }
}
