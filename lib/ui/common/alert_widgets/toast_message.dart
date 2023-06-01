import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterToast {
  FToast fToast = FToast();

  Future showToast({required BuildContext context, required String msg}) async {
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(100.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///you can add you app icon here
         const Icon(Icons.logo_dev_rounded),
          6.0.spaceX,
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
            child: BodySmallText(
              titleColor: ColorConstants.whiteColor,
              titleTextAlign: TextAlign.left,
              title: msg ?? "",
              maxLine: 10,
            ),
          ),
          10.0.spaceX,
        ],
      ),
    );

    // fToast.showToast(child: toast, toastDuration: const Duration(seconds: 2), gravity: ToastGravity.BOTTOM);
  }

  cancelToast() {
    fToast.removeCustomToast();
  }
}
