import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/dropdown_widget/dropdown_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/area_of_expertise_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/button_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/certifications_and_experience_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_rating_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/reviews_widget.dart';

class ExpertDetailScreen extends ConsumerStatefulWidget {
  const ExpertDetailScreen({super.key});

  @override
  ConsumerState<ExpertDetailScreen> createState() => _ExpertDetailScreenState();
}

class _ExpertDetailScreenState extends ConsumerState<ExpertDetailScreen> {
  List<String> reviews = ["HIGHEST REVIEW SCORE", "LOWEST REVIEW SCORE", "NEWEST REVIEWS", "OLDEST REVIEWS"];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(expertDetailProvider).getExpertDetailApiCall();
      //  _showBottomSheet();
    });
    super.initState();
  }

/*  Future<void> _showBottomSheet() async {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        backgroundColor: Colors.white,
        context: context,
        builder: (context){
          return DraggableScrollableSheet(
              minChildSize: 0.1,
              maxChildSize: 0.9,
              initialChildSize: 0.3,
              expand: true,
              builder: (context, scrollController) {
                return bottomSheetView(); //whatever you're returning, does not have to be a Container
              }
          );
        });
  }

  void openBottomSheet() {
    CommonBottomSheet.bottomSheet(context: context, child: bottomSheetView(), isDismissible: true);
  }*/

  Widget bottomSheetView({required ScrollController controller}) {
    final expertDetailWatch = ref.watch(expertDetailProvider);

    return Container(
      //height: MediaQuery.of(context).size.height * 0.9,
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
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: HeadlineMediumText(
                title: expertDetailWatch.userData?.expertName ?? '',
                fontFamily: FontWeightEnum.w700.toInter,
                fontSize: 30,
                titleColor: ColorConstants.bottomTextColor,
                titleTextAlign: TextAlign.center,
              ),
            ),
            22.0.spaceY,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    BodySmallText(
                      title: StringConstants.overallRatting,
                      fontFamily: FontWeightEnum.w700.toInter,
                    ),
                    4.0.spaceX,
                    HeadlineMediumText(
                      fontSize: 30,
                      title: '9',
                      fontFamily: FontWeightEnum.w700.toInter,
                      titleColor: ColorConstants.overallRatingColor,
                    ),
                  ],
                ),
                18.0.spaceY,
                Row(
                  children: [
                    BodySmallText(
                      title: StringConstants.feePer,
                      fontFamily: FontWeightEnum.w700.toInter,
                    ),
                    4.0.spaceX,
                    HeadlineMediumText(
                      fontSize: 30,
                      title: '\$20',
                      fontFamily: FontWeightEnum.w700.toInter,
                      titleColor: ColorConstants.overallRatingColor,
                    ),
                  ],
                ),
              ],
            ),
            36.0.spaceY,
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TitleMediumText(
                title: StringConstants.moreAboutMe,
                fontFamily: FontWeightEnum.w700.toInter,
              ),
            ),
            12.0.spaceY,
            TitleMediumText(
              title: expertDetailWatch.userData?.about ?? '',
              maxLine: 10,
            ),
            35.0.spaceY,
            AreaOfExpertiseWidget(),
            ExpertDetailsButtonWidget(
              title: StringConstants.requestCallNow,
              buttonColor: ColorConstants.requestCallNowColor,
            ),
            24.0.spaceY,
            PrimaryButton(
              title: StringConstants.scheduleCall,
              onPressed: () {},
              buttonColor: ColorConstants.scheduleCallColor,
            ),
            40.0.spaceY,
            CertificationAndExperienceWidget(),
            40.0.spaceY,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'LOCATION: ',
                    style: TextStyle(
                      color: ColorConstants.blueColor,
                      fontSize: 16,
                      fontFamily: FontWeightEnum.w700.toInter,
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
            30.0.spaceY,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'GENDER: ',
                    style: TextStyle(
                      color: ColorConstants.blueColor,
                      fontSize: 16,
                      fontFamily: FontWeightEnum.w700.toInter,
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
            Image.asset(ImageConstants.line),
            40.0.spaceY,
            TitleMediumText(
              title: StringConstants.reviewsAndRatting,
              fontFamily: FontWeightEnum.w600.toInter,
              titleTextAlign: TextAlign.start,
              titleColor: ColorConstants.blackColor,
            ),
            26.0.spaceY,
            ReviewsAndRatingWidget(
              title: StringConstants.overallRating,
              buttonColor: ColorConstants.scheduleCallColor,
              child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '9',
                              style: TextStyle(
                                color: Color(0xFF383636),
                                fontSize: 30,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0.05,
                                letterSpacing: -0.33,
                              ),
                            ),
                            TextSpan(
                              text: '/10',
                              style: TextStyle(
                                color: Color(0xFF383636),
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
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
              buttonColor: ColorConstants.scheduleCallColor,
              child: SizedBox.shrink(),
            ),
            30.0.spaceY,
            Row(
              children: [
                Expanded(
                  child: LabelSmallText(
                    title: StringConstants.sortByReviews,
                    fontFamily: FontWeightEnum.w400.toInter,
                    titleTextAlign: TextAlign.end,
                    titleColor: ColorConstants.blueColor,
                    fontSize: 10,
                  ),
                ),
                20.0.spaceX,
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    width: 140,
                    child: DropdownMenuWidget(
                      hintText: StringConstants.theDropDown,
                      dropdownList: reviews
                          .map((String item) => dropdownMenuEntry(
                                context: context,
                                value: item,
                                label: item,
                              ))
                          .toList(),
                      onSelect: (String value) {},
                    ),
                  ),
                ),
                20.0.spaceY,
              ],
            ),
            20.0.spaceY,
            ReviewsWidget(),
            20.0.spaceY,
          ],
        ),
      ).addAllPadding(28),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
        trailingIcon: InkWell(onTap: () {}, child: Icon(Icons.more_horiz)).addPaddingRight(14),
      ),
      body: Stack(
        children: [
          Image.asset(ImageConstants.expertDetail, fit: BoxFit.fitWidth, width: double.infinity),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.4,
            maxChildSize: 0.96,
            builder: (BuildContext context, myscrollController) {
              return bottomSheetView(controller: myscrollController);
            },
          ),
        ],
      ),
      /*    body: Stack(
        children: [
          Image.asset(ImageConstants.expertDetail, fit: BoxFit.fitWidth, width: double.infinity),
        //  bottomSheetView(),
          Positioned(
            bottom: 0,
            child: DraggableScrollableSheet(
                minChildSize: 0.1,
                maxChildSize: 0.9,
                initialChildSize: 0.3,
                expand: false,
                builder: (context, scrollController) {
                  return bottomSheetView();
                }
            ),
          ),

        ],
      ),*/
    );
  }
}
