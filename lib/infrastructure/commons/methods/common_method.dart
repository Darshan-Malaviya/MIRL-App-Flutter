import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/providers/auth_provider.dart';

class CommonMethods {
  /// get current time zone
  static Future<String> getCurrentTimeZone() async {
    return await FlutterTimezone.getLocalTimezone();
  }

  /// autoLogout
  static void autoLogout() {
    UserData? data;
    if (SharedPrefHelper.getUserData.isNotEmpty) {
      data = UserData.fromJson(jsonDecode(SharedPrefHelper.getUserData));
    }
    if (data?.loginType == 1) {
      googleSignIn?.signOut();
    }
    SharedPrefHelper.clearPrefs();
    NavigationService.context.toPushNamedAndRemoveUntil(RoutesConstants.loginScreen);
  }
}
