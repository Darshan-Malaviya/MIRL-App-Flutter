// ValueNotifier<bool> isUnAuthorized = ValueNotifier<bool>(false);

class ApiConstants {
  static const String sampleExample = '';

  static const int defaultTimeout = 20;

  static const int cachedDays = 7;

  static String get host {
    // if (flavorConfig.appTitle == AppConstants.prodFlavorName) {
    //   return prodHost;
    // } else {
    //   return devHost;
    // }
    return host;
  }

  static const String scheme = 'https';
  static const String devHost = 'dev-api.mobile-eeaustralia.com';
  static const String prodHost = 'prod-api.mobile-eeaustralia.com';

  ///development url

  static Uri endpointUri({String? path, Map<String, dynamic>? queryParameters}) => Uri(
        scheme: scheme,
        host: host,
        path: path,
        queryParameters: queryParameters,
      );

  static Map<String, String> headerWithoutAccessToken() {
    Map<String, String> headerData = {
      'Content-Type': 'application/json',
      'eeauToke':
          'Bearer lC3polLeaSwXJIaJUUxBXbuseHXDjKuCmep8lCeEYS2KJzCBVum5vNV34LVP03vtoRi25rFiSVthDbbXPR5XdAFEJwcpPQVNBqkeetwJ2E3ZB8d2R2aBtphZag1J0sWhO9cP18Ku6UM9'
    };
    return headerData;
  }

  static Map<String, String> headerWithAuthToken(String authToken) {
    Map<String, String> headerData = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
      'eeauToke':
          'Bearer lC3polLeaSwXJIaJUUxBXbuseHXDjKuCmep8lCeEYS2KJzCBVum5vNV34LVP03vtoRi25rFiSVthDbbXPR5XdAFEJwcpPQVNBqkeetwJ2E3ZB8d2R2aBtphZag1J0sWhO9cP18Ku6UM9'
    };
    return headerData;
  }

  static const String commonPath = '/api/v1';

  static const String login = '$commonPath/brands';
}
