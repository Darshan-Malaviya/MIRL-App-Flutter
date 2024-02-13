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
import 'package:mirl/ui/screens/expert_detail/widget/area_of_expertise_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/request_call_button_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/certifications_and_experience_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/droup_down_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_rating_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/reviews_widget.dart';
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
                  context.toPushNamed(RoutesConstants.reportExpertScreen);
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
            initialChildSize: 0.50,
            minChildSize: 0.50,
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
    if(expertDetailWatch.userData?.fee!= null){
      double data = (expertDetailWatch.userData?.fee?.toDouble() ?? 0.0) / 100;
      fee = data.toStringAsFixed(2);
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
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
                Row(
                  children: [
                    BodySmallText(
                      title: LocaleKeys.feesPerMinute.tr(),
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleTextAlign: TextAlign.center,
                    ),
                    10.0.spaceX,
                    HeadlineMediumText(
                      fontSize: 30,
                      title: fee != null ? '\$${fee}' :"",
                      titleColor: ColorConstants.overallRatingColor,
                      shadow: [Shadow(offset: Offset(0, 3), blurRadius: 4, color: ColorConstants.blackColor.withOpacity(0.3))],
                    ),
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
              12.0.spaceY,
              ReadMoreText(
                style: TextStyle(fontSize: 16, fontFamily: FontWeightEnum.w400.toInter),
                expertDetailWatch.userData?.about ?? '',
                trimLines: 2,
                trimMode: TrimMode.Line,
                trimCollapsedText: LocaleKeys.readMore.tr(),
                trimExpandedText: LocaleKeys.readLess.tr(),
                moreStyle: TextStyle(fontSize: 18, color: ColorConstants.blackColor),
              ),
              36.0.spaceY,
            ],
            AreaOfExpertiseWidget(),
            ExpertDetailsButtonWidget(

              titleColor:  expertDetailWatch.userData?.onlineStatus == 1 ? ColorConstants.buttonTextColor : ColorConstants.overAllRatingColor,
              title: expertDetailWatch.userData?.onlineStatus == 1 ? StringConstants.requestCallNow : "ZEN MODE : CALL PAUSED",
              buttonColor: expertDetailWatch.userData?.onlineStatus == 1 ? ColorConstants.requestCallNowColor : ColorConstants.redLightColor ,
              onTap: () {
                instanceCallEnumNotifier.value = CallTypeEnum.callRequest;
                context.toPushNamed(RoutesConstants.instantCallRequestDialogScreen,
                args: InstanceCallDialogArguments(
                  name: expertDetailWatch.userData?.userName ?? "Name",
                  //callTypeEnum: CallTypeEnum.callRequest,
                 // title: LocaleKeys.instantCallRequest.tr().toUpperCase(),
                //  desc: "${LocaleKeys.instantCallRequest.tr().toUpperCase()}${expertDetailWatch.userData?.expertName?.toUpperCase() ?? "USERNAME"}?",
                  //secondBtnTile: LocaleKeys.goBack.tr().toUpperCase(),
                  //firstBTnTitle:LocaleKeys.requestCall.tr().toUpperCase(),
                  onFirstBtnTap: () {
                    ref.read(socketProvider).instanceCallRequestEmit(expertId: widget.expertId);
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
              },
            ),
            24.0.spaceY,
            PrimaryButton(
              title: StringConstants.scheduleCall,
              onPressed: () {
                context.toPushNamed(RoutesConstants.scheduleCallScreen, args: CallArgs(expertId: widget.expertId));
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
            Image.asset(ImageConstants.line),
            40.0.spaceY,
            TitleMediumText(
              title: StringConstants.reviewsAndRatting,
              titleTextAlign: TextAlign.start,
              titleColor: ColorConstants.blueColor,
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
                      ).addMarginX(20))
                  .addMarginX(10),
            ),
            26.0.spaceY,
            OverallRatingWidget(name: 'EXPERTISE', value: 5),
            OverallRatingWidget(name: 'COMMUNICATION', value: 5),
            OverallRatingWidget(name: 'HELPFULNESS', value: 5),
            OverallRatingWidget(name: 'EMPATHY', value: 5),
            OverallRatingWidget(name: 'PROFESSIONALISM', value: 5),
            60.0.spaceY,
            ReviewsAndRatingWidget(
              title: StringConstants.reviews,
              buttonColor: ColorConstants.yellowButtonColor,
              child: SizedBox.shrink(),
            ),
            30.0.spaceY,
            DropDownWidget(),
            40.0.spaceY,
            ReviewsWidget(),
            20.0.spaceY,
          ],
        ),
      ).addAllPadding(28),
    );
  }
}
