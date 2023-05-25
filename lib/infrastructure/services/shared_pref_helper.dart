import 'package:flutter_boilerplate_may_2023/infrastructure/commons/constants/storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  static Future<bool> saveAuthToken(String? authToken) async {
    return await _prefsInstance?.setString(StorageConstants.authToken, authToken ?? '') ?? false;
  }

  static clearPrefs() async {
    await _prefsInstance?.remove(StorageConstants.authToken);
  }
}
