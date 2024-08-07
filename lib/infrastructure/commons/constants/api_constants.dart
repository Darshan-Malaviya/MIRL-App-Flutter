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

  static const String mirlBasePath ='https://mirl.com';
  static const String termsConditions = '$mirlBasePath/terms';
  static const String privacyPolicy = '$mirlBasePath/privacy';
  static const String connect = '$mirlBasePath/mirl-connect';
  static const String scheme = 'https';
  static const String devHost = 'dev-api.mirl.com';
  static const String prodHost = 'api.mirl.com';

  static const String endUserEula = '$mirlBasePath/eula';
  static const String cookiePolicy = '$mirlBasePath/cookie';
  static const String disclaimer = '$mirlBasePath/disclaimer';
  static const String acceptableUsePolicy = '$mirlBasePath/acceptable-use';
  static const String userGeneratedContent = '$mirlBasePath/user-generated-content';
  static const String refundPolicy = '$mirlBasePath/refund';
  static const String helpAndSupport = '$mirlBasePath/support';





  ///development url

  static Uri endpointUri({String? path, Map<String, dynamic>? queryParameters}) => Uri(
        scheme: scheme,
        host: host,
        path: path,
        queryParameters: queryParameters,
      );

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

  static const String login = '/user/login';
  static const String logout = '/user/logout';
  static const String otpVerify = '/user/verify-otp';
  static String updateUser = '/user/${SharedPrefHelper.getUserId}';
  static String getUserDetail = '/user/';
  static const String getSingleCategory = '/category/app';
  static const String category = '/category';
  static const String country = '/country';
  static const String city = '/city';
  static const String expertAvailability = '/expertAvailability';
  static const String certification = '/certification';
  static const String user = '/user';
  static const String expertCategory = '/expertCategory/parent/child-category';
  static const String expertCategorySelection = '/expertCategory/category/selection';
  static const String userFavorite = '/userFavorite';
  static const String homepage = '/homePage/';
  static const String homepageSearch = '/homePage/search/';
  static const String allCategoryList = '/category/list/all';
  static const String topicByCategory = '/topic/list/all';
  static const String timeSlots = '/appointment/timeSlots';
  static const String appointment = '/appointment';
  static String userBlockList = '/userBlock';
  static const String userBlock = '/userBlock';
  static const String unBlockUser = '/userBlock';
  static const String cms = '/cms';
  static const String reportList = '/reportList';
  static const String userReport = '/userReport';
  static const String rateExpert = '/rateExpert';
  static const String suggestedCategory = '/SuggestedCategory';
  static const String notificationMessage = '/notificationMessage';
  static const String callHistory = '/history';
  static const String reportCallTitles = '/reportCallTitles';
  static const String reportCall = '/reportCall';
  static const String appStartUp = '/appStartUp';
  static const String favorite = '/homePage/favorite/';
  static const String lastConversation = '/homePage/lastConversation/';
  static const String getOwnReferralCode = '/user-referral/referral-link';
  static const String getReferralList = '/user-referral/referral-user';
  static const String submitReferralCode = '/user-referral/verify';
}
