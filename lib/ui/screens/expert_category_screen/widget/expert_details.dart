import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/read_more/readmore.dart';

class ExpertDetailWidget extends StatelessWidget {
  const ExpertDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      width: double.infinity,
      shadowColor: ColorConstants.borderColor,
      offset: Offset(2, 2),
      border: 15,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Stack(
            children: [
              NetworkImageWidget(
                imageURL: 'https://via.placeholder.com/304x239',
                isNetworkImage: true,
                height: 240,
                width: double.infinity,
                boxFit: BoxFit.cover,
              ),
              Column(
                children: [
                  180.0.spaceY,
                  ShadowContainer(
                    border: 20,
                    shadowColor: ColorConstants.borderColor,
                    offset: Offset(0, 3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BodyMediumText(title: 'PREETI TEWARI SERAI'),
                        8.0.spaceY,
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 0,
                          children: List.generate(
                              8,
                              (index) => Container(
                                    color: ColorConstants.sliderColor,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                    child: BodyMediumText(
                                      title: 'Budy',
                                      fontFamily: FontWeightEnum.w400.toInter,
                                    ),
                                  )),
                        )
                      ],
                    ).addAllPadding(10),
                  ),
                  28.0.spaceY,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          BodySmallText(
                            title: StringConstants.overallRatting,
                            fontFamily: FontWeightEnum.w400.toInter,
                          ),
                          3.0.spaceX,
                          HeadlineLargeText(title: '9', titleColor: ColorConstants.bottomTextColor)
                        ],
                      ),
                      Row(
                        children: [
                          BodySmallText(
                            title: StringConstants.feePer,
                            fontFamily: FontWeightEnum.w400.toInter,
                          ),
                          5.0.spaceX,
                          HeadlineLargeText(title: '\$9', titleColor: ColorConstants.bottomTextColor)
                        ],
                      ),
                    ],
                  ),
                  10.0.spaceY,
                  Align(alignment: Alignment.centerLeft, child: BodySmallText(title: StringConstants.aboutMe)),
                  5.0.spaceY,
                  ReadMoreText(
                    style: TextStyle(fontSize: 14, fontFamily: FontWeightEnum.w400.toInter),
                    'In love with everything about life, I would love to share my thoughts and advice with you on topics that include and filler text ',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: LocaleKeys.readMore.tr(),
                    trimExpandedText: LocaleKeys.readLess.tr(),
                    moreStyle: TextStyle(fontSize: 14, color: ColorConstants.bottomTextColor),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
