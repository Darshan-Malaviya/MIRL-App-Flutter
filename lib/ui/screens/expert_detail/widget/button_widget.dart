import 'package:flutter/material.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/margin_extension.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';

class ExpertDetailsButtonWidget extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Color? buttonColor;
  final bool? isSubTitle;
  final double? height;
  final double? width;

  const ExpertDetailsButtonWidget(
      {Key? key, required this.title, this.titleColor, this.buttonColor, this.isSubTitle = false, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 45,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shadows: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 2,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
        color: buttonColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: TitleSmallText(
              title: StringConstants.requestCallNow,
              fontFamily: FontWeightEnum.w700.toInter,
              titleTextAlign: TextAlign.center,
              titleColor: ColorConstants.blueColor,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: LabelSmallText(
              maxLine: 2,
              title: 'EXPERT\nONLINE!',
              fontFamily: FontWeightEnum.w700.toInter,
              titleTextAlign: TextAlign.start,
              titleColor: ColorConstants.blueColor,
              fontSize: 10,
            ).addMarginX(6),
          ).addMarginX(10),
        ],
      ),
    );
  }
}
