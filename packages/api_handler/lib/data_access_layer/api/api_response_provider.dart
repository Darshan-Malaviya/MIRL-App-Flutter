import 'dart:async';
import 'dart:io';
import 'package:api_handler/common/exports.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';


class ApiResponseProvider {
  late Dio _dio;

  ApiResponseProvider({Map<String, dynamic>? header}) {
    Map<String, dynamic> authHeader = ApiConstants.headerWithoutAccessToken();

    _dio = Dio(BaseOptions(baseUrl: 'https://dev-api.trymindscape.com/', headers: header ?? authHeader));

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
    try {
      Response response;
      String newURL = url.path;

      getRequest() async {
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
      }

      postRequest() async {
        response = await _dio.post(newURL,
            data: body, queryParameters: url.queryParameters, options: Options(headers: headers ?? _dio.options.headers));
        responseJson = await _processResponse(response);
        return responseJson;
      }

      deleteRequest() async {
        response = await _dio.delete(newURL,
            data: body, queryParameters: url.queryParameters, options: Options(headers: headers ?? _dio.options.headers));
        responseJson = await _processResponse(response);
        return responseJson;
      }

      putRequest() async {
        response = await _dio.put(newURL,
            data: body, queryParameters: url.queryParameters, options: Options(headers: headers ?? _dio.options.headers));
        responseJson = await _processResponse(response);
        return responseJson;
      }

      return switch (apiType) {
        APIType.get => getRequest(),
        APIType.post => postRequest(),
        APIType.put => putRequest(),
        APIType.delete => deleteRequest(),
      };
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
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
      ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
      return APIResponse.error(applicationError);
    }
  }

  Future<APIResponse> _processResponse(Response response) async {
    if (((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) <= 299) || (response.statusCode ?? 0) == 304) {
      //TODO: for future optimization move decoding to a separate isolate.
      return APIResponse.success(response.data);
    } else if (response.statusCode == 401) {
      ApplicationError? applicationError = ErrorResponse.getAppError(response.statusCode ?? 0);
      return APIResponse.error(applicationError);
    } else {
      ApplicationError? applicationError;
      try {
        applicationError = ErrorResponse.getAppError(response.statusCode ?? 0);
        return APIResponse.failure(applicationError);
      } catch (e) {
        if (kDebugMode) {
          print('ErrorResponse.getAppError');
        }
      }
      return APIResponse.failure(applicationError);
    }
  }
}
