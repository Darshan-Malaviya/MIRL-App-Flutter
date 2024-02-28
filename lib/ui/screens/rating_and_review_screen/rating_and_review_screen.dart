import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_rating_widget.dart';
import 'package:mirl/ui/screens/expert_detail/widget/overall_widget.dart';
import 'package:mirl/ui/screens/rating_and_review_screen/widget/reviews_list_widget.dart';
import 'package:mirl/ui/screens/rating_and_review_screen/widget/short_by_widget.dart';

class RatingAndReviewScreen extends ConsumerStatefulWidget {
  final int id;

  const RatingAndReviewScreen({super.key, required this.id});

  @override
  ConsumerState createState() => _RatingAndReviewScreenState();
}

class _RatingAndReviewScreenState extends ConsumerState<RatingAndReviewScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(reportReviewProvider).getRatingAndReviewApiCall(isLoading: true, id: widget.id, isListLoading: false);
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(reportReviewProvider).reachedLastPage;
        if (!isLoading) {
          ref.read(reportReviewProvider).getRatingAndReviewApiCall(isLoading: false, id: widget.id, isListLoading: false);
        } else {
          log('reach last page on review list api');
        }
      }
    });
    super.initState();
  }

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
      body: reportReviewWatch.isLoading
          ? Center(child: CupertinoActivityIndicator(color: ColorConstants.primaryColor))
          : SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  10.0.spaceY,
                  TitleLargeText(
                    title: LocaleKeys.reviewAndRatingScreen.tr(),
                    titleColor: ColorConstants.bottomTextColor,
                    titleTextAlign: TextAlign.center,
                    maxLine: 2,
                  ),
                  30.0.spaceY,
                  if (reportReviewWatch.reviewAndRatingData?.ratingCriteria?.isNotEmpty ?? false) ...[
                    ReviewsAndRatingWidget(
                      title: StringConstants.overallRating,
                      buttonColor: ColorConstants.yellowButtonColor,
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: reportReviewWatch.reviewAndRatingData?.overAllRating.toString(),
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
                    OverallRatingWidget(name: RatingEnum.EXPERTISE.name, value: reportReviewWatch.reviewAndRatingData?.ratingCriteria?[0].rating ?? 0),
                    OverallRatingWidget(name: RatingEnum.COMMUNICATION.name, value: reportReviewWatch.reviewAndRatingData?.ratingCriteria?[1].rating ?? 0),
                    OverallRatingWidget(name: RatingEnum.HELPFULNESS.name, value: reportReviewWatch.reviewAndRatingData?.ratingCriteria?[2].rating ?? 0),
                    OverallRatingWidget(name: RatingEnum.EMPATHY.name, value: reportReviewWatch.reviewAndRatingData?.ratingCriteria?[3].rating ?? 0),
                    OverallRatingWidget(name: RatingEnum.PROFESSIONALISM.name, value: reportReviewWatch.reviewAndRatingData?.ratingCriteria?[4].rating ?? 0),
                  ],
                  20.0.spaceY,
                  if (reportReviewWatch.reviewAndRatingData?.expertReviews?.isNotEmpty ?? false) ...[
                    ReviewsAndRatingWidget(
                      title: StringConstants.reviews,
                      buttonColor: ColorConstants.yellowButtonColor,
                      child: SizedBox.shrink(),
                    ),
                    20.0.spaceY,
                    ShortByReview(
                      value: reportReviewWatch.sortByReview,
                      itemList: reportReviewWatch.sortByReviewItem,
                      onChanged: (value) {
                        reportReviewWatch.setSortByReview(value, widget.id);
                      },
                    ).addPaddingX(30),
                    30.0.spaceY,
                    if (!reportReviewWatch.isListLoading) ...[
                      ReviewListWidget()
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(child: CupertinoActivityIndicator(color: ColorConstants.primaryColor)),
                      )
                    ]
                  ] else ...[
                    Center(
                      child: BodyMediumText(
                        title: LocaleKeys.noReviewFound.tr(),
                      ),
                    )
                  ],
                ],
              ).addPaddingX(20),
            ),
    );
  }
}
