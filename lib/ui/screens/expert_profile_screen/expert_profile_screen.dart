import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/read_more/readmore.dart';
import 'package:mirl/ui/screens/expert_detail/widget/area_of_expertise_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/certifications_and_experience_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_rating_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/rating_widget.dart';
import 'package:mirl/ui/screens/share_expert_profile_screen/share_expert_profile_screen.dart';

class ExpertProfileScreen extends ConsumerStatefulWidget {
  const ExpertProfileScreen({super.key});

  @override
  ConsumerState<ExpertProfileScreen> createState() => _ExpertProfileScreenState();
}

class _ExpertProfileScreenState extends ConsumerState<ExpertProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //ref.read(editExpertProvider).getUserData();
      await ref.read(expertDetailProvider).getExpertDetailApiCall(userId: SharedPrefHelper.getUserId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(expertDetailProvider);
    final expertRead = ref.read(expertDetailProvider);
    String? fee;
    if (expertWatch.userData?.fee != null) {
      double data = (expertWatch.userData?.fee?.toDouble() ?? 0.0) / 100;
      fee = data.toStringAsFixed(2);
    }
    print('testing screen =======${expertWatch.userData?.expertName ?? ''}');
    print('screen =======${fee}');
    return Scaffold(
      appBar: AppBarWidget(preferSize: 0,
        appBarColor: ColorConstants.greyLightColor,
      ),
      backgroundColor: ColorConstants.whiteColor,
      body: GestureDetector(
        onVerticalDragDown: (tap) {
          Future.delayed(Duration(milliseconds: 200)).then((value) => HapticFeedback.heavyImpact());
        },
        child: RefreshIndicator(
          color: ColorConstants.primaryColor,
          onRefresh: () async {
            await ref.read(expertDetailProvider).getExpertDetailApiCall(userId: SharedPrefHelper.getUserId);
          },
          child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
               slivers:[
                  SliverAppBar(
                      backgroundColor: ColorConstants.transparentColor,
                      //floating: false,
                      pinned: true,
                      centerTitle: true,
                      expandedHeight: 366.0,
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
                          child: Center(
                            child: HeadlineMediumText(
                              //title: expertWatch.expertName.isNotEmpty ? expertWatch.expertName : LocaleKeys.yourExpertName.tr(),
                              title: expertWatch.userData?.expertName?.isNotEmpty ?? false
                                  ? expertWatch.userData?.expertName ?? ''
                                  : LocaleKeys.yourExpertName.tr(),
                              fontSize: 30,
                              titleColor: ColorConstants.bottomTextColor,
                              maxLine: 2,
                              titleTextAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      // bottom: AppBar(
                      //   // elevation: 20,
                      //   title: Center(
                      //     child: HeadlineMediumText(
                      //       //title: expertWatch.expertName.isNotEmpty ? expertWatch.expertName : LocaleKeys.yourExpertName.tr(),
                      //       title: expertWatch.userData?.expertName?.isNotEmpty ?? false
                      //           ? expertWatch.userData?.expertName ?? ''
                      //           : LocaleKeys.yourExpertName.tr(),
                      //       fontSize: 30,
                      //       titleColor: ColorConstants.bottomTextColor,
                      //       maxLine: 2,
                      //       titleTextAlign: TextAlign.center,
                      //     ),
                      //   ),
                      //   backgroundColor: Colors.white,
                      //   toolbarHeight: 64.0,
                      // ),
                      flexibleSpace: NetworkImageWidget(
                        imageURL: expertWatch.userData?.expertProfile ?? '',
                        isNetworkImage: true,
                        emptyImageWidget: Image.asset(ImageConstants.exploreImage, fit: BoxFit.fitWidth, width: double.infinity),
                        boxFit: BoxFit.cover,
                      )),
                 SliverToBoxAdapter(
                 child: SingleChildScrollView(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       // Center(
                       //   child: HeadlineMediumText(
                       //     //title: expertWatch.expertName.isNotEmpty ? expertWatch.expertName : LocaleKeys.yourExpertName.tr(),
                       //     title: expertWatch.userData?.expertName?.isNotEmpty ?? false
                       //         ? expertWatch.userData?.expertName ?? ''
                       //         : LocaleKeys.yourExpertName.tr(),
                       //     fontSize: 30,
                       //     titleColor: ColorConstants.bottomTextColor,
                       //     maxLine: 2,
                       //     titleTextAlign: TextAlign.center,
                       //   ),
                       // ),
                       // 28.0.spaceY,
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
                                 // expertWatch.overAllRating != '0' ? expertWatch.overAllRating ?? '' : LocaleKeys.newText.tr(),
                                 expertWatch.userData?.overAllRating != 0 && expertWatch.userData?.overAllRating != null
                                     ? expertWatch.userData?.overAllRating.toString() ?? ''
                                     : LocaleKeys.newText.tr(),
                                 maxLines: 1,
                                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                   color: ColorConstants.overallRatingColor,
                                   shadows: [
                                     Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))
                                   ],
                                 ),
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
                               AutoSizeText(
                                 //fee != 0 ? '\$${fee}' : LocaleKeys.proBono.tr(),
                                   fee != null || expertWatch.userData?.fee != 0 ?'\$${fee}' : LocaleKeys.proBono.tr(),
                                 maxLines: 1,
                                   textAlign: TextAlign.center,
                                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                   color: ColorConstants.overallRatingColor,
                                   shadows: [
                                     Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))
                                   ],
                                 ),
                               ),
                             ],
                           ),
                         ],
                       ),
                       28.0.spaceY,
                       Row(
                         children: [
                           Flexible(
                             child: PrimaryButton(
                               title: StringConstants.editProfile,
                               buttonTextFontFamily: FontWeightEnum.w400.toInter,
                               onPressed: () => context.toPushNamed(RoutesConstants.editYourExpertProfileScreen),
                             ),
                           ),
                           44.0.spaceX,
                           Flexible(
                             child: PrimaryButton(
                               title: StringConstants.shareProfile,
                               buttonTextFontFamily: FontWeightEnum.w400.toInter,
                               onPressed: () {
                                 // CommonBottomSheet.bottomSheet(
                                 //     context: context, backgroundColor: ColorConstants.whiteColor, child: DemoScreenScreen());
                                 CommonBottomSheet.bottomSheet(
                                     backgroundColor:
                                         //Color(0xCC7E3490)
                                         ColorConstants.shareProfileBgColor.withOpacity(0.80),
                                     context: context,
                                     isDismissible: true,
                                     child: shareExpertProfileScreen());
                               },
                             ),
                           ),
                         ],
                       ),
                       42.0.spaceY,
                       TitleMediumText(
                         title: StringConstants.moreAboutMe,
                         titleColor: ColorConstants.blueColor,
                       ),
                       12.0.spaceY,
                       if (expertWatch.userData?.about?.isNotEmpty ?? false) ...[
                         ReadMoreText(
                           style: TextStyle(fontSize: 16, fontFamily: FontWeightEnum.w400.toInter),
                           //expertWatch.about,
                           expertWatch.userData?.about ?? '',
                           trimLines: 10,
                           trimMode: TrimMode.Line,
                           trimCollapsedText: LocaleKeys.readMore.tr(),
                           trimExpandedText: ' ${LocaleKeys.readLess.tr()}',
                           moreStyle: TextStyle(fontSize: 16, color: ColorConstants.bottomTextColor.withOpacity(0.7)),
                           lessStyle: TextStyle(fontSize: 16, color: ColorConstants.bottomTextColor.withOpacity(0.7)),
                         ),
                       ] else ...[
                         TitleMediumText(
                           title: StringConstants.welcomeExpertProfile,
                           fontFamily: FontWeightEnum.w400.toInter,
                           maxLine: 2,
                         ),
                         20.0.spaceY,
                         TitleMediumText(
                           fontFamily: FontWeightEnum.w400.toInter,
                           title: StringConstants.soWhatNext,
                           maxLine: 10,
                         ),
                         20.0.spaceY,
                         TitleMediumText(
                           fontFamily: FontWeightEnum.w400.toInter,
                           title: StringConstants.clickEditProfile,
                           maxLine: 6,
                         ),
                         20.0.spaceY,
                         TitleMediumText(
                           fontFamily: FontWeightEnum.w400.toInter,
                           title: StringConstants.goodLuck,
                           maxLine: 10,
                         ),
                       ],
                       30.0.spaceY,
                       AreaOfExpertiseWidget(),
                       40.0.spaceY,
                       CertificationAndExperienceWidget(),
                       if (expertWatch.userData?.isLocationVisible == true) ...[
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
                                 text: '${expertWatch.userData?.city ?? ''}, ${expertWatch.userData?.country ?? ''}',
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
                       if (expertWatch.userData?.gender != null) ...[
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
                                 text: expertRead.userGender(),
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
                             onPress: () =>
                                 context.toPushNamed(RoutesConstants.ratingAndReviewScreen, args: expertWatch.userData?.id),
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
                                   text: expertWatch.userData?.overAllRating?.toString() ?? '0',
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
                       if (expertWatch.userData?.ratingCriteria?.isNotEmpty ?? false) ...[
                         OverallRatingWidget(
                             name: RatingEnum.EXPERTISE.name, value: expertWatch.userData?.ratingCriteria?[0].rating ?? 0),
                         OverallRatingWidget(
                             name: RatingEnum.COMMUNICATION.name, value: expertWatch.userData?.ratingCriteria?[1].rating ?? 0),
                         OverallRatingWidget(
                             name: RatingEnum.HELPFULNESS.name, value: expertWatch.userData?.ratingCriteria?[2].rating ?? 0),
                         OverallRatingWidget(
                             name: RatingEnum.EMPATHY.name, value: expertWatch.userData?.ratingCriteria?[3].rating ?? 0),
                         OverallRatingWidget(
                             name: RatingEnum.PROFESSIONALISM.name, value: expertWatch.userData?.ratingCriteria?[4].rating ?? 0),
                       ],
                       if (expertWatch.userData?.expertReviews?.isNotEmpty ?? false) ...[
                         40.0.spaceY,
                         ReviewsAndRatingWidget(
                           title: StringConstants.reviews,
                           buttonColor: ColorConstants.yellowButtonColor,
                           child: SizedBox.shrink(),
                         ),
                         30.0.spaceY,
                         ReviewWidget(reviews: expertWatch.userData?.expertReviews ?? []),
                       ],
                     ],
                   ).addAllPadding(28),
                 ),
               )
              //    },
              // ),
            ]
              ),
        ),
      ),
    );
  }
}
