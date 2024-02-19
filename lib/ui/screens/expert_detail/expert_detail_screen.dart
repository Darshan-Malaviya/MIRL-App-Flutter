import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_status_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/utils/value_notifier_utils.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
import 'package:mirl/ui/common/read_more/readmore.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';
import 'package:mirl/ui/screens/expert_detail/widget/area_of_expertise_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/rating_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/request_call_button_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/certifications_and_experience_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_rating_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_widget.dart';
import 'package:mirl/ui/screens/rating_and_review_screen/widget/reviews_list_widget.dart';
import 'package:mirl/ui/screens/instant_call_screen/arguments/instance_call_dialog_arguments.dart';

ValueNotifier<bool> isFavorite = ValueNotifier(false);

class ExpertDetailScreen extends ConsumerStatefulWidget {
  final String expertId;

  const ExpertDetailScreen({super.key, required this.expertId});

  @override
  ConsumerState<ExpertDetailScreen> createState() => _ExpertDetailScreenState();
}

class _ExpertDetailScreenState extends ConsumerState<ExpertDetailScreen> {
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

    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
        trailingIcon: InkWell(
                onTap: () {
                  //ReportThisUserWidget();
                  context.toPushNamed(RoutesConstants.reportExpertScreen, args: BlockUserArgs(reportName: 'REPORT THIS EXPERT',userRole: 1));
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
              onTap: () {
                expertDetailRead.favoriteRequestCall(expertDetailWatch.userData?.id ?? 0);
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
        borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        color: ColorConstants.greyLightColor,
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
                fontSize: 30,
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
                    HeadlineMediumText(
                      fontSize: 30,
                      title: '-',
                      titleColor: ColorConstants.overallRatingColor,
                      shadow: [Shadow(offset: Offset(0, 3), blurRadius: 4, color: ColorConstants.blackColor.withOpacity(0.3))],
                    ),
                  ],
                ),
                40.0.spaceX,
                Flexible(
                  child: Row(
                    children: [
                      BodySmallText(
                        title: LocaleKeys.feesPerMinute.tr(),
                        fontFamily: FontWeightEnum.w400.toInter,
                        titleTextAlign: TextAlign.center,
                      ),
                      10.0.spaceX,
                      Flexible(
                        child: HeadlineMediumText(
                          fontSize: 30,
                          maxLine: 4,
                          title: fee != null ? '\$${fee}' : "",
                          titleColor: ColorConstants.overallRatingColor,
                          shadow: [
                            Shadow(offset: Offset(0, 3), blurRadius: 4, color: ColorConstants.blackColor.withOpacity(0.3))
                          ],
                        ),
                      ),
                    ],
                  ),
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
              ReadMoreText(
                style: TextStyle(fontSize: 16, fontFamily: FontWeightEnum.w400.toInter),
                expertDetailWatch.userData?.about ?? '',
                trimLines: 2,
                trimMode: TrimMode.Line,
                trimCollapsedText: LocaleKeys.readMore.tr(),
                trimExpandedText: LocaleKeys.readLess.tr(),
                moreStyle: TextStyle(fontSize: 18, color: ColorConstants.blackColor),
                lessStyle: TextStyle(fontSize: 18, color: ColorConstants.blackColor),
              ),
              36.0.spaceY,
            ],
            AreaOfExpertiseWidget(),
            ExpertDetailsButtonWidget(

              titleColor:  expertDetailWatch.userData?.onlineStatus == 1 ? ColorConstants.buttonTextColor : ColorConstants.overAllRatingColor,
              title: expertDetailWatch.userData?.onlineStatus == 1 ? StringConstants.requestCallNow : "ZEN MODE : CALL PAUSED",
              buttonColor: expertDetailWatch.userData?.onlineStatus == 1 ? ColorConstants.requestCallNowColor : ColorConstants.redLightColor ,
              onTap: () {
                if ((expertDetailWatch.userData?.instantCallAvailable ?? false) &&
                    (expertDetailWatch.userData?.onlineStatus.toString() == '1')) {
                  instanceCallEnumNotifier.value = CallTypeEnum.callRequest;
                  /// THis is call sender (User) side
                  context.toPushNamed(RoutesConstants.instantCallRequestDialogScreen,
                      args: InstanceCallDialogArguments(
                        name: expertDetailWatch.userData?.userName ?? "",
                        onFirstBtnTap: () {
                          if((expertDetailWatch.userData?.instantCallAvailable ?? false) && (expertDetailWatch.userData?.onlineStatus.toString() == '1') ){
                            ref.read(socketProvider).instanceCallRequestEmit(expertId: widget.expertId);
                          } else {
                            FlutterToast().showToast(msg: "Expert not available.");
                          }
                        },
                        onSecondBtnTap: () {
                          if(instanceCallEnumNotifier.value.secondButtonName == LocaleKeys.goBack.tr().toUpperCase()) {
                            context.toPop();
                          } else if(instanceCallEnumNotifier.value == CallTypeEnum.requestApproved){
                            ref.read(socketProvider).connectCallEmit(expertId: widget.expertId);
                            ///context.toPop();
                          }
                          else {
                            ref.read(socketProvider).updateRequestStatusEmit(expertId: widget.expertId, callStatusEnum: CallStatusEnum.cancel,
                                callRoleEnum: CallRoleEnum.user, userId: SharedPrefHelper.getUserId.toString());
                            context.toPop();
                          }
                        },
                        image: expertDetailWatch.userData?.userProfile ?? "",
                        expertId: expertDetailWatch.userData?.id.toString() ??'',
                        userID: SharedPrefHelper.getUserId.toString(),
                      ));
                } else {
                  FlutterToast().showToast(msg: "Expert not available.");
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
            if (expertDetailWatch.userData?.loginType != null) ...[
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
                      text: '${expertDetailWatch.userData?.city ?? ''},${expertDetailWatch.userData?.country ?? ''}',
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
                  onPress: () => context.toPushNamed(RoutesConstants.ratingAndReviewScreen),
                  child: TitleSmallText(title: 'see all', titleColor: ColorConstants.greyColor),
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
                        text: '0',
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
}
