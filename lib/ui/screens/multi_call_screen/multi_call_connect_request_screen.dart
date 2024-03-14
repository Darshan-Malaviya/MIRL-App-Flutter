import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_timer_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/string_extention.dart';
import 'package:mirl/infrastructure/commons/extensions/time_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';
import 'package:mirl/ui/screens/multi_call_screen/arguments/multi_call_connect_request_arguments.dart';
import 'package:shimmer/shimmer.dart';

class MultiConnectCallDialogScreen extends ConsumerStatefulWidget {
  final MultiConnectDialogArguments args;

  const MultiConnectCallDialogScreen({super.key, required this.args});

  @override
  ConsumerState createState() => _MultiConnectCallDialogScreenState();
}

class _MultiConnectCallDialogScreenState extends ConsumerState<MultiConnectCallDialogScreen> {

  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    multiRequestTimerNotifier = ValueNotifier<int>(60);
    _timer = new Timer.periodic(
      Duration(seconds: 1), (Timer timer)  {
        if(multiRequestTimerNotifier.value == 0){
          timer.cancel();
          _timer?.cancel();
          if(widget.args.userDetail?.id.toString() == SharedPrefHelper.getUserId.toString()) {
            /// time out
            ref.read(socketProvider).multiConnectStatusEmit(callStatusEnum: CallRequestStatusEnum.timeout,
                userId: widget.args.userDetail?.id.toString() ?? '',
                expertId: null,
                callRoleEnum: CallRoleEnum.user, callRequestId: SharedPrefHelper.getCallRequestId);
          }
        } else {
          multiRequestTimerNotifier.value = multiRequestTimerNotifier.value - 1;
          if(widget.args.userDetail?.id.toString() == SharedPrefHelper.getUserId) {
            List<int> data = ref.watch(multiConnectProvider).selectedExpertDetails.map((e) => e.id ?? 0).toList();
            ref.read(socketProvider).timerEmit(
              userId: int.parse((widget.args.userDetail?.id.toString() ?? '')),
              expertIdList: data,
              callRoleEnum: CallRoleEnum.user,
              timer:multiRequestTimerNotifier.value,
              timerType: CallTimerEnum.multiRequest, requestType: 2, );
          }
        }

    },
    );
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      multiConnectCallEnumNotifier.addListener(() {
        if(multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiRequestWaiting) {
          startTimer();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    multiConnectCallEnumNotifier.dispose();
    multiRequestTimerNotifier.dispose();
    multiRequestTimerNotifier = ValueNotifier<int>(60);
    multiConnectCallEnumNotifier = ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.multiCallRequest);
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final multiProviderWatch = ref.watch(multiConnectProvider);
    final multiProviderRead = ref.read(multiConnectProvider);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBarWidget(
          preferSize: 0,
        ),
        backgroundColor: ColorConstants.whiteColor,
        body: ValueListenableBuilder(
            valueListenable: multiConnectCallEnumNotifier,
            builder: (BuildContext context, CallRequestTypeEnum value, Widget? child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  40.0.spaceY,
                  if ((multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiCallRequest ||
                      multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiRequestWaiting ||
                      multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiReceiverRequested)) ...[
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
                          return DisplayLargeText(
                              title: Duration(seconds: multiRequestTimerNotifier.value).toTimeString(),
                              fontSize: 65,
                              titleColor: ColorConstants.primaryColor);
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
                        width: 340,
                        height:  400,
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

                          if (multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiReceiverRequested) ...[
                            ShadowContainer(
                              shadowColor: ColorConstants.blackColor.withOpacity(0.5),
                              border: 25,
                              width: 136,
                              height: 180,
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

                            if (multiProviderWatch.selectedExpertDetails.isNotEmpty) ...[
                              10.0.spaceY,
                              SizedBox(
                                height: 230,
                                child: ListView.separated(
                                  itemCount: multiProviderWatch.selectedExpertDetails.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  itemBuilder: (context, index) {
                                    return ValueListenableBuilder(
                                      valueListenable: multiConnectRequestStatusNotifier,
                                        builder: (BuildContext context, CallRequestStatusEnum callRequestStatusEnum, Widget? callRequestStatusEnumChild) {
                                        if(chooseMultiConnectExpert.value){
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius : BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                topRight: Radius.circular(25),
                                                bottomLeft: Radius.circular(25),
                                                bottomRight: Radius.circular(25),
                                              ),
                                              boxShadow : [BoxShadow(
                                                  color: ColorConstants.blackColor.withOpacity(0.25),
                                                  offset: Offset(0,1),
                                                  blurRadius: 8,
                                                  spreadRadius: 1
                                              )],
                                              color : ColorConstants.borderLightColor,
                                            ),
                                            width: 150,
                                            height: 220,
                                            padding: EdgeInsets.zero,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20.0),
                                              child: Shimmer.fromColors(
                                                baseColor: ColorConstants.borderLightColor,
                                                highlightColor: ColorConstants.greyLightColor,
                                                child: ShadowContainer(
                                                  width: 150,
                                                  height: 200,
                                                  isShadow: false,
                                                  border: 25,
                                                  child: Container(),
                                                ),
                                              ),
                                            ).addPaddingY(4),
                                          );
                                        }
                                          return InkWell(
                                            onTap: (){
                                              /// is status is accept or not chosen then that expert can be able for connect call
                                              if(multiProviderWatch.selectedExpertDetails[index].status.toString() == "2"
                                              || multiProviderWatch.selectedExpertDetails[index].status.toString() == "7"){
                                                multiProviderRead.setSelectedExpertForCall(multiProviderWatch.selectedExpertDetails[index]);
                                                multiProviderRead.setSelectedExpertForCall(multiProviderWatch.selectedExpertDetails[index]);
                                                // multiConnectCallEnumNotifier.value = CallTypeEnum.multiRequestApproved;
                                               // CustomLoading.progressDialog(isLoading: true);
                                                chooseMultiConnectExpert.value = true;
                                                ref.read(socketProvider).multiConnectStatusEmit(callStatusEnum: CallRequestStatusEnum.choose,
                                                    expertId: multiProviderWatch.selectedExpertForCall?.id.toString() ?? '',
                                                    userId: SharedPrefHelper.getUserId,
                                                    callRoleEnum: CallRoleEnum.user,
                                                    callRequestId: SharedPrefHelper.getCallRequestId.toString());
                                              }

                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius : BorderRadius.only(
                                                    topLeft: Radius.circular(25),
                                                    topRight: Radius.circular(25),
                                                    bottomLeft: Radius.circular(25),
                                                    bottomRight: Radius.circular(25),
                                                  ),
                                                  boxShadow : [BoxShadow(
                                                      color: ColorConstants.blackColor.withOpacity(0.25),
                                                      offset: Offset(0,1),
                                                      blurRadius: 8,
                                                    spreadRadius: 1
                                                  )],
                                                    color :multiProviderWatch.selectedExpertDetails[index].status.toString().numberToCallRequestStatusBGColor(),
                                                ),
                                              width: 150,
                                              height: 220,
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
                                                        imageURL: multiProviderWatch.selectedExpertDetails[index].expertProfile ?? '',
                                                        boxFit: BoxFit.cover,
                                                        height: 90,
                                                        width: 90,
                                                      ),
                                                    ),
                                                  ),
                                                  12.0.spaceY,
                                                  SizedBox(
                                                    width: 90,
                                                    height: 40,
                                                    child: BodyMediumText(
                                                      title: multiProviderWatch.selectedExpertDetails[index].expertName ?? '',
                                                      fontFamily: FontWeightEnum.w600.toInter,
                                                      titleColor: ColorConstants.textColor,
                                                      titleTextAlign: TextAlign.center,
                                                      maxLine: 2,
                                                    ),
                                                  ),
                                                  2.0.spaceY,
                                                  ( (multiProviderWatch.selectedExpertDetails[index].overAllRating.toString().isNotEmpty)
                                                      && (multiProviderWatch.selectedExpertDetails[index].overAllRating.toString() != "null")) ?
                                                  LabelSmallText(
                                                    title:
                                                    '${LocaleKeys.rating.tr()} ${multiProviderWatch.selectedExpertDetails[index].overAllRating.toString()}',
                                                    fontFamily: FontWeightEnum.w500.toInter,
                                                    fontSize: 8,
                                                    titleColor: ColorConstants.buttonTextColor,
                                                  ) : LabelSmallText(
                                                    title:
                                                    '${LocaleKeys.rating.tr()} 0',
                                                    fontFamily: FontWeightEnum.w500.toInter,
                                                    fontSize: 8,
                                                    titleColor: ColorConstants.buttonTextColor,
                                                  ),
                                                  2.0.spaceY,
                                                  ( (multiProviderWatch.selectedExpertDetails[index].fee.toString().isNotEmpty)
                                                      && (multiProviderWatch.selectedExpertDetails[index].fee.toString() != "null")) ?
                                                  LabelSmallText(
                                                    title:
                                                    '${LocaleKeys.feePerMinute.tr()} \$${((multiProviderWatch.selectedExpertDetails[index].fee ?? 0) / 100) .toStringAsFixed(2)}',
                                                    fontFamily: FontWeightEnum.w500.toInter,
                                                    fontSize: 8,
                                                    maxLine: 2,
                                                    titleTextAlign: TextAlign.center,
                                                    titleColor: ColorConstants.buttonTextColor,
                                                  ) : SizedBox.shrink(),
                                                  4.0.spaceY,
                                                  BodyMediumText(
                                                    title: multiProviderWatch.selectedExpertDetails[index].status.toString().callRequestStatusToString(),
                                                    titleColor: multiProviderWatch.selectedExpertDetails[index].status.toString().numberToCallRequestStatusColor(),
                                                  )
                                                ],
                                              ).addPaddingY(4),
                                            ),
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
                                  title: "No expert available!",
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
                                  visible: allCallDurationNotifier.value != 0 /*&& (multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiRequestWaiting
                                      || multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiReceiverRequested)*/,
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
                          (multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiCallRequest ||
                                  multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiReceiverRequested)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: PrimaryButton(
                                        title: multiConnectCallEnumNotifier.value.secondButtonName,
                                        // width: 130,
                                        onPressed: widget.args.onSecondBtnTap ?? () => Navigator.pop(context),
                                        buttonColor:
                                            (multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiReceiverRequested)
                                                ? ColorConstants.yellowButtonColor
                                                : ColorConstants.primaryColor,
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
                                ).addPaddingX(40)
                              : Center(
                                  child: PrimaryButton(
                                    title: multiConnectCallEnumNotifier.value.secondButtonName,
                                    width: 160,
                                    onPressed: widget.args.onSecondBtnTap ?? () => Navigator.pop(context),
                                    buttonColor: ColorConstants.primaryColor,
                                    titleColor: ColorConstants.textColor,
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  30.0.spaceY,
                  Visibility(
                    visible: multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiRequestDeclined ||
                        multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiRequestTimeout ||
                        multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiReceiverRequested,
                    replacement: SizedBox.shrink(),
                    child: TitleSmallText(
                      title: multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiReceiverRequested
                          ? LocaleKeys.multiConnectReceiver.tr()
                          : LocaleKeys.viewOtherExpert.tr(),
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleTextAlign: TextAlign.center,
                      titleColor: ColorConstants.textColor,
                    ),
                  ),
                  20.0.spaceY,
                  Visibility(
                    visible: multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiReceiverRequested,
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
