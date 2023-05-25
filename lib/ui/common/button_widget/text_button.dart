import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';

class TextButtonWidget extends StatelessWidget {
  final Color? titleColor;
  final String title;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final VoidCallback onPressed;
  final bool? isDisable;
  final String? prefixIcon;
  final double? fontSize;
  final double? lineHeight;
  final Widget? suffix;
  final FontWeight? fontWeight;

  const TextButtonWidget(
      {Key? key,
      this.titleColor,
      required this.title,
      this.height,
      this.width,
      this.padding,
      required this.onPressed,
      this.isDisable,
      this.lineHeight,
      this.prefixIcon,
      this.fontSize,
      this.suffix,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 30,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          surfaceTintColor: ColorConstants.transparentColor,
          backgroundColor: ColorConstants.transparentColor,
          foregroundColor: ColorConstants.primaryColor,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            BodyMediumText(fontSize: fontSize ?? 14, title: title, fontWeight: fontWeight ?? FontWeight.w600, titleColor: titleColor),
            suffix != null ? 6.0.spaceX : const SizedBox.shrink(),
            suffix != null ? suffix ?? const SizedBox.shrink() : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
