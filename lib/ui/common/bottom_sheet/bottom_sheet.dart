import 'dart:ui';
import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';

class CommonBottomSheet {
  static bottomSheet(
      {required BuildContext context,
      required Widget child,
      TickerProvider? vsync,
      double? height,
      double? width,
      VoidCallback? onTap,
      Widget? suffixIcon,
      isDismissible = false}) async {
    showModalBottomSheet(
      context: context,
      barrierColor: ColorConstants.blackColor.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: isDismissible,
      transitionAnimationController: vsync != null
          ? AnimationController(
              vsync: vsync, duration: const Duration(milliseconds: 500), reverseDuration: const Duration(milliseconds: 300))
          : null,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimatedContainer(
          duration: const Duration(seconds: 1),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: Container(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
              decoration: BoxDecoration(
                color: ColorConstants.scaffoldColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(RadiusConstant.alertdialogRadius),
                  topRight: Radius.circular(RadiusConstant.alertdialogRadius),
                ),
              ),
              width: width ?? MediaQuery.of(context).size.width,
              height: height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShadowContainer(
                    margin: const EdgeInsets.all(16),
                    isShadow: false,
                    height: 4,
                    backgroundColor: ColorConstants.greyColor,
                    child: 10.0.spaceX,
                  ),
                  child,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
