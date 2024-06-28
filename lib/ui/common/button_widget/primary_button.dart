import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/loader/three_bounce.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final String? prefixIcon;
  final double? prefixIconPadding;
  final VoidCallback onPressed;
  final double? lineHeight;
  final Color? titleColor;
  final Color? buttonColor;
  final String? buttonTextFontFamily;
  final double? fontSize;
  final bool? isLoading;
  final double? blurRadius;
  final double? spreadRadius;
  final Offset? offset;

  const PrimaryButton(
      {Key? key,
      required this.title,
      this.height,
      this.width,
      this.padding,
      this.margin,
      this.prefixIconPadding,
      required this.onPressed,
      this.prefixIcon,
      this.lineHeight,
      this.titleColor,
      this.buttonColor,
      this.buttonTextFontFamily,
      this.fontSize,
      this.isLoading,
      this.blurRadius,
      this.spreadRadius,
      this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), shadows: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: blurRadius ?? 2,
            offset: offset ?? Offset(0, 2),
            spreadRadius: spreadRadius ?? 0,
          )
        ]),
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 45,
        margin: margin,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            surfaceTintColor: buttonColor ?? ColorConstants.primaryColor,
            backgroundColor: buttonColor ?? ColorConstants.primaryColor,
            foregroundColor: ColorConstants.whiteColor,
            splashFactory: NoSplash.splashFactory,
            enableFeedback: false,
            elevation: 0,
            padding: padding ?? const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(RadiusConstant.commonRadius),
              ),
            ),
          ),
          onPressed: onPressed,
          child: (isLoading ?? false)
              ? SpinKitThreeBounce(
                  color: ColorConstants.whiteColor,
                  size: 24,
                )
              : Row(
                  children: [
                    if ((prefixIcon?.isNotEmpty ?? false) && prefixIcon != null)
                      Image.asset(prefixIcon ?? '').addMarginRight(prefixIconPadding ?? 20),
                    Expanded(
                      child: Align(
                        alignment:
                            (prefixIcon?.isNotEmpty ?? false) && prefixIcon != null ? Alignment.centerLeft : Alignment.center,
                        child: BodyMediumText(
                          title: title,
                          fontFamily: buttonTextFontFamily ?? FontWeightEnum.w700.toInter,
                          titleColor: titleColor ?? ColorConstants.buttonTextColor,
                          titleTextAlign: TextAlign.center,
                          fontSize: fontSize ?? 13,
                          maxLine: 2,
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }
}
