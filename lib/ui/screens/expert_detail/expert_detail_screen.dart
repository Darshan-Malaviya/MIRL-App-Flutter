import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_status_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/providers/expert_detail_provider.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
import 'package:mirl/ui/common/button_widget/fees_action_button.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';
import 'package:mirl/ui/screens/expert_detail/widget/area_of_expertise_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/rating_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/request_call_button_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/certifications_and_experience_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_rating_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_widget.dart';
import 'package:mirl/ui/screens/instant_call_screen/arguments/instance_call_dialog_arguments.dart';
import 'package:parsed_readmore/parsed_readmore.dart';

ValueNotifier<bool> isFavorite = ValueNotifier(false);

class ExpertDetailScreen extends ConsumerStatefulWidget {
  final String expertId;

  const ExpertDetailScreen({super.key, required this.expertId});

  @override
  ConsumerState<ExpertDetailScreen> createState() => _ExpertDetailScreenState();
}

class _ExpertDetailScreenState extends ConsumerState<ExpertDetailScreen> {
  int duration = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(expertDetailProvider).getExpertDetailApiCall(userId: widget.expertId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expertDetailWatch = ref.watch(expertDetailProvider);
    final expertDetailRead = ref.read(expertDetailProvider);
    return RefreshIndicator(
      color: ColorConstants.primaryColor,
      onRefresh: () async {
        ref.read(expertDetailProvider).getExpertDetailApiCall(userId: widget.expertId);
      },
      child: Scaffold(
        appBar: AppBarWidget(
          preferSize: 40,
          leading: InkWell(
            child: Image.asset(ImageConstants.backIcon),
            onTap: () => context.toPop(),
          ),
          trailingIcon: InkWell(
                  onTap: () {
                    //ReportThisUserWidget();
                    // context.toPushNamed(RoutesConstants.demoReportUserScreen,
                    //     args: BlockUserArgs(
                    //         userRole: 1,
                    //         reportName: 'REPORT THIS EXPERT',
                    //         expertId: widget.expertId,
                    //         imageURL: expertDetailWatch.userData?.expertProfile ?? ''));
                    context.toPushNamed(RoutesConstants.reportExpertScreen,
                        args: BlockUserArgs(reportName: 'REPORT THIS EXPERT', userRole: 1, expertId: widget.expertId, imageURL: expertDetailWatch.userData?.expertProfile ?? ''));
                  },
                  child: Icon(Icons.more_horiz))
              .addPaddingRight(14),
        ),
        body: Stack(
          children: [
            NetworkImageWidget(
              imageURL: expertDetailWatch.userData?.expertProfile ?? '',
              isNetworkImage: true,
              boxFit: BoxFit.cover,
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: InkWell(
                onTap: () async {
                  await expertDetailRead.favoriteRequestCall(expertDetailWatch.userData?.id ?? 0);
                  ref.read(homeProvider).manageFavoriteUserList(
                        expertId: expertDetailWatch.userData?.id ?? 0,
                        expertName: expertDetailWatch.userData?.expertName ?? '',
                        expertProfile: expertDetailWatch.userData?.expertProfile ?? '',
                        isFavorite: expertDetailWatch.userData?.isFavorite ?? false,
                      );
                },
                child: Image.asset(
                  expertDetailWatch.userData?.isFavorite ?? false ? ImageConstants.like : ImageConstants.dislike,
                  height: 40,
                  width: 40,
                ),
              ),
            ).addAllPadding(15),
            DraggableScrollableSheet(
              initialChildSize: 0.55,
              minChildSize: 0.55,
              maxChildSize: 0.90,
              builder: (BuildContext context, myScrollController) {
                return bottomSheetView(controller: myScrollController);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheetView({required ScrollController controller}) {
    final expertDetailWatch = ref.watch(expertDetailProvider);

    String? fee;
    if (expertDetailWatch.userData?.fee != null) {
      double data = (expertDetailWatch.userData?.fee?.toDouble() ?? 0.0) / 100;
      fee = data.toStringAsFixed(2);
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50)),
        color: ColorConstants.whiteColor,
      ),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: HeadlineMediumText(
                title: expertDetailWatch.userData?.expertName ?? '',
                fontSize: 28,
                titleColor: ColorConstants.bottomTextColor,
              ),
            ),
            22.0.spaceY,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    BodySmallText(
                      title: LocaleKeys.overAllRating.tr(),
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleTextAlign: TextAlign.center,
                    ),
                    10.0.spaceX,
                    AutoSizeText(
                      expertDetailWatch.userData?.overAllRating != 0 ? expertDetailWatch.userData?.overAllRating.toString() ?? '' : LocaleKeys.newText.tr(),
                      maxLines: 1,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorConstants.overallRatingColor,
                        shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.2))],
                      ),
                    )
                  ],
                ),
                40.0.spaceX,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BodySmallText(
                      title: LocaleKeys.feesPerMinute.tr(),
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleTextAlign: TextAlign.center,
                    ),
                    10.0.spaceX,
                    AutoSizeText(
                      fee != null ? '\$${fee}' : LocaleKeys.proBono.tr(),
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorConstants.overallRatingColor,
                        shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.2))],
                      ),
                    )
                  ],
                ),
              ],
            ),
            if (expertDetailWatch.userData?.about?.isNotEmpty ?? false) ...[
              35.0.spaceY,
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TitleMediumText(
                  title: StringConstants.moreAboutMe,
                  titleColor: ColorConstants.blueColor,
                ),
              ),
              8.0.spaceY,
              // LinkWell(expertDetailWatch.userData?.about ?? '',
              //     maxLines: 100,
              //     style: TextStyle(
              //       color: ColorConstants.blackColor,
              //       fontFamily: FontWeightEnum.w400.toInter,
              //       fontSize: 16,
              //     ),
              //     linkStyle: TextStyle(
              //       color: ColorConstants.bottomTextColor,
              //       fontFamily: FontWeightEnum.w400.toInter,
              //       fontSize: 16,
              //     )),
              ParsedReadMore(
                style: TextStyle(fontSize: 16, fontFamily: FontWeightEnum.w400.toInter,color: ColorConstants.bottomTextColor),
                expertDetailWatch.userData?.about ?? '',
                trimLines: 15,
                //trimMode: TrimMode.Line,
                trimCollapsedText: LocaleKeys.readMore.tr(),
                trimExpandedText: ' ${LocaleKeys.readLess.tr()}',
                moreStyle: TextStyle(fontSize: 16, color: ColorConstants.bottomTextColor.withOpacity(0.7)),
                lessStyle: TextStyle(fontSize: 16, color: ColorConstants.bottomTextColor.withOpacity(0.7)),
              ),
              36.0.spaceY,
            ],
            AreaOfExpertiseWidget(),
            ExpertDetailsButtonWidget(
              titleColor: expertDetailWatch.userData?.onlineStatus == 1 ? ColorConstants.buttonTextColor : ColorConstants.overAllRatingColor,
              title: expertDetailWatch.userData?.onlineStatus == 1 ? StringConstants.requestCallNow : LocaleKeys.callPaused.tr(),
              suffixTitle: expertDetailWatch.userData?.onlineStatus == 1 ? LocaleKeys.expertOnline.tr() : LocaleKeys.expertOffline.tr(),
              buttonColor: expertDetailWatch.userData?.onlineStatus == 1 ? ColorConstants.requestCallNowColor : ColorConstants.redLightColor,
              onTap: () {
                if(expertDetailWatch.userData?.onlineStatus == 1) {
                  CommonBottomSheet.bottomSheet(
                      context: context,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: CallDurationBottomSheetView(expertName: expertDetailWatch.userData?.expertName ?? '', onPressed: () {
                        context.toPop();
                        allCallDurationNotifier.value = expertDetailWatch.callDuration * 60;
                        if ((expertDetailWatch.userData?.instantCallAvailable ?? false) && (expertDetailWatch.userData?.onlineStatus.toString() == '1')) {
                          instanceCallEnumNotifier.value = CallRequestTypeEnum.callRequest;
                          /// THis is call sender (User) side
                          context.toPushNamed(RoutesConstants.instantCallRequestDialogScreen,
                              args: InstanceCallDialogArguments(
                                name: expertDetailWatch.userData?.expertName ?? "",
                                onFirstBtnTap: () {
                                  if (instanceCallEnumNotifier.value == CallRequestTypeEnum.requestTimeout) {
                                    instanceRequestTimerNotifier.dispose();
                                   manageTimeOutStatus(userData: expertDetailWatch.userData, expertId: widget.expertId, context: context, expertDetailWatch : expertDetailWatch);
                                  } else {
                                    ref.read(socketProvider).instanceCallRequestEmit(expertId: widget.expertId, requestedDuration: (expertDetailWatch.callDuration * 60));
                                  }
                                },
                                onSecondBtnTap: () {
                                  if (instanceCallEnumNotifier.value.secondButtonName == LocaleKeys.goBack.tr().toUpperCase()) {
                                    context.toPop();
                                  } else if (instanceCallEnumNotifier.value == CallRequestTypeEnum.requestApproved) {
                                    CommonBottomSheet.bottomSheet(
                                        context: context,
                                        child: CallPaymentBottomSheetView(onPressed: () {
                                          context.toPop();
                                          ref.read(socketProvider).connectCallEmit(expertId: widget.expertId);
                                        }),
                                        isDismissible: true);
                                    ///context.toPop();
                                  } else {
                                    ref.read(socketProvider).updateRequestStatusEmit(
                                        callStatusEnum: CallRequestStatusEnum.cancel,
                                        expertId: widget.expertId,
                                        callRoleEnum: CallRoleEnum.user,
                                        userId: SharedPrefHelper.getUserId.toString());
                                    context.toPop();
                                  }
                                },
                                image: expertDetailWatch.userData?.expertProfile ?? "",
                                expertId: expertDetailWatch.userData?.id.toString() ?? '',
                                userID: SharedPrefHelper.getUserId.toString(),
                              ));
                        } else {
                          FlutterToast().showToast(msg: LocaleKeys.expertNotAvailable.tr());
                        }
                      }),
                      isDismissible: true);
                } else {
                  FlutterToast().showToast(msg: LocaleKeys.expertNotAvailable.tr());
                }
              },
            ),
            24.0.spaceY,
            PrimaryButton(
              title: StringConstants.scheduleCall,
              onPressed: () {
                context.toPushNamed(RoutesConstants.scheduleCallScreen, args: CallArgs(expertData: expertDetailWatch.userData));
              },
              buttonColor: ColorConstants.yellowButtonColor,
              titleColor: ColorConstants.buttonTextColor,
            ),
            40.0.spaceY,
            CertificationAndExperienceWidget(),
            if (expertDetailWatch.userData?.isLocationVisible == true) ...[
              40.0.spaceY,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: LocaleKeys.location.tr(),
                      style: TextStyle(
                        color: ColorConstants.blueColor,
                        fontFamily: FontWeightEnum.w700.toInter,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: '${expertDetailWatch.userData?.city ?? ''}, ${expertDetailWatch.userData?.country ?? ''}',
                      style: TextStyle(
                        color: ColorConstants.blueColor,
                        fontSize: 16,
                        fontFamily: FontWeightEnum.w400.toInter,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
            ]else...[
              40.0.spaceY,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: LocaleKeys.location.tr(),
                      style: TextStyle(
                        color: ColorConstants.blueColor,
                        fontFamily: FontWeightEnum.w700.toInter,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: LocaleKeys.earthBased.tr(),
                      style: TextStyle(
                        color: ColorConstants.blueColor,
                        fontSize: 16,
                        fontFamily: FontWeightEnum.w400.toInter,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
            ],
            if (expertDetailWatch.userData?.gender != null) ...[
              35.0.spaceY,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: LocaleKeys.gender.tr(),
                      style: TextStyle(
                        color: ColorConstants.blueColor,
                        fontFamily: FontWeightEnum.w700.toInter,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: expertDetailWatch.userGender(),
                      style: TextStyle(
                        color: ColorConstants.blueColor,
                        fontSize: 16,
                        fontFamily: FontWeightEnum.w400.toInter,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
              40.0.spaceY,
            ],
            Center(child: Image.asset(ImageConstants.line)),
            40.0.spaceY,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleMediumText(
                  title: StringConstants.reviewsAndRatting,
                  titleTextAlign: TextAlign.start,
                  titleColor: ColorConstants.blueColor,
                ),
                OnScaleTap(
                  onPress: () => context.toPushNamed(RoutesConstants.ratingAndReviewScreen, args: expertDetailWatch.userData?.id),
                  child: TitleSmallText(title: LocaleKeys.seeAll.tr(), titleColor: ColorConstants.greyColor),
                )
              ],
            ),
            26.0.spaceY,
            ReviewsAndRatingWidget(
              title: StringConstants.overallRating,
              buttonColor: ColorConstants.yellowButtonColor,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: expertDetailWatch.userData?.overAllRating?.toString() ?? '0',
                        style: TextStyle(
                          color: ColorConstants.overAllRatingColor,
                          fontSize: 30,
                          height: 0.05,
                          letterSpacing: -0.33,
                        ),
                      ),
                      TextSpan(
                        text: '/10',
                        style: TextStyle(
                          color: ColorConstants.overAllRatingColor,
                          fontSize: 18,
                          height: 0.08,
                          letterSpacing: -0.20,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            26.0.spaceY,
            if (expertDetailWatch.userData?.ratingCriteria?.isNotEmpty ?? false) ...[
              OverallRatingWidget(name: RatingEnum.EXPERTISE.name, value: expertDetailWatch.userData?.ratingCriteria?[0].rating ?? 0),
              OverallRatingWidget(name: RatingEnum.COMMUNICATION.name, value: expertDetailWatch.userData?.ratingCriteria?[1].rating ?? 0),
              OverallRatingWidget(name: RatingEnum.HELPFULNESS.name, value: expertDetailWatch.userData?.ratingCriteria?[2].rating ?? 0),
              OverallRatingWidget(name: RatingEnum.EMPATHY.name, value: expertDetailWatch.userData?.ratingCriteria?[3].rating ?? 0),
              OverallRatingWidget(name: RatingEnum.PROFESSIONALISM.name, value: expertDetailWatch.userData?.ratingCriteria?[4].rating ?? 0),
            ],
            if (expertDetailWatch.userData?.expertReviews?.isNotEmpty ?? false) ...[
              40.0.spaceY,
              ReviewsAndRatingWidget(
                title: StringConstants.reviews,
                buttonColor: ColorConstants.yellowButtonColor,
                child: SizedBox.shrink(),
              ),
              30.0.spaceY,
              ReviewWidget(reviews: expertDetailWatch.userData?.expertReviews ?? []),
            ],
            20.0.spaceY,
          ],
        ),
      ).addAllPadding(28),
    );
  }

/*  Widget bottomSheetViewForCallDuration({required String expertName,required void Function() onPressed , required ExpertDetailProvider expertDetailProvider, }) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        HeadlineMediumText(
          title: expertName,
          fontSize: 30,
          titleColor: ColorConstants.bottomTextColor,
        ),
        22.0.spaceY,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FeesActionButtonWidget(
              onTap: () => expertDetailProvider.decrementCallDuration(),
              icons: ImageConstants.minus,
              isDisable: expertDetailProvider.callDuration == 10,
            ),
            20.0.spaceX,
            PrimaryButton(
              height: 45,
              width: 148,
              title: '${expertDetailProvider.callDuration} ${LocaleKeys.minutes.tr()}',
              onPressed: () {},
              buttonColor: ColorConstants.buttonColor,
            ),
            20.0.spaceX,
            FeesActionButtonWidget(
              onTap: () => expertDetailProvider.incrementCallDuration(),
              icons: ImageConstants.plus,
              isDisable: expertDetailProvider.callDuration == 30,
            ),
          ],
        ),
        20.0.spaceY,
        BodyMediumText(
          title: LocaleKeys.scheduleAppointment.tr(),
          fontSize: 15,
          titleColor: ColorConstants.blueColor,
        ),
        20.0.spaceY,
        PrimaryButton(
          height: 45,
          width: 148,
          title: '${allCallDurationNotifier.value.toString()} ${LocaleKeys.minutes.tr()}',
          onPressed: () {},
          buttonColor: ColorConstants.buttonColor,
        ),
        20.0.spaceY,
        BodySmallText(title: '${LocaleKeys.maxCallDuration.tr()} 30 ${LocaleKeys.minutes.tr()}', fontFamily: FontWeightEnum.w500.toInter),
        20.0.spaceY,
        PrimaryButton(
          height: 55,
          title: 'Done',
          margin: EdgeInsets.symmetric(horizontal: 10),
          fontSize: 18,
          onPressed: (){
            allCallDurationNotifier.value = duration;
            onPressed();
          },
        ),
      ],
    ).addAllPadding(28);
  }*/

  void manageTimeOutStatus({required UserData? userData, required BuildContext context , required String expertId, required ExpertDetailProvider expertDetailWatch}) {
    context.toPop();
    instanceRequestTimerNotifier = ValueNotifier<int>(120);
    instanceCallEnumNotifier = ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.callRequest);
    instanceCallEnumNotifier.value = CallRequestTypeEnum.callRequest;
    /// THis is call sender (User) side
    CommonBottomSheet.bottomSheet(
        context: context,
        height: MediaQuery.of(context).size.height * 0.5,
        child: CallDurationBottomSheetView(expertName: expertDetailWatch.userData?.expertName ?? '', onPressed: () {
          context.toPop();
          allCallDurationNotifier.value = expertDetailWatch.callDuration;
          if ((expertDetailWatch.userData?.instantCallAvailable ?? false) && (expertDetailWatch.userData?.onlineStatus.toString() == '1')) {
            instanceCallEnumNotifier.value = CallRequestTypeEnum.callRequest;
            /// THis is call sender (User) side
            context.toPushNamed(RoutesConstants.instantCallRequestDialogScreen,
                args: InstanceCallDialogArguments(
                  name: expertDetailWatch.userData?.expertName ?? "",
                  onFirstBtnTap: () {
                    if (instanceCallEnumNotifier.value == CallRequestTypeEnum.requestTimeout) {
                      instanceRequestTimerNotifier.dispose();
                      manageTimeOutStatus(userData: expertDetailWatch.userData, expertId: widget.expertId, context: context, expertDetailWatch: expertDetailWatch);
                    } else {
                      ref.read(socketProvider).instanceCallRequestEmit(expertId: widget.expertId, requestedDuration: (expertDetailWatch.callDuration * 60) );
                    }
                  },
                  onSecondBtnTap: () {
                    if (instanceCallEnumNotifier.value.secondButtonName == LocaleKeys.goBack.tr().toUpperCase()) {
                      context.toPop();
                    } else if (instanceCallEnumNotifier.value == CallRequestTypeEnum.requestApproved) {
                      CommonBottomSheet.bottomSheet(
                          context: context,
                          child: CallPaymentBottomSheetView(onPressed: () {
                            context.toPop();
                            ref.read(socketProvider).connectCallEmit(expertId: widget.expertId);
                          }),
                          isDismissible: true);
                      ///context.toPop();
                    } else {
                      ref.read(socketProvider).updateRequestStatusEmit(
                          callStatusEnum: CallRequestStatusEnum.cancel,
                          expertId: widget.expertId,
                          callRoleEnum: CallRoleEnum.user,
                          userId: SharedPrefHelper.getUserId.toString());
                      context.toPop();
                    }
                  },
                  image: expertDetailWatch.userData?.expertProfile ?? "",
                  expertId: expertDetailWatch.userData?.id.toString() ?? '',
                  userID: SharedPrefHelper.getUserId.toString(),
                ));
          } else {
            FlutterToast().showToast(msg: LocaleKeys.expertNotAvailable.tr());
          }
        }),
        isDismissible: true);
  }

}

class CallDurationBottomSheetView extends ConsumerStatefulWidget {
  final  String expertName;
  final void Function() onPressed;
  const CallDurationBottomSheetView({required this.expertName, required this.onPressed, super.key});

  @override
  ConsumerState createState() => _CallDurationBottomSheetViewState();
}

class _CallDurationBottomSheetViewState extends ConsumerState<CallDurationBottomSheetView> {

  @override
  Widget build(BuildContext context) {
    final expertDetailProviderWatch = ref.watch(expertDetailProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        HeadlineMediumText(
          title: widget.expertName,
          fontSize: 30,
          titleColor: ColorConstants.bottomTextColor,
        ),
        20.0.spaceY,
        BodyMediumText(
          title: "Please select call duration",
          fontSize: 15,
          titleColor: ColorConstants.blueColor,
        ),
        22.0.spaceY,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FeesActionButtonWidget(
              onTap: () => expertDetailProviderWatch.decrementCallDuration(),
              icons: ImageConstants.minus,
              isDisable: expertDetailProviderWatch.callDuration == 10,
            ),
            20.0.spaceX,
            PrimaryButton(
              height: 45,
              width: 148,
              title: '${expertDetailProviderWatch.callDuration} ${LocaleKeys.minutes.tr()}',
              onPressed: () {},
              buttonColor: ColorConstants.buttonColor,
            ),
            20.0.spaceX,
            FeesActionButtonWidget(
              onTap: () => expertDetailProviderWatch.incrementCallDuration(),
              icons: ImageConstants.plus,
              isDisable: expertDetailProviderWatch.callDuration == 30,
            ),
          ],
        ),
        20.0.spaceY,
        BodySmallText(title: '${LocaleKeys.maxCallDuration.tr()} 30 ${LocaleKeys.minutes.tr()}', fontFamily: FontWeightEnum.w500.toInter),
        20.0.spaceY,
        PrimaryButton(
          height: 55,
          title: 'Done',
          margin: EdgeInsets.symmetric(horizontal: 10),
          fontSize: 18,
          onPressed: widget.onPressed,
        ),
      ],
    ).addAllPadding(28);
  }
}


class CallPaymentBottomSheetView extends ConsumerStatefulWidget {
  final void Function() onPressed;
  const CallPaymentBottomSheetView({required this.onPressed, super.key});

  @override
  ConsumerState createState() => _CallPaymentBottomSheetViewState();
}

class _CallPaymentBottomSheetViewState extends ConsumerState<CallPaymentBottomSheetView> {

  @override
  Widget build(BuildContext context) {
    final expertDetailProviderWatch = ref.watch(expertDetailProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        HeadlineMediumText(
          title: expertDetailProviderWatch.userData?.expertName ?? '',
          fontSize: 30,
          titleColor: ColorConstants.bottomTextColor,
        ),
        22.0.spaceY,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                BodySmallText(
                  title: LocaleKeys.overAllRating.tr(),
                  fontFamily: FontWeightEnum.w400.toInter,
                  titleTextAlign: TextAlign.center,
                ),
                10.0.spaceX,
                AutoSizeText(
                  expertDetailProviderWatch.userData?.overAllRating != 0 ? expertDetailProviderWatch.userData?.overAllRating.toString() ?? '0' : LocaleKeys.newText.tr(),
                  maxLines: 1,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorConstants.overallRatingColor,
                    shadows: [Shadow(offset: Offset(0, 3), blurRadius: 4, color: ColorConstants.blackColor.withOpacity(0.3))],
                  ),
                )
              ],
            ),
            Row(
              children: [
                BodySmallText(
                  title: LocaleKeys.feesPerMinute.tr(),
                  fontFamily: FontWeightEnum.w400.toInter,
                  titleTextAlign: TextAlign.center,
                ),
                10.0.spaceX,
                AutoSizeText(
                  '\$${((expertDetailProviderWatch.userData?.fee ?? 0) / 100).toStringAsFixed(2).toString()}',
                  maxLines: 1,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorConstants.overallRatingColor,
                    shadows: [Shadow(offset: Offset(0, 3), blurRadius: 4, color: ColorConstants.blackColor.withOpacity(0.3))],
                  ),
                )
              ],
            ),
          ],
        ),
        20.0.spaceY,
        BodyMediumText(
          title: " Selected Call Duration",
          fontSize: 15,
          titleColor: ColorConstants.blueColor,
        ),
        20.0.spaceY,
        PrimaryButton(
          height: 45,
          width: 148,
          title: '${expertDetailProviderWatch.callDuration} ${LocaleKeys.minutes.tr()}',
          onPressed: () {},
          buttonColor: ColorConstants.buttonColor,
        ),
        20.0.spaceY,
        PrimaryButton(
          height: 55,
         // title: '${LocaleKeys.pay.tr()} \$${scheduleWatch.totalPayAmount?.toStringAsFixed(2)}',
          title: '${LocaleKeys.pay.tr()} \$20',
          margin: EdgeInsets.symmetric(horizontal: 10),
          fontSize: 18,
          onPressed: widget.onPressed,
        ),
        22.0.spaceY,
        BodyMediumText(
          title: '${LocaleKeys.scheduleDescription.tr()} ${expertDetailProviderWatch.userData?.expertName ?? 'Anonymous'}',
          fontFamily: FontWeightEnum.w500.toInter,
          titleColor: ColorConstants.buttonTextColor,
          titleTextAlign: TextAlign.center,
        )
      ],
    ).addAllPadding(28);
  }
}


