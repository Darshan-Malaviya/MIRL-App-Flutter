import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/commons/constants/api_constants.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/commons/enums/error_type_enum.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/data_access_layer/api/api_response.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/data_access_layer/api/application_error.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/data_access_layer/api/dio_exceptions.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/data_access_layer/api/dio_intersepter.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/data_access_layer/interceptors/dio_connectivity_request_retrier.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/data_access_layer/interceptors/retry_interceptor.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/models/common/api_error.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/services/app_path_provider.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/commons/extensions/error_type_extension.dart';

class ApiResponseProvider {
  late Dio _dio;

  ApiResponseProvider({Map<String, dynamic>? header}) {
    Map<String, dynamic> authHeader = ApiConstants.headerWithoutAccessToken();

    _dio = Dio(
      // BaseOptions(baseUrl: flavorConfig.baseUrl ?? 'https://dev-api.trymindscape.com/', headers: header ?? authHeader),
      BaseOptions(baseUrl: 'https://dev-api.trymindscape.com/', headers: header ?? authHeader),
    );

    _dio.interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: HiveCacheStore(AppPathProvider.path),
          policy: CachePolicy.refreshForceCache,
          hitCacheOnErrorExcept: [],
          maxStale: const Duration(
            days: ApiConstants.cachedDays,
          ),
          //increase number of days for longer cache
          priority: CachePriority.high,
        ),
      ),
    );

    _dio.interceptors.add(dioLoggerInterceptor);

    //this is for avoiding certificates error cause by dio
    //https://issueexplorer.com/issue/flutterchina/dio/1285

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  /// This can also send get requests, or use captcha. Background requests
  /// should not use captcha, and requests for data should use GET.
  Future<APIResponse> post(
    Uri url, {
    Map<String, String?>? headers = const {},
    body,
    int timeout = ApiConstants.defaultTimeout,
    bool get = false,
    bool put = false,
    bool delete = false,
  }) async {
    APIResponse responseJson;

    try {
      final Response response;

      String newURL = url.path;

      if (get) {
        _dio.interceptors.add(
          RetryOnConnectionChangeInterceptor(
            requestRetriever: DioConnectivityRequestRetriever(
              dio: Dio(
                BaseOptions(baseUrl: _dio.options.baseUrl, headers: _dio.options.headers),
              ),
              connectivity: Connectivity(),
            ),
          ),
        );

        response = await _dio.get(newURL, queryParameters: url.queryParameters);
      } else if (put) {
        response = await _dio.put(newURL,
            data: body, queryParameters: url.queryParameters, options: Options(headers: headers ?? _dio.options.headers));
      } else if (delete) {
        response = await _dio.delete(newURL,
            data: body, queryParameters: url.queryParameters, options: Options(headers: headers ?? _dio.options.headers));
      } else if (delete) {
        response =
            await _dio.delete(newURL, queryParameters: url.queryParameters, options: Options(headers: headers ?? _dio.options.headers));
      } else {
        response = await _dio.post(newURL,
            data: body, queryParameters: url.queryParameters, options: Options(headers: headers ?? _dio.options.headers));
      }
      responseJson = await _processResponse(response);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      // Error tracking

      ApplicationError applicationError;

      if (e.error is SocketException) {
        applicationError = NetworkError.getAppError(NetworkErrorType.netUnreachable);
      } else {
        Response? data = e.response;

        if (data != null) {
          responseJson = await _processResponse(data);

          return responseJson;
        }

        applicationError = ApplicationError(
          errorType: ErrorType.genericError.messageString,
          errors: [
            ApiError(code: e.response?.statusCode, message: errorMessage),
          ],
        );
      }
      return APIResponse.error(applicationError);
    } catch (e) {
      // Error tracking
      ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
      return APIResponse.error(applicationError);
    }
    return responseJson;
  }

  Future<APIResponse> _processResponse(Response response) async {
    if (((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) <= 299) || (response.statusCode ?? 0) == 304) {
      //TODO: for future optimization move decoding to a separate isolate.

      return APIResponse.success(response.data);
    } else if (response.statusCode == 401) {
      // CommonAlertDialog.dialog(context: NavigationService.context, child: const AutoLogoutDialog(), barrierDismissible: false);

      ApplicationError? applicationError = ErrorResponse.getAppError(response.statusCode ?? 0);
      // CommonMethods.autoLogout();
      return APIResponse.error(applicationError);
    } else {
      ApplicationError? applicationError;
      try {
        // final errorResponse = await compute(ErrorModel.parseInfo, responseJson as Map<String, dynamic>);
        applicationError = ErrorResponse.getAppError(response.statusCode ?? 0);
      } catch (e) {
        if (kDebugMode) {
          print('ErrorResponse.getAppError');
        }
      }
      // Error tracking
      return APIResponse.error(applicationError);
    }
  }
}
