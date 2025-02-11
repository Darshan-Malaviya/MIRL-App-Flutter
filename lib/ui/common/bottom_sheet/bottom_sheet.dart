import 'dart:ui';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class CommonBottomSheet {
  static bottomSheet(
      {required BuildContext context,
      required Widget child,
      TickerProvider? vsync,
      double? height,
      double? width,
        bool? isShadowContainer,
        Color? backgroundColor,
      VoidCallback? onTap,
        BoxConstraints? constraints,
      Widget? suffixIcon,
      isDismissible = false}) async {
    showModalBottomSheet(
      context: context,
      barrierColor: ColorConstants.blackColor.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: isDismissible,
      transitionAnimationController:
          vsync != null ? AnimationController(vsync: vsync, duration: const Duration(milliseconds: 500), reverseDuration: const Duration(milliseconds: 300)) : null,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: Container(
                constraints: constraints ?? BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
                decoration: BoxDecoration(
                  color: backgroundColor ?? ColorConstants.scaffoldColor,
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
                    if(isShadowContainer?? true)
                    ShadowContainer(
                      margin: const EdgeInsets.all(16),
                      isShadow: false,
                      height: 4,
                      backgroundColor: ColorConstants.greyColor,
                      child: 10.0.spaceX,
                    ),
                    Flexible(child: child),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
