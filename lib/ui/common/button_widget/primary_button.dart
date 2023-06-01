import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final String? prefixIcon;
  final double? prefixIconPadding;
  final VoidCallback onPressed;
  final double? lineHeight;
  final Color? titleColor;
  final Color? buttonColor;

  const PrimaryButton({
    Key? key,
    required this.title,
    this.height,
    this.width,
    this.padding,
    this.prefixIconPadding,
    required this.onPressed,
    this.prefixIcon,
    this.lineHeight,
    this.titleColor,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          surfaceTintColor: buttonColor ?? ColorConstants.primaryColor,
          backgroundColor: buttonColor ?? ColorConstants.primaryColor,
          foregroundColor: ColorConstants.whiteColor,
          splashFactory: NoSplash.splashFactory,
          enableFeedback: false,
          elevation: 0,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(RadiusConstant.commonRadius),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (prefixIcon?.isNotEmpty ?? false) && prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(right: prefixIconPadding ?? 8.0),
                    child: Image.asset(prefixIcon ?? ''),
                  )
                : const SizedBox.shrink(),
            BodyMediumText(
              title: title,
              fontWeight: FontWeight.w600,
              titleColor: titleColor ?? ColorConstants.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
