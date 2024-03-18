import 'dart:ui';

import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class CommonAlertDialog {
  static dialog({
    required BuildContext context,
    required Widget child,
    double? height,
    double? width,
    bool? barrierDismissible,
    double? borderRadius,
    Color? bgColor,
    EdgeInsets? insetPadding,
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
                insetPadding: insetPadding ?? PaddingConstant.scaffoldPadding,
                child: Container(
                    padding: PaddingConstant.alertDialogPadding,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(borderRadius ?? RadiusConstant.alertdialogRadius), color: bgColor ?? ColorConstants.scaffoldColor),
                    height: height,
                    width: width ?? maxWidth,
                    child: child),
              ),
            ),
          );
        });
  }

  static callDialog({
    required BuildContext context,
    required Widget child,
    double? height,
    double? width,
    bool? barrierDismissible,
    double? borderRadius,
    EdgeInsets? insetPadding,
  }) {
    return showDialog(
        context: context,
        barrierColor: ColorConstants.blackColor.withOpacity(0.2),
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ZoomInAnimation(
            child: Dialog(
              insetPadding: insetPadding ?? EdgeInsets.symmetric(horizontal: 45),
              backgroundColor: ColorConstants.transparentColor,
              elevation: 0,
              child: child,
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
    Color? bgColor,
    Color? barrierColor,
  }) {
    return showDialog(
        context: context,
        barrierColor: barrierColor ??ColorConstants.blackColor.withOpacity(0.2),
        //barrierColor: ColorConstants.blackColor.withOpacity(0.2),
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius ?? RadiusConstant.alertdialogRadius), color: bgColor ?? ColorConstants.scaffoldColor),
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
                              buttonColor: ColorConstants.primaryColor,
                              titleColor: ColorConstants.buttonTextColor,
                            ),
                          ),
                          16.0.spaceX,
                          Expanded(
                              child: PrimaryButton(
                            title: acceptButtonTitle,
                            onPressed: onAcceptTap,
                            buttonColor: ColorConstants.whiteColor,
                            titleColor: ColorConstants.primaryColor,
                          )),
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
