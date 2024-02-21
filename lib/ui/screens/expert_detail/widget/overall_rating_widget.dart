import 'package:flutter/material.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/margin_extension.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';

class OverallRatingWidget extends StatelessWidget {
  final String name;
  final int? value;

  OverallRatingWidget({
    Key? key,
    required this.name,
    required this.value,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleSmallText(
          fontSize: 13,
          title: name,
          titleColor: ColorConstants.blueColor,
          titleTextAlign: TextAlign.start,
        ),
        Row(
            children: List.generate(5, (index) {
          return Container(
            width: 18,
            height: 12,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: index + 1 <= value! ? ColorConstants.primaryColor : ColorConstants.ratingColor,
              boxShadow: [
                BoxShadow(
                  color: Color(0x4C000000),
                  blurRadius: 3,
                  offset: Offset(0, 3),
                  spreadRadius: 0,
                )
              ],
            ),
          );
        })),
      ],
    ).addMarginXY(marginY: 6, marginX: 14);
  }
}
