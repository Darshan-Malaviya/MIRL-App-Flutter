// ignore_for_file: use_build_context_synchronously
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boilerplate_may_2023/generated/locale_keys.g.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
import 'package:permission_handler/permission_handler.dart';

 mixin class PermissionHandler {
  Future<PermissionStatus> permissionRequest(
      {required BuildContext context, required Permission permission, required String alertMessage}) async {

    PermissionStatus status = await permission.status;
    if (Platform.isAndroid) {
      if (status.isGranted) {
        print('User granted this permission before');
      } else {
        final before = await permission.shouldShowRequestRationale;
        final rs = await permission.request();
        final after = await permission.shouldShowRequestRationale;

        if (rs.isGranted) {
          ///User granted this permission
        } else if (!before && after) {
          ///Show permission request pop-up and user denied first time
          print("First");
        } else if (before && !after) {
          ///Show permission request pop-up and user denied a second time
          print("second");
        } else if (!before && !after) {
          ///No more permission pop-ups displayed
          await openSettingDialog(context: context, message: alertMessage);
        }
      }
    } else if (Platform.isIOS) {
      if (status.isDenied) {
        status = await permission.request();
      } else if (status.isPermanentlyDenied) {
        await openSettingDialog(context: context, message: alertMessage);
      }
    }
    status = await permission.status;
    return status;
  }

  Future<void> openSettingDialog({required BuildContext context, required String message}) async {
    await CommonAlertDialog.permissionAlert(
      context: context,
      child: TitleLargeText(
        title: message,
        maxLine: 4,
        titleTextAlign: TextAlign.center,
        fontWeight: FontWeight.w600,
      ),
      acceptButtonTitle: LocaleKeys.settings.tr(),
      discardButtonTitle: LocaleKeys.notNow.tr(),
      onAcceptTap: () async {
        await openAppSettings();
        context.toPop();
      },
    );
  }
}
