import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterToast {
  FToast fToast = FToast();

  Future showToast({
    required dynamic msg,
    ToastGravity? gravity,
  }) async {
    if (msg?.isEmpty ?? false) return;
    fToast.init(NavigationService.context);
    List<String> messageList = [];
    if (msg is List) {
      messageList.addAll(msg.cast<String>());
    } else {
      messageList.add(msg);
    }
    String bulletPoint = messageList.length > 1 ? '●' : '';
    Widget toast = Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: List.generate(
            messageList.length,
            (index) => Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///you can add you app icon here
                    //  const Icon(Icons.logo_dev_rounded),
                    if (bulletPoint.isNotEmpty)
                      BodySmallText(
                        title: bulletPoint,
                        maxLine: 10,
                        titleColor: ColorConstants.whiteColor,
                      ),
                    if (bulletPoint.isNotEmpty) 4.0.spaceX,
                    Expanded(
                      child: BodySmallText(
                        titleColor: ColorConstants.whiteColor,
                        titleTextAlign: TextAlign.center,
                        title: messageList[index],
                        maxLine: 10,
                      ),
                    ),
                    10.0.spaceX,
                  ],
                )),
      ),
    );
    cancelToast();
    fToast.showToast(child: toast, toastDuration: const Duration(seconds: 2), gravity: gravity ?? ToastGravity.BOTTOM);
  }

  cancelToast() {
    fToast.removeCustomToast();
  }
}
