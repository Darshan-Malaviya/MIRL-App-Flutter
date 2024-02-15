import 'package:flutter/material.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';

class ShortReviewWidget extends StatelessWidget {
  final String dropdownValue;

  const ShortReviewWidget({super.key, required this.dropdownValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LabelSmallText(
          title: StringConstants.sortReviews,
          fontSize: 10,
          fontFamily: FontWeightEnum.w400.toInter,
        ),
        20.0.spaceX,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: ShapeDecoration(
            color: ColorConstants.whiteColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: ColorConstants.dropDownBorderColor),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: LabelSmallText(
            title: dropdownValue.toUpperCase(),
            fontSize: 10,
            fontFamily: FontWeightEnum.w400.toInter,
            titleColor: ColorConstants.textColor,
          ),
        ),
      ],
    );
  }
}
