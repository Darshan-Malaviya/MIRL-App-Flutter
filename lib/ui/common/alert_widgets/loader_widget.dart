import 'dart:ui';

import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
import 'package:flutter/cupertino.dart';

class CustomLoading {
  static progressDialog({required bool isLoading, required BuildContext context}) {
    if (!isLoading) {
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      showDialog(
        barrierDismissible: true,
        barrierColor: ColorConstants.blackColor.withOpacity(0.2),
        context: context,
        useSafeArea: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: Center(
                child: CupertinoActivityIndicator(animating: true,color: ColorConstants.secondaryColor,radius: 16,)
              ),
            ),
          );
        },
        useRootNavigator: true,
      );
    }
  }
}
