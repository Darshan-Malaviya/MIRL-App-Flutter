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
import 'package:mirl/ui/common/read_more/readmore.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';
import 'package:mirl/ui/screens/call_feedback_screen/arguments/call_feddback_arguments.dart';
import 'package:mirl/ui/screens/expert_detail/widget/area_of_expertise_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/rating_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/request_call_button_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/certifications_and_experience_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_rating_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_widget.dart';
import 'package:mirl/ui/screens/instant_call_screen/arguments/instance_call_dialog_arguments.dart';

ValueNotifier<bool> isFavorite = ValueNotifier(false);

class ExpertDetailScreen extends ConsumerStatefulWidget {
  final CallFeedBackArgs args;

  const ExpertDetailScreen({super.key, required this.args});

  @override
  ConsumerState<ExpertDetailScreen> createState() => _ExpertDetailScreenState();
}

class _ExpertDetailScreenState extends ConsumerState<ExpertDetailScreen> {
  int duration = 0;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(expertDetailProvider).getExpertDetailApiCall(userId: widget.args.expertId ?? '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expertDetailWatch = ref.watch(expertDetailProvider);
    final expertDetailRead = ref.read(expertDetailProvider);
    bool userOnline = false;
    if (expertDetailWatch.userData != null) {
      userOnline = (expertDetailWatch.userData?.isAvailableForCall ?? false) &&
          (expertDetailWatch.userData?.instantCallAvailable ?? false);
    }

    String? fee;
    if (expertDetailWatch.userData?.fee != null) {
      double data = (expertDetailWatch.userData?.fee?.toDouble() ?? 0.0) / 100;
      fee = data.toStringAsFixed(2);
    }
    print("userOnline========${userOnline}");
    print("userOnlineStatus========${expertDetailWatch.userData?.onlineStatus}");
    return GestureDetector(
      onVerticalDragDown: (tap) {
        Future.delayed(Duration(milliseconds: 200)).then((value) => HapticFeedback.heavyImpact());
      },
      child: RefreshIndicator(
        color: ColorConstants.primaryColor,
        onRefresh: () async {
          ref.read(expertDetailProvider).getExpertDetailApiCall(userId: widget.args.expertId ?? '');
        },
        child: Scaffold(
          appBar: AppBarWidget(
            preferSize: 40,
            leading: InkWell(
              child: Image.asset(ImageConstants.backIcon),
              onTap: () {
                if (widget.args.callType == '1') {
                  context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 0);
                } else {
                  context.toPop();
                }
              },
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
                          args: BlockUserArgs(
                              reportName: 'REPORT THIS EXPERT',
                              userRole: 1,
                              expertId: widget.args.expertId,
                              imageURL: expertDetailWatch.userData?.expertProfile ?? ''));
                    },
                    child: Icon(Icons.more_horiz))
                .addPaddingRight(14),
          ),
          body: Stack(
            children: [
              // NetworkImageWidget(
              //   imageURL: expertDetailWatch.userData?.expertProfile ?? '',
              //   isNetworkImage: true,
              //   boxFit: BoxFit.cover,
              // ),
              // Align(
              //   alignment: AlignmentDirectional.topEnd,
              //   child: InkWell(
              //     onTap: () async {
              //       await expertDetailRead.favoriteRequestCall(expertDetailWatch.userData?.id ?? 0);
              //       ref.read(homeProvider).manageFavoriteUserList(
              //             expertId: expertDetailWatch.userData?.id ?? 0,
              //             expertName: expertDetailWatch.userData?.expertName ?? '',
              //             expertProfile: expertDetailWatch.userData?.expertProfile ?? '',
              //             isFavorite: expertDetailWatch.userData?.isFavorite ?? false,
              //           );
              //     },
              //     child: Image.asset(
              //       expertDetailWatch.userData?.isFavorite ?? false ? ImageConstants.like : ImageConstants.dislike,
              //       height: 40,
              //       width: 40,
              //     ),
              //   ),
              // ).addAllPadding(15),
              CustomScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // SliverAppBar(
                  //   actions:  [
                  //     Align(
                  //       alignment: AlignmentDirectional.topEnd,
                  //       child: InkWell(
                  //         onTap: () async {
                  //           await expertDetailRead.favoriteRequestCall(expertDetailWatch.userData?.id ?? 0);
                  //           ref.read(homeProvider).manageFavoriteUserList(
                  //                 expertId: expertDetailWatch.userData?.id ?? 0,
                  //                 expertName: expertDetailWatch.userData?.expertName ?? '',
                  //                 expertProfile: expertDetailWatch.userData?.expertProfile ?? '',
                  //                 isFavorite: expertDetailWatch.userData?.isFavorite ?? false,
                  //               );
                  //         },
                  //         child: Image.asset(
                  //           expertDetailWatch.userData?.isFavorite ?? false ? ImageConstants.like : ImageConstants.dislike,
                  //           height: 40,
                  //           width: 40,
                  //         ),
                  //       ),
                  //     ).addAllPadding(12),
                  //   ],
                  //   leading: SizedBox.shrink(),
                  //   stretch: true,
                  //   backgroundColor: ColorConstants.whiteColor,
                  //   pinned: true,
                  //   surfaceTintColor: ColorConstants.whiteColor,
                  //   expandedHeight: 400.0,
                  //   flexibleSpace: FlexibleSpaceBar(
                  //     stretchModes: [StretchMode.zoomBackground],
                  //     expandedTitleScale: 1.3,
                  //     collapseMode: CollapseMode.pin,
                  //     title: Container(
                  //       padding: EdgeInsets.only(top: 14, bottom: 10),
                  //       width: double.infinity,
                  //       decoration: BoxDecoration(
                  //         color: ColorConstants.whiteColor,
                  //         borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(40),
                  //           topRight: Radius.circular(40),
                  //         ),
                  //       ),
                  //       child: HeadlineMediumText(
                  //         title: expertDetailWatch.userData?.expertName ?? '',
                  //         fontSize: 28,
                  //         maxLine: 2,
                  //         titleTextAlign: TextAlign.center,
                  //         titleColor: ColorConstants.bottomTextColor,
                  //       ),
                  //     ),
                  //     titlePadding: EdgeInsets.zero,
                  //     background: Padding(
                  //       padding: EdgeInsets.only(bottom: 20),
                  //       child: NetworkImageWidget(
                  //         imageURL: expertDetailWatch.userData?.expertProfile ?? '',
                  //         isNetworkImage: true,
                  //         // emptyImageWidget: expertWatch.isLoadedExport
                  //         //     ? SizedBox.shrink()
                  //         //     : Image.asset(ImageConstants.exploreImage, fit: BoxFit.fitWidth, width: double.infinity),
                  //         boxFit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SliverAppBar(
                  //   actions:  [
                  //     Align(
                  //       alignment: AlignmentDirectional.topEnd,
                  //       child: InkWell(
                  //         onTap: () async {
                  //           await expertDetailRead.favoriteRequestCall(expertDetailWatch.userData?.id ?? 0);
                  //           ref.read(homeProvider).manageFavoriteUserList(
                  //                 expertId: expertDetailWatch.userData?.id ?? 0,
                  //                 expertName: expertDetailWatch.userData?.expertName ?? '',
                  //                 expertProfile: expertDetailWatch.userData?.expertProfile ?? '',
                  //                 isFavorite: expertDetailWatch.userData?.isFavorite ?? false,
                  //               );
                  //         },
                  //         child: Image.asset(
                  //           expertDetailWatch.userData?.isFavorite ?? false ? ImageConstants.like : ImageConstants.dislike,
                  //           height: 40,
                  //           width: 40,
                  //         ),
                  //       ),
                  //     ).addAllPadding(12),
                  //   ],
                  //   leading: SizedBox.shrink(),
                  //   stretch: true,
                  //   backgroundColor: ColorConstants.whiteColor,
                  //   pinned: true,
                  //   surfaceTintColor: ColorConstants.whiteColor,
                  //   expandedHeight: 400.0,
                  //   flexibleSpace: FlexibleSpaceBar(
                  //     stretchModes: [StretchMode.zoomBackground],
                  //     expandedTitleScale: 1.3,
                  //     collapseMode: CollapseMode.pin,
                  //     title: Container(
                  //       padding: EdgeInsets.only(top: 14, bottom: 10),
                  //       width: double.infinity,
                  //       decoration: BoxDecoration(
                  //         color: ColorConstants.whiteColor,
                  //         borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(40),
                  //           topRight: Radius.circular(40),
                  //         ),
                  //       ),
                  //       child: HeadlineMediumText(
                  //         title: expertDetailWatch.userData?.expertName ?? '',
                  //         fontSize: 28,
                  //         maxLine: 2,
                  //         titleTextAlign: TextAlign.center,
                  //         titleColor: ColorConstants.bottomTextColor,
                  //       ),
                  //     ),
                  //     titlePadding: EdgeInsets.zero,
                  //     background: Padding(
                  //       padding: EdgeInsets.only(bottom: 20),
                  //       child: NetworkImageWidget(
                  //         imageURL: expertDetailWatch.userData?.expertProfile ?? '',
                  //         isNetworkImage: true,
                  //         // emptyImageWidget: expertWatch.isLoadedExport
                  //         //     ? SizedBox.shrink()
                  //         //     : Image.asset(ImageConstants.exploreImage, fit: BoxFit.fitWidth, width: double.infinity),
                  //         boxFit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  SliverAppBar(
                    stretch: false,
                    backgroundColor: ColorConstants.whiteColor,
                    pinned: true,
                    surfaceTintColor: ColorConstants.whiteColor,
                    expandedHeight: 400.0,
                      leading: SizedBox.shrink(),
                    actions:  [
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
                      ).addAllPadding(12),
                    ],
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(100.0),
                      child: Container(padding: EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          color: ColorConstants.whiteColor,
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 14, bottom: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorConstants.whiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: HeadlineMediumText(
                            title: expertDetailWatch.userData?.expertName ?? '',
                            fontSize: 28,
                            maxLine: 2,
                            titleTextAlign: TextAlign.center,
                            titleColor: ColorConstants.bottomTextColor,
                          ),
                        ),
                      ),
                    ),
                    flexibleSpace: NetworkImageWidget(
                      imageURL: expertDetailWatch.userData?.expertProfile ?? '',
                      isNetworkImage: true,
                      boxFit: BoxFit.cover,
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                    expertDetailWatch.userData?.overAllRating != 0 && expertDetailWatch.userData?.overAllRating != null
                                        ? expertDetailWatch.userData?.overAllRating.toString() ?? ''
                                        : LocaleKeys.newText.tr(),
                                    maxLines: 1,
                                    softWrap: true,
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: ColorConstants.overallRatingColor,
                                      shadows: [
                                        Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))
                                      ],
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
                                  expertDetailWatch.userData?.fee != 0
                                      ? AutoSizeText(
                                    '\$${fee}',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontSize: 20,
                                      color: ColorConstants.overallRatingColor,
                                      shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))],
                                    ),
                                  )
                                      : Column(
                                    children: [
                                      AutoSizeText(
                                        LocaleKeys.free.tr(),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          fontSize: 20,
                                          color: ColorConstants.overallRatingColor,
                                          shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))],
                                        ),
                                      ),
                                      AutoSizeText(
                                        LocaleKeys.bono.tr(),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          fontSize: 12,
                                          color: ColorConstants.overallRatingColor,
                                          shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))],
                                        ),
                                      ),
                                    ],
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
                            ReadMoreText(
                              style: TextStyle(fontSize: 16, fontFamily: FontWeightEnum.w400.toInter),
                              expertDetailWatch.userData?.about ?? '',
                              trimLines: 10,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: LocaleKeys.readMore.tr(),
                              trimExpandedText: ' ${LocaleKeys.readLess.tr()}',
                              moreStyle: TextStyle(fontSize: 16, color: ColorConstants.bottomTextColor.withOpacity(0.7)),
                              lessStyle: TextStyle(fontSize: 16, color: ColorConstants.bottomTextColor.withOpacity(0.7)),
                            ),
                            // ParsedReadMore(
                            //   style: TextStyle(fontSize: 16, fontFamily: FontWeightEnum.w400.toInter, color: ColorConstants.blackColor),
                            //   expertDetailWatch.userData?.about ?? '',
                            //   trimLines: 15,
                            //   urlTextStyle: TextStyle(color: Colors.blue, fontSize: 16, decoration: TextDecoration.none),
                            //   // trimMode: TrimMode.Line,
                            //   // trimCollapsedText: LocaleKeys.readMore.tr(),
                            //   // trimExpandedText: ' ${LocaleKeys.readLess.tr()}',
                            //   moreStyle: TextStyle(fontSize: 16, color: ColorConstants.bottomTextColor.withOpacity(0.7)),
                            //   lessStyle: TextStyle(fontSize: 16, color: ColorConstants.bottomTextColor.withOpacity(0.7)),
                            // ),
                            36.0.spaceY,
                          ],
                          AreaOfExpertiseWidget(areaOfExpertise: expertDetailWatch.userData?.areaOfExpertise ?? []),
                          ExpertDetailsButtonWidget(
                            titleColor: userOnline
                                ? expertDetailWatch.userData?.onlineStatus != 3
                                    ? ColorConstants.buttonTextColor
                                    : ColorConstants.overAllRatingColor
                                : ColorConstants.overAllRatingColor,
                            title: userOnline
                                ? expertDetailWatch.userData?.onlineStatus != 3
                                    ? StringConstants.requestCallNow
                                    : LocaleKeys.callPaused.tr()
                                : LocaleKeys.callPaused.tr(),
                            suffixTitle: userOnline
                                ? expertDetailWatch.userData?.onlineStatus != 3
                                    ? LocaleKeys.expertOnline.tr()
                                    : LocaleKeys.expertOffline.tr()
                                : LocaleKeys.expertOffline.tr(),
                            buttonColor: userOnline
                                ? expertDetailWatch.userData?.onlineStatus != 3
                                    ? ColorConstants.requestCallNowColor
                                    : ColorConstants.redLightColor
                                : ColorConstants.redLightColor,
                            onTap: () {
                              if (userOnline && expertDetailWatch.userData?.onlineStatus == 1) {
                                CommonBottomSheet.bottomSheet(
                                    context: context,
                                    height: MediaQuery.of(context).size.height * 0.5,
                                    child: CallDurationBottomSheetView(
                                        expertName: expertDetailWatch.userData?.expertName ?? '',
                                        onPressed: () {
                                          context.toPop();
                                          allCallDurationNotifier.value = expertDetailWatch.callDuration * 60;
                                          if (/*(expertDetailWatch.userData?.instantCallAvailable ?? false) && userOnline*/ userOnline) {
                                            instanceCallEnumNotifier.value = CallRequestTypeEnum.callRequest;

                                            /// THis is call sender (User) side
                                            context.toPushNamed(RoutesConstants.instantCallRequestDialogScreen,
                                                args: InstanceCallDialogArguments(
                                                  name: expertDetailWatch.userData?.expertName ?? "",
                                                  onFirstBtnTap: () {
                                                    if (instanceCallEnumNotifier.value == CallRequestTypeEnum.requestTimeout) {
                                                      instanceRequestTimerNotifier.dispose();
                                                      manageTimeOutStatus(
                                                          userData: expertDetailWatch.userData,
                                                          expertId: widget.args.expertId ?? '',
                                                          context: context,
                                                          expertDetailWatch: expertDetailWatch,
                                                          userOnline: userOnline);
                                                    } else {
                                                      ref.read(socketProvider).instanceCallRequestEmit(
                                                          expertId: widget.args.expertId ?? '',
                                                          requestedDuration: (expertDetailWatch.callDuration * 60));
                                                    }
                                                  },
                                                  onSecondBtnTap: () {
                                                    if (instanceCallEnumNotifier.value.secondButtonName ==
                                                        LocaleKeys.goBack.tr().toUpperCase()) {
                                                      context.toPop();
                                                    } else if (instanceCallEnumNotifier.value ==
                                                        CallRequestTypeEnum.requestApproved) {
                                                      expertDetailRead.getPayValue(fee: expertDetailWatch.userData?.fee ?? 0);
                                                      CommonBottomSheet.bottomSheet(
                                                          context: context,
                                                          child: CallPaymentBottomSheetView(onPressed: () {
                                                            context.toPop();
                                                            ref
                                                                .read(socketProvider)
                                                                .connectCallEmit(expertId: widget.args.expertId ?? '');
                                                          }),
                                                          isDismissible: true);

                                                      ///context.toPop();
                                                    } else {
                                                      ref.read(socketProvider).updateRequestStatusEmit(
                                                          callStatusEnum: CallRequestStatusEnum.cancel,
                                                          expertId: widget.args.expertId ?? '',
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
                              context.toPushNamed(RoutesConstants.scheduleCallScreen,
                                  args: CallArgs(expertData: expertDetailWatch.userData));
                            },
                            buttonColor: ColorConstants.yellowButtonColor,
                            titleColor: ColorConstants.buttonTextColor,
                          ),
                          40.0.spaceY,
                          CertificationAndExperienceWidget(certification: expertDetailWatch.userData?.certification ?? []),
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
                                    text:
                                        '${expertDetailWatch.userData?.city ?? ''}, ${expertDetailWatch.userData?.country ?? ''}',
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
                          ] else ...[
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
                                    text: expertDetailRead.userGender(),
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
                                onPress: () => context.toPushNamed(RoutesConstants.ratingAndReviewScreen,
                                    args: expertDetailWatch.userData?.id),
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
                            OverallRatingWidget(
                                name: RatingEnum.EXPERTISE.name,
                                value: expertDetailWatch.userData?.ratingCriteria?[0].rating ?? 0),
                            OverallRatingWidget(
                                name: RatingEnum.COMMUNICATION.name,
                                value: expertDetailWatch.userData?.ratingCriteria?[1].rating ?? 0),
                            OverallRatingWidget(
                                name: RatingEnum.HELPFULNESS.name,
                                value: expertDetailWatch.userData?.ratingCriteria?[2].rating ?? 0),
                            OverallRatingWidget(
                                name: RatingEnum.EMPATHY.name, value: expertDetailWatch.userData?.ratingCriteria?[3].rating ?? 0),
                            OverallRatingWidget(
                                name: RatingEnum.PROFESSIONALISM.name,
                                value: expertDetailWatch.userData?.ratingCriteria?[4].rating ?? 0),
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
                  )
                ],
              ),
              // DraggableScrollableSheet(
              //   initialChildSize: 0.55,
              //   minChildSize: 0.55,
              //   maxChildSize: 0.90,
              //   builder: (BuildContext context, myScrollController) {
              //     return bottomSheetView(controller: myScrollController);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheetView({required ScrollController controller}) {
    final expertDetailWatch = ref.watch(expertDetailProvider);
    final expertDetailRead = ref.read(expertDetailProvider);
    bool userOnline = false;
    if (expertDetailWatch.userData != null) {
      userOnline = (expertDetailWatch.userData?.isAvailableForCall ?? false) &&
          (expertDetailWatch.userData?.instantCallAvailable ?? false);
    }

    String? fee;
    if (expertDetailWatch.userData?.fee != null) {
      double data = (expertDetailWatch.userData?.fee?.toDouble() ?? 0.0) / 100;
      fee = data.toStringAsFixed(2);
    }
    print("userOnline========${userOnline}");
    print("userOnlineStatus========${expertDetailWatch.userData?.onlineStatus}");

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
                maxLine: 2,
                titleTextAlign: TextAlign.center,
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
                      expertDetailWatch.userData?.overAllRating != 0 && expertDetailWatch.userData?.overAllRating != null
                          ? expertDetailWatch.userData?.overAllRating.toString() ?? ''
                          : LocaleKeys.newText.tr(),
                      maxLines: 1,
                      softWrap: true,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: ColorConstants.overallRatingColor,
                        shadows: [
                          Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))
                        ],
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
                    expertDetailWatch.userData?.fee != 0
                        ? AutoSizeText(
                            '\$${fee}',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontSize: 20,
                              color: ColorConstants.overallRatingColor,
                              shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))],
                            ),
                          )
                        : Column(
                            children: [
                              AutoSizeText(
                                LocaleKeys.free.tr(),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 20,
                                  color: ColorConstants.overallRatingColor,
                                  shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))],
                                ),
                              ),
                              AutoSizeText(
                                LocaleKeys.bono.tr(),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 12,
                                  color: ColorConstants.overallRatingColor,
                                  shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))],
                                ),
                              ),
                            ],
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
              ReadMoreText(
                style: TextStyle(fontSize: 16, fontFamily: FontWeightEnum.w400.toInter),
                expertDetailWatch.userData?.about ?? '',
                trimLines: 10,
                trimMode: TrimMode.Line,
                trimCollapsedText: LocaleKeys.readMore.tr(),
                trimExpandedText: ' ${LocaleKeys.readLess.tr()}',
                moreStyle: TextStyle(fontSize: 16, color: ColorConstants.bottomTextColor.withOpacity(0.7)),
                lessStyle: TextStyle(fontSize: 16, color: ColorConstants.bottomTextColor.withOpacity(0.7)),
              ),
              // ParsedReadMore(
              //   style: TextStyle(fontSize: 16, fontFamily: FontWeightEnum.w400.toInter, color: ColorConstants.blackColor),
              //   expertDetailWatch.userData?.about ?? '',
              //   trimLines: 15,
              //   urlTextStyle: TextStyle(color: Colors.blue, fontSize: 16, decoration: TextDecoration.none),
              //   // trimMode: TrimMode.Line,
              //   // trimCollapsedText: LocaleKeys.readMore.tr(),
              //   // trimExpandedText: ' ${LocaleKeys.readLess.tr()}',
              //   moreStyle: TextStyle(fontSize: 16, color: ColorConstants.bottomTextColor.withOpacity(0.7)),
              //   lessStyle: TextStyle(fontSize: 16, color: ColorConstants.bottomTextColor.withOpacity(0.7)),
              // ),
              36.0.spaceY,
            ],
            AreaOfExpertiseWidget(areaOfExpertise: expertDetailWatch.userData?.areaOfExpertise ?? []),
            ExpertDetailsButtonWidget(
              titleColor: userOnline
                  ? expertDetailWatch.userData?.onlineStatus != 3
                      ? ColorConstants.buttonTextColor
                      : ColorConstants.overAllRatingColor
                  : ColorConstants.overAllRatingColor,
              title: userOnline
                  ? expertDetailWatch.userData?.onlineStatus != 3
                      ? StringConstants.requestCallNow
                      : LocaleKeys.callPaused.tr()
                  : LocaleKeys.callPaused.tr(),
              suffixTitle: userOnline
                  ? expertDetailWatch.userData?.onlineStatus != 3
                      ? LocaleKeys.expertOnline.tr()
                      : LocaleKeys.expertOffline.tr()
                  : LocaleKeys.expertOffline.tr(),
              buttonColor: userOnline
                  ? expertDetailWatch.userData?.onlineStatus != 3
                      ? ColorConstants.requestCallNowColor
                      : ColorConstants.redLightColor
                  : ColorConstants.redLightColor,
              onTap: () {
                if (userOnline) {
                  CommonBottomSheet.bottomSheet(
                      context: context,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: CallDurationBottomSheetView(
                          expertName: expertDetailWatch.userData?.expertName ?? '',
                          onPressed: () {
                            context.toPop();
                            allCallDurationNotifier.value = expertDetailWatch.callDuration * 60;
                            if (/*(expertDetailWatch.userData?.instantCallAvailable ?? false) && userOnline*/ userOnline) {
                              instanceCallEnumNotifier.value = CallRequestTypeEnum.callRequest;

                              /// THis is call sender (User) side
                              context.toPushNamed(RoutesConstants.instantCallRequestDialogScreen,
                                  args: InstanceCallDialogArguments(
                                    name: expertDetailWatch.userData?.expertName ?? "",
                                    onFirstBtnTap: () {
                                      if (instanceCallEnumNotifier.value == CallRequestTypeEnum.requestTimeout) {
                                        instanceRequestTimerNotifier.dispose();
                                        manageTimeOutStatus(
                                            userData: expertDetailWatch.userData,
                                            expertId: widget.args.expertId ?? '',
                                            context: context,
                                            expertDetailWatch: expertDetailWatch,
                                            userOnline: userOnline);
                                      } else {
                                        ref.read(socketProvider).instanceCallRequestEmit(
                                            expertId: widget.args.expertId ?? '',
                                            requestedDuration: (expertDetailWatch.callDuration * 60));
                                      }
                                    },
                                    onSecondBtnTap: () {
                                      if (instanceCallEnumNotifier.value.secondButtonName ==
                                          LocaleKeys.goBack.tr().toUpperCase()) {
                                        context.toPop();
                                      } else if (instanceCallEnumNotifier.value == CallRequestTypeEnum.requestApproved) {
                                        expertDetailRead.getPayValue(fee: expertDetailWatch.userData?.fee ?? 0);
                                        CommonBottomSheet.bottomSheet(
                                            context: context,
                                            child: CallPaymentBottomSheetView(onPressed: () {
                                              context.toPop();
                                              ref.read(socketProvider).connectCallEmit(expertId: widget.args.expertId ?? '');
                                            }),
                                            isDismissible: true);

                                        ///context.toPop();
                                      } else {
                                        ref.read(socketProvider).updateRequestStatusEmit(
                                            callStatusEnum: CallRequestStatusEnum.cancel,
                                            expertId: widget.args.expertId ?? '',
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
            CertificationAndExperienceWidget(certification: expertDetailWatch.userData?.certification ?? []),
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
            ] else ...[
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
                      text: expertDetailRead.userGender(),
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
              OverallRatingWidget(
                  name: RatingEnum.EXPERTISE.name, value: expertDetailWatch.userData?.ratingCriteria?[0].rating ?? 0),
              OverallRatingWidget(
                  name: RatingEnum.COMMUNICATION.name, value: expertDetailWatch.userData?.ratingCriteria?[1].rating ?? 0),
              OverallRatingWidget(
                  name: RatingEnum.HELPFULNESS.name, value: expertDetailWatch.userData?.ratingCriteria?[2].rating ?? 0),
              OverallRatingWidget(
                  name: RatingEnum.EMPATHY.name, value: expertDetailWatch.userData?.ratingCriteria?[3].rating ?? 0),
              OverallRatingWidget(
                  name: RatingEnum.PROFESSIONALISM.name, value: expertDetailWatch.userData?.ratingCriteria?[4].rating ?? 0),
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

  void manageTimeOutStatus(
      {required UserData? userData,
      required BuildContext context,
      required String expertId,
      required ExpertDetailProvider expertDetailWatch,
      required bool userOnline}) {
    context.toPop();
    instanceRequestTimerNotifier = ValueNotifier<int>(120);
    instanceCallEnumNotifier = ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.callRequest);
    instanceCallEnumNotifier.value = CallRequestTypeEnum.callRequest;

    /// THis is call sender (User) side
    CommonBottomSheet.bottomSheet(
        context: context,
        height: MediaQuery.of(context).size.height * 0.5,
        child: CallDurationBottomSheetView(
            expertName: expertDetailWatch.userData?.expertName ?? '',
            onPressed: () {
              context.toPop();
              allCallDurationNotifier.value = expertDetailWatch.callDuration;
              if (/*(expertDetailWatch.userData?.instantCallAvailable ?? false) && userOnline*/ userOnline) {
                instanceCallEnumNotifier.value = CallRequestTypeEnum.callRequest;

                /// THis is call sender (User) side
                context.toPushNamed(RoutesConstants.instantCallRequestDialogScreen,
                    args: InstanceCallDialogArguments(
                      name: expertDetailWatch.userData?.expertName ?? "",
                      onFirstBtnTap: () {
                        if (instanceCallEnumNotifier.value == CallRequestTypeEnum.requestTimeout) {
                          instanceRequestTimerNotifier.dispose();
                          manageTimeOutStatus(
                              userData: expertDetailWatch.userData,
                              expertId: widget.args.expertId ?? '',
                              context: context,
                              expertDetailWatch: expertDetailWatch,
                              userOnline: userOnline);
                        } else {
                          ref.read(socketProvider).instanceCallRequestEmit(
                              expertId: widget.args.expertId ?? '', requestedDuration: (expertDetailWatch.callDuration * 60));
                        }
                      },
                      onSecondBtnTap: () {
                        if (instanceCallEnumNotifier.value.secondButtonName == LocaleKeys.goBack.tr().toUpperCase()) {
                          context.toPop();
                        } else if (instanceCallEnumNotifier.value == CallRequestTypeEnum.requestApproved) {
                          ref.read(expertDetailProvider).getPayValue(fee: expertDetailWatch.userData?.fee ?? 0);
                          CommonBottomSheet.bottomSheet(
                              context: context,
                              child: CallPaymentBottomSheetView(onPressed: () {
                                context.toPop();
                                ref.read(socketProvider).connectCallEmit(expertId: widget.args.expertId ?? '');
                              }),
                              isDismissible: true);

                          ///context.toPop();
                        } else {
                          ref.read(socketProvider).updateRequestStatusEmit(
                              callStatusEnum: CallRequestStatusEnum.cancel,
                              expertId: widget.args.expertId ?? '',
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
  final String expertName;
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
          title: LocaleKeys.pleaseSelectCallDuration.tr(),
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
        BodySmallText(
            title: '${LocaleKeys.maxCallDuration.tr()} 30 ${LocaleKeys.minutes.tr()}', fontFamily: FontWeightEnum.w500.toInter),
        20.0.spaceY,
        PrimaryButton(
          height: 55,
          title: LocaleKeys.checkAvailability.tr(),
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
                  expertDetailProviderWatch.userData?.overAllRating != 0 &&
                          expertDetailProviderWatch.userData?.overAllRating != null
                      ? expertDetailProviderWatch.userData?.overAllRating.toString() ?? '0'
                      : LocaleKeys.newText.tr(),
                  maxLines: 1,
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ColorConstants.overallRatingColor,
                    shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))],
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
                  expertDetailProviderWatch.userData?.fee != null
                      ? '\$${((expertDetailProviderWatch.userData?.fee ?? 0) / 100).toStringAsFixed(2).toString()}'
                      : LocaleKeys.proBono.tr(),
                  maxLines: 2,
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ColorConstants.overallRatingColor,
                    shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))],
                  ),
                )
              ],
            ),
          ],
        ),
        20.0.spaceY,
        BodyMediumText(
          title: LocaleKeys.selectedCallDuration.tr(),
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
          title: '${LocaleKeys.pay.tr()} \$${expertDetailProviderWatch.totalPayAmountInstanceCall?.toStringAsFixed(2)}',
          margin: EdgeInsets.symmetric(horizontal: 10),
          fontSize: 18,
          onPressed: widget.onPressed,
        ),
        22.0.spaceY,
        BodyMediumText(
          title:
              '${LocaleKeys.scheduleDescription.tr()} ${expertDetailProviderWatch.userData?.expertName?.toUpperCase() ?? LocaleKeys.anonymous.tr().toUpperCase()}',
          fontFamily: FontWeightEnum.w500.toInter,
          titleColor: ColorConstants.buttonTextColor,
          titleTextAlign: TextAlign.center,
          maxLine: 4,
        )
      ],
    ).addAllPadding(28);
  }
}
