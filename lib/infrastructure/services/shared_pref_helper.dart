



import 'package:mirl/infrastructure/commons/constants/storage_constants.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class SharedPrefHelper {
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  static Future<bool> saveFirebaseToken(String? authToken) async {
    return await _prefsInstance?.setString(StorageConstants.firebaseToken, authToken ?? '') ?? false;
  }

  static String get getFirebaseToken {
    return _prefsInstance?.getString(StorageConstants.firebaseToken) ?? '';
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


  static Future<bool> saveUserData(String? userData) async {
    return await _prefsInstance?.setString(StorageConstants.userData, userData ?? '') ?? false;
  }

  static String get getUserData {
    return _prefsInstance?.getString(StorageConstants.userData) ?? '';
  }

  static clearPrefs() async {
    await _prefsInstance?.remove(StorageConstants.userData);
  }
}
