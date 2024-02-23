import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/ui/common/rating_bar_widgets/star_rating_widget.dart';
import 'package:mirl/ui/common/read_more/readmore.dart';

class ReviewWidget extends StatelessWidget {
  final List<ExpertReviews> reviews;

  const ReviewWidget({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          reviews.length,
          (index) => Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: ShapeDecoration(
                  color: ColorConstants.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x335E0774),
                      blurRadius: 5,
                      offset: Offset(-3, -3),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    StarRating(
                      onRatingChanged: (value) {},
                      rating: reviews[index].rating?.toDouble() ?? 0,
                    ),
                    14.0.spaceY,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${LocaleKeys.user.tr()}: ',
                                  style: TextStyle(
                                    color: ColorConstants.buttonTextColor,
                                    fontFamily: FontWeightEnum.w400.toInter,
                                  )),
                              TextSpan(
                                  text: reviews[index].userName,
                                  style: TextStyle(
                                    color: ColorConstants.buttonTextColor,
                                    fontFamily: FontWeightEnum.w700.toInter,
                                  ))
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        BodySmallText(
                          title: reviews[index].firstCreated?.toLocalFullDateWithoutSuffix() ?? '',
                          fontFamily: FontWeightEnum.w400.toInter,
                          titleColor: ColorConstants.buttonTextColor,
                        ),
                      ],
                    ),
                    18.0.spaceY,
                    ReadMoreText(
                      reviews[index].review ?? '',
                      style: TextStyle(fontSize: 14, fontFamily: FontWeightEnum.w400.toInter),
                      trimLines: 5,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: LocaleKeys.readMore.tr(),
                      trimExpandedText: LocaleKeys.readLess.tr(),
                      moreStyle: TextStyle(fontSize: 14, color: ColorConstants.bottomTextColor, fontFamily: FontWeightEnum.w400.toInter),
                      lessStyle: TextStyle(fontSize: 14, color: ColorConstants.bottomTextColor, fontFamily: FontWeightEnum.w400.toInter),
                    ),
                  ],
                ),
              ).addPaddingBottom(30)),
    ).addMarginX(14);
  }
}
