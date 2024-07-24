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

  static Future<bool> saveCallRequestId(String? userData) async {
    return await _prefsInstance?.setString(StorageConstants.instanceCallRequestId, userData ?? '') ?? false;
  }

  static String get getCallRequestId {
    return _prefsInstance?.getString(StorageConstants.instanceCallRequestId) ?? '';
  }


  static Future<bool> saveAreaOfExpertise(bool isUserData) async {
    return await _prefsInstance?.setBool(StorageConstants.areaOfExpertise, isUserData) ?? false;
  }

  static bool get getAreaOfExpertise {
    return _prefsInstance?.getBool(StorageConstants.areaOfExpertise) ?? false;
  }

  static clearPrefs() async {
    await _prefsInstance?.clear();
  }

  static Future<bool> saveUserId(String? id) async {
    return await _prefsInstance?.setString(StorageConstants.userId, id ?? '') ?? false;
  }

  static String get getUserId {
    return _prefsInstance?.getString(StorageConstants.userId) ?? '';
  }

  static  Future<void> saveString(String key, String value) async {
    await _prefsInstance?.setString(key, value);
  }

  static String getString(String key) {
    return _prefsInstance?.getString(key) ?? "";
  }
}
