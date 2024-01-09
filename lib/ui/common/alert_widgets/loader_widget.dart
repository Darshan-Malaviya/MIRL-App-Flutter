import 'dart:ui';

import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:flutter/cupertino.dart';

class CustomLoading {
  static progressDialog({required bool isLoading}) {
    if (!isLoading) {
      Navigator.of(NavigationService.context, rootNavigator: true).pop();
    } else {
      showDialog(
        barrierDismissible: true,
        barrierColor: ColorConstants.blackColor.withOpacity(0.2),
        context: NavigationService.context,
        useSafeArea: true,
        builder: (BuildContext context) {
          return PopScope(
            canPop:  false,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: Center(
                  child: CupertinoActivityIndicator(
                animating: true,
                color: ColorConstants.primaryColor,
                radius: 16,
              )),
            ),
          );
        },
        useRootNavigator: true,
      );
    }
  }
}
