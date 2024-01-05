import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:mirl/infrastructure/commons/enums/enum.dart';
import 'package:mirl/infrastructure/commons/enums/error_type_enum.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response.dart';
import 'package:mirl/infrastructure/data_access_layer/api/application_error.dart';
import 'package:mirl/infrastructure/data_access_layer/api/dio_intersepter.dart';
import 'package:mirl/infrastructure/data_access_layer/interceptors/dio_connectivity_request_retrier.dart';
import 'package:mirl/infrastructure/data_access_layer/interceptors/retry_interceptor.dart';
import 'package:mirl/infrastructure/models/response/error_model.dart';
import 'package:mirl/infrastructure/services/app_path_provider.dart';

import '../../commons/exports/common_exports.dart';

class ApiResponseProvider {
  late Dio _dio;

  ApiResponseProvider({Map<String, dynamic>? header}) {
    Map<String, dynamic> authHeader = ApiConstants.headerWithOutToken();

    _dio = Dio(BaseOptions(baseUrl: '${ApiConstants.scheme}://${ApiConstants.host}', headers: header ?? authHeader));

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
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
  }

  /// This can also send get requests, or use captcha. Background requests
  /// should not use captcha, and requests for data should use GET.
  /// default apiType is POST
  Future<APIResponse> requestAPI(
    Uri url, {
    Map<String, String?>? headers = const {},
    body,
    int timeout = ApiConstants.defaultTimeout,
    APIType apiType = APIType.post,
  }) async {
    APIResponse responseJson;

    Response response;
    String newURL = url.path;

    getRequest() async {
      try {
        _dio.interceptors.add(
          RetryOnConnectionChangeInterceptor(
            requestRetriever: DioConnectivityRequestRetriever(
              dio: Dio(BaseOptions(baseUrl: _dio.options.baseUrl, headers: _dio.options.headers)),
              connectivity: Connectivity(),
            ),
          ),
        );
        response = await _dio.get(newURL, queryParameters: url.queryParameters);
        responseJson = await _processResponse(response);
        return responseJson;
      } on DioException catch (e) {
        return await onDioExceptionHandler(e);
      }
    }

    postRequest() async {
      try {
        response = await _dio.post(newURL,
            data: json.encode(body),
            queryParameters: url.queryParameters,
            options: Options(headers: headers ?? _dio.options.headers));
        responseJson = await _processResponse(response);
        return responseJson;
      } on DioException catch (e) {
        return await onDioExceptionHandler(e);
      }
    }

    deleteRequest() async {
      try {
        response = await _dio.delete(newURL,
            data: json.encode(body),
            queryParameters: url.queryParameters,
            options: Options(headers: headers ?? _dio.options.headers));
        responseJson = await _processResponse(response);
        return responseJson;
      } on DioException catch (e) {
        return await onDioExceptionHandler(e);
      }
    }

    putRequest() async {
      try {
        response = await _dio.put(newURL,
            data: json.encode(body),
            queryParameters: url.queryParameters,
            options: Options(headers: headers ?? _dio.options.headers));
        responseJson = await _processResponse(response);
        return responseJson;
      } on DioException catch (e) {
        return await onDioExceptionHandler(e);
      }
    }

    return switch (apiType) {
      APIType.get => getRequest(),
      APIType.post => postRequest(),
      APIType.put => putRequest(),
      APIType.delete => deleteRequest(),
    };
  }

  Future<APIResponse> _processResponse(Response response) async {
    if (((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) <= 299)) {
      //TODO: for future optimization move decoding to a separate isolate.
      return APIResponse.success(response.data);
    } else {
      ErrorModel? errorResponse;
      try {
        errorResponse = await compute(ErrorModel.parseInfo, response.data as Map<String, dynamic>);
      } catch (e) {
        print(e);
      }
      return APIResponse.failure(errorResponse);
    }
  }

  ///API exception handling
  Future<APIResponse> onDioExceptionHandler(DioException e) async {
    // APIResponse responseJson;
    // final errorMessage = DioExceptions.fromDioError(e).toString();
    ApplicationError applicationError;
    if ((e.response?.statusCode ?? 400) >= 400 || (e.response?.statusCode ?? 400) <= 499) {
      ErrorModel? errorResponse = await compute(ErrorModel.parseInfo, e.response?.data as Map<String, dynamic>);
      return APIResponse.failure(errorResponse);
    } else if ((e.response?.statusCode ?? 400) >= 400 || (e.response?.statusCode ?? 400) <= 499) {
      // ErrorModel? errorResponse = await compute(ErrorModel.parseInfo, e.response?.data as Map<String, dynamic>);
      return APIResponse.failure(ErrorModel(message: ['Service temporarily unavailable. Please check back soon.']));
    }
    if (e.error is SocketException) {
      applicationError = NetworkError.getAppError(NetworkErrorType.netUnreachable);
    } else {
      applicationError = ErrorResponse.getAppError(e.response?.statusCode ?? 0);
    }

    return APIResponse.failure(ErrorModel(message: [applicationError.errors.first.message ?? '']));
  }
}
