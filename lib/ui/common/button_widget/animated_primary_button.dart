import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/commons/constants/color_constants.dart';
import 'package:flutter_boilerplate_may_2023/ui/common/animations/scale_tap_animation.dart';
import 'package:flutter_boilerplate_may_2023/ui/common/loader/three_bounce.dart';
import 'package:flutter_boilerplate_may_2023/ui/common/text_widgets/base/text_widgets.dart';

class AnimatedPrimaryButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? loaderSize;
  final Color? buttonColor;
  final Color? textColor;
  final Color? shadowColor;
  final bool? isShadow;
  final bool? isLoading;
  final String text;
  final VoidCallback onTap;

  const AnimatedPrimaryButton(
      {super.key,
      this.borderRadius,
      this.buttonColor,
      this.textColor,
      this.shadowColor,
      this.isShadow = true,
      required this.text,
      this.height,
      this.width,
      required this.onTap,
      this.isLoading = false,
      this.loaderSize});

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: onTap,
      duration: const Duration(milliseconds: 100),
      child: Container(
        decoration: BoxDecoration(
            color: buttonColor ?? Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 100),
            boxShadow: (isShadow ?? false)
                ? const [
                    BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(0, 3)),
                  ]
                : []),
        height: height ?? 46,
        width: width ?? MediaQuery.of(context).size.width * 0.95,
        child: Center(
          child: (isLoading ?? false)
              ? SpinKitThreeBounce(
                  color: textColor ?? ColorConstants.whiteColor,
                  size: loaderSize ?? 24,
                )
              : BodyLargeText(
                  title: text,
                  titleColor: textColor ?? ColorConstants.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
        ),
      ),
    );
  }
}
