

import 'package:api_handler/common/exports.dart';

class SharedPrefHelper {
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  static Future<bool> saveAuthToken(String? authToken) async {
    return await _prefsInstance?.setString(StorageConstants.authToken, authToken ?? '') ?? false;
  }

  static String get getAuthToken {
    return _prefsInstance?.getString(StorageConstants.authToken) ?? '';
  }

  static Future<bool> saveSearchHistory(List<String>? searchHistory) async {
    return await _prefsInstance?.setStringList(StorageConstants.searchHistory, searchHistory ?? []) ?? false;
  }

  static List<String> get getSearchHistory {
    return _prefsInstance?.getStringList(StorageConstants.searchHistory) ?? [];
  }

  static clearPrefs() async {
    await _prefsInstance?.remove(StorageConstants.authToken);
    await _prefsInstance?.remove(StorageConstants.authToken);
  }
}
