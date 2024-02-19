import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_rating_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_widget.dart';
import 'package:mirl/ui/screens/rating_and_review_screen/widget/reviews_list_widget.dart';
import 'package:mirl/ui/screens/rating_and_review_screen/widget/short_by_widget.dart';

class RatingAndReviewScreen extends ConsumerStatefulWidget {
  const RatingAndReviewScreen({super.key});

  @override
  ConsumerState createState() => _RatingAndReviewScreenState();
}

class _RatingAndReviewScreenState extends ConsumerState<RatingAndReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final reportReviewWatch = ref.watch(reportReviewProvider);
    final reportReviewRead = ref.read(reportReviewProvider);

    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            10.0.spaceY,
            TitleLargeText(
              title: LocaleKeys.reviewAndRatingScreen.tr(),
              titleColor: ColorConstants.bottomTextColor,
            ),
            30.0.spaceY,
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
            OverallRatingWidget(name: RatingEnum.COMMUNICATION.name, value: 3),
            OverallRatingWidget(name: RatingEnum.HELPFULNESS.name, value: 2),
            OverallRatingWidget(name: RatingEnum.EMPATHY.name, value: 1),
            OverallRatingWidget(name: RatingEnum.PROFESSIONALISM.name, value: 4),
            20.0.spaceY,
            ReviewsAndRatingWidget(
              title: StringConstants.reviews,
              buttonColor: ColorConstants.yellowButtonColor,
              child: SizedBox.shrink(),
            ),
            20.0.spaceY,
            ShortByReview(
              value: reportReviewWatch.sortByReview,
              itemList: reportReviewWatch.sortByReviewItem,
              onChanged: reportReviewWatch.setSortByReview,
            ).addPaddingX(30),
            30.0.spaceY,
            ReviewListWidget(),
          ],
        ).addPaddingX(20),
      ),
    );
  }
}
