import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/margin_extension.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';

class ExpertDetailsButtonWidget extends StatelessWidget {
  final String title;
  final String suffixTitle;
  final Color? titleColor;
  final Color? buttonColor;
  final double? height;
  final double? width;
  final VoidCallback onTap;

  const ExpertDetailsButtonWidget({
    Key? key,
    required this.title,
    this.titleColor,
    this.buttonColor,
    this.height,
    this.width,
    required this.onTap,
    required this.suffixTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 45,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          shadows: [
            BoxShadow(
              color: ColorConstants.topicShoeColorColor,
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
                title: title,
                titleTextAlign: TextAlign.center,
                titleColor: ColorConstants.buttonTextColor,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: LabelSmallText(
                maxLine: 2,
                title: suffixTitle,
                titleTextAlign: TextAlign.start,
                titleColor: ColorConstants.buttonTextColor,
                fontSize: 10,
              ),
            ).addMarginX(10),
          ],
        ),
      ),
    );
  }
}
