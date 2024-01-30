import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/margin_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/ui/common/rating_bar_widgets/star_rating_widget.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';

class ReviewsWidget extends ConsumerStatefulWidget {
  const ReviewsWidget({super.key});

  @override
  ConsumerState<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends ConsumerState<ReviewsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(1, (index) {
      return Container(
        width: double.infinity,
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
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'User: ',
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
                  title: "21 November, 2023",
                  fontFamily: FontWeightEnum.w400.toInter,
                  titleColor: ColorConstants.buttonTextColor,
                ),
              ],
            ),
            18.0.spaceY,
            TitleSmallText(
              maxLine: 10,
              title:
                  "This is an optional description sample, LovePanky is a relationships and dating advice website and we’ll fill this line up to see how it looks if it’s quite a big description.",
              fontFamily: FontWeightEnum.w400.toInter,
              titleTextAlign: TextAlign.start,
              titleColor: ColorConstants.blueColor,
            ),
          ],
        ).addMarginXY(paddingX: 14, paddingY: 18),
      );
    })).addPaddingX(6);
  }
}
