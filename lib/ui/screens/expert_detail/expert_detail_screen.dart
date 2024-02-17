import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
import 'package:mirl/ui/common/read_more/readmore.dart';
import 'package:mirl/ui/screens/expert_detail/widget/area_of_expertise_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/request_call_button_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/certifications_and_experience_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/droup_down_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_rating_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/reviews_widget.dart';

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
      // ref.read(reportUserProvider).changeReportAndThanksScreen();
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
                  context.toPushNamed(RoutesConstants.reportExpertScreen, args: 1);
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
        color: ColorConstants.grayLightColor,
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
              ),
              36.0.spaceY,
            ],
            AreaOfExpertiseWidget(),
            ExpertDetailsButtonWidget(
              title: StringConstants.requestCallNow,
              buttonColor: ColorConstants.requestCallNowColor,
              onTap: () {
                context.toPushNamed(RoutesConstants.videoCallScreen);
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
                ),
              ),
            ),
            26.0.spaceY,
            OverallRatingWidget(name: RatingEnum.EXPERTISE.name, value: 5),
            OverallRatingWidget(name: RatingEnum.COMMUNICATION.name, value: 5),
            OverallRatingWidget(name: RatingEnum.HELPFULNESS.name, value: 5),
            OverallRatingWidget(name: RatingEnum.EMPATHY.name, value: 5),
            OverallRatingWidget(name: RatingEnum.PROFESSIONALISM.name, value: 5),
            40.0.spaceY,
            ReviewsAndRatingWidget(
              title: StringConstants.reviews,
              buttonColor: ColorConstants.yellowButtonColor,
              child: SizedBox.shrink(),
            ),
            20.0.spaceY,
            ShortReviewWidget(dropdownValue: 'Highest to Lowest'),
            30.0.spaceY,
            ReviewsWidget(),
            20.0.spaceY,
          ],
        ),
      ).addAllPadding(28),
    );
  }
}
