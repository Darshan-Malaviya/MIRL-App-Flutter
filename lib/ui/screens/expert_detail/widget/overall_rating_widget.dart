import 'package:flutter/material.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/margin_extension.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';

class OverallRatingWidget extends StatefulWidget {
  final String name;
  final int? value;

  OverallRatingWidget({
    Key? key,
    required this.name,
    required this.value,
  }) : super(key: key);

  @override
  State<OverallRatingWidget> createState() => _OverallRatingWidgetState();
}

class _OverallRatingWidgetState extends State<OverallRatingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleSmallText(
              fontSize: 13,
              title: widget.name,
              fontFamily: FontWeightEnum.w600.toInter,
              titleTextAlign: TextAlign.start,
              titleColor: ColorConstants.blackColor,
            ).addMarginX(12),
            Row(
                children: List.generate(5, (index) {
              return Container(
                width: 18,
                height: 12,
                decoration: BoxDecoration(
                  color: ColorConstants.categoryListBorder,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x4C000000),
                      blurRadius: 3,
                      offset: Offset(0, 3),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ).addMarginX(4);
            })),
          ],
        ).addMarginY(6),
      ],
    );
  }
}
