// ValueNotifier<bool> isUnAuthorized = ValueNotifier<bool>(false);

import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/mirl_app.dart';

class ApiConstants {
  static const String sampleExample = '';

  static const int defaultTimeout = 20;

  static const int cachedDays = 7;

  static String get host {
    if (flavorConfig?.appTitle == AppConstants.prodFlavorName) {
      return prodHost;
    } else {
      return devHost;
    }
  }

  static const String scheme = 'https';
  static const String devHost = 'dev-api.mirl.com';
  static const String prodHost = 'api.mirl.com';

  ///development url

  static Uri endpointUri({String? path, Map<String, dynamic>? queryParameters}) => Uri(
        scheme: scheme,
        host: host,
        path: path,
        queryParameters: queryParameters,
      );

  // static Map<String, String> headerWithoutAccessToken() {
  //   Map<String, String> headerData = {
  //     'Content-Type': 'application/json',
  //     'eeauToke':
  //         'Bearer lC3polLeaSwXJIaJUUxBXbuseHXDjKuCmep8lCeEYS2KJzCBVum5vNV34LVP03vtoRi25rFiSVthDbbXPR5XdAFEJwcpPQVNBqkeetwJ2E3ZB8d2R2aBtphZag1J0sWhO9cP18Ku6UM9'
  //   };
  //   return headerData;
  // }
  //
  // static Map<String, String> headerWithAuthToken(String authToken) {
  //   Map<String, String> headerData = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $authToken',
  //     'eeauToke':
  //         'Bearer lC3polLeaSwXJIaJUUxBXbuseHXDjKuCmep8lCeEYS2KJzCBVum5vNV34LVP03vtoRi25rFiSVthDbbXPR5XdAFEJwcpPQVNBqkeetwJ2E3ZB8d2R2aBtphZag1J0sWhO9cP18Ku6UM9'
  //   };
  //   return headerData;
  // }

  static Map<String, String> headerWithToken() {
    Map<String, String> headerData = {
      'Authorization': SharedPrefHelper.getAuthToken,
      'Content-Type': 'application/json',
      'mirlAppToken':
          'Bearer 9e03fddc477f8dddf89ca6b608d1c6cccdc882ccd104dbafcdb02ff8edd419296937b1b6562db403c0be150a0a432f70c5e13csdsj232sdbb3438cbdf'
    };
    return headerData;
  }

  static Map<String, String> headerWithOutToken() {
    Map<String, String> headerData = {
      'Content-Type': 'application/json',
      'mirlAppToken':
          'Bearer 9e03fddc477f8dddf89ca6b608d1c6cccdc882ccd104dbafcdb02ff8edd419296937b1b6562db403c0be150a0a432f70c5e13csdsj232sdbb3438cbdf'
    };
    return headerData;
  }

  // static const String commonPath = '/api/v1';

  static const String login = '/user/login';
  static const String otpVerify = '/user/verify-otp';
  static String updateUser = '/user/${SharedPrefHelper.getUserId}';
  static const String category = '/category';
  static const String country = '/country';
  static const String city = '/city';
  static const String expertAvailability = '/expertAvailability';
  static  String getExpertAvailability = '/expertAvailability/${SharedPrefHelper.getUserId}';
  static const String certification = '/certification';
  static const String deleteCertification = '/certification';
  static const String expertCategory = '/expertCategory/parent/child-category';
  static const String expertCategorySelection = '/expertCategory/category/selection';
  static const String homepage = '/homePage/';
}
