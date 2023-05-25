import 'dart:ui';

import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';

class CommonAlertDialog {
  static dialog({
    required BuildContext context,
    required Widget child,
    double? height,
    double? width,
    bool? barrierDismissible,
    double? borderRadius,
  }) {
    return showDialog(
        context: context,
        barrierColor: ColorConstants.blackColor.withOpacity(0.2),
        barrierDismissible: barrierDismissible ?? true,
        builder: (BuildContext context) {
          final maxWidth = MediaQuery.of(context).size.width;
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4.0,
              sigmaY: 4.0,
            ),
            child: ZoomInAnimation(
              child: Dialog(
                insetPadding: PaddingConstant.scaffoldPadding,
                child: Container(
                    padding: PaddingConstant.alertDialogPadding,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius ?? RadiusConstant.alertdialogRadius),
                        color: ColorConstants.scaffoldColor),
                    height: height,
                    width: width ?? maxWidth,
                    child: child),
              ),
            ),
          );
        });
  }

  static successDialog({
    required BuildContext context,
    required String message,
    double? height,
    double? width,
    bool? barrierDismissible,
    double? borderRadius,
  }) {
    return showDialog(
        context: context,
        barrierColor: ColorConstants.blackColor.withOpacity(0.2),
        barrierDismissible: barrierDismissible ?? true,
        builder: (BuildContext context) {
          final maxWidth = MediaQuery.of(context).size.width;
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: ZoomInAnimation(
              child: Dialog(
                insetPadding: PaddingConstant.scaffoldPadding,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius ?? RadiusConstant.alertdialogRadius),
                      color: ColorConstants.scaffoldColor),
                  height: height,
                  width: width ?? maxWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image.asset(ImageConstants.successIcon),
                      16.0.spaceY,
                      TitleLargeText(
                        title: message,
                        fontWeight: FontWeight.w600,
                        titleColor: ColorConstants.primaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  static permissionAlert({
    required BuildContext context,
    required Widget child,
    double? height,
    double? width,
    bool? barrierDismissible,
    double? borderRadius,
    required String acceptButtonTitle,
    required String discardButtonTitle,
    required VoidCallback onAcceptTap,
    VoidCallback? onDiscardTap,
  }) {
    return showDialog(
        context: context,
        barrierColor: ColorConstants.blackColor.withOpacity(0.2),
        barrierDismissible: barrierDismissible ?? false,
        builder: (BuildContext context) {
          final maxWidth = MediaQuery.of(context).size.width;
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: ZoomInAnimation(
              child: Dialog(
                insetPadding: PaddingConstant.scaffoldPadding,
                backgroundColor: ColorConstants.transparentColor,
                child: Container(
                  padding: PaddingConstant.alertDialogPadding,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius ?? RadiusConstant.alertdialogRadius),
                      color: ColorConstants.scaffoldColor),
                  height: height,
                  width: width ?? maxWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      16.0.spaceY,
                      child,
                      32.0.spaceY,
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              title: discardButtonTitle,
                              onPressed: onDiscardTap ?? () => Navigator.pop(context),
                              buttonColor: ColorConstants.scaffoldColor,
                              titleColor: ColorConstants.primaryColor,
                            ),
                          ),
                          16.0.spaceX,
                          Expanded(child: PrimaryButton(title: acceptButtonTitle, onPressed: onAcceptTap)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

static fullScreenDialog({
  required BuildContext context,
  required Widget child,
  Color? backgroundColor,
  Color? barrierColor,
  double? height,
  double? width,
  bool? barrierDismissible,
  double? borderRadius,
}) {
  return showDialog(
      context: context,
      barrierColor: barrierColor ?? ColorConstants.primaryColor.withOpacity(0.5),
      barrierDismissible: barrierDismissible ?? false,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          backgroundColor: backgroundColor,
          child: child,
        );
      });
}
}
