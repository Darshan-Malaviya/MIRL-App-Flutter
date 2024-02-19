import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/datetime_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/ui/common/rating_bar_widgets/star_rating_widget.dart';
import 'package:mirl/ui/common/read_more/readmore.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';

class ReviewListWidget extends ConsumerStatefulWidget {
  const ReviewListWidget({super.key});

  @override
  ConsumerState<ReviewListWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends ConsumerState<ReviewListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 14),
      itemBuilder: (context, index) {
        return Container(
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
                rating: 2,
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
                            text: 'PREETI',
                            style: TextStyle(
                              color: ColorConstants.buttonTextColor,
                              fontFamily: FontWeightEnum.w700.toInter,
                            ))
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  BodySmallText(
                    title: '2024-02-14T05:33:05Z'.toLocalFullDateWithoutSuffix() ?? '',
                    fontFamily: FontWeightEnum.w400.toInter,
                    titleColor: ColorConstants.buttonTextColor,
                  ),
                ],
              ),
              18.0.spaceY,
              ReadMoreText(
                style: TextStyle(fontSize: 14, fontFamily: FontWeightEnum.w400.toInter),
                'This is an optional description sample, LovePanky is a relationships and dating advice website and we’ll fill this line up to see how it looks if it’s quite a big description.',
                trimLines: 5,
                trimMode: TrimMode.Line,
                trimCollapsedText: LocaleKeys.readMore.tr(),
                trimExpandedText: LocaleKeys.readLess.tr(),
                moreStyle: TextStyle(fontSize: 14, color: ColorConstants.bottomTextColor, fontFamily: FontWeightEnum.w400.toInter),
                lessStyle: TextStyle(fontSize: 14, color: ColorConstants.bottomTextColor, fontFamily: FontWeightEnum.w400.toInter),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => 20.0.spaceY,
    );
  }
}
