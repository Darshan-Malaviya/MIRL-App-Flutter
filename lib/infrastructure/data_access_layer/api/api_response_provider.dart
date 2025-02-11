import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/mirl_app.dart';

class ApiResponseProvider {
  late Dio _dio;

  ApiResponseProvider({Map<String, dynamic>? header}) {
    Map<String, dynamic> authHeader = ApiConstants.headerWithOutToken();

    _dio = Dio(BaseOptions(
        baseUrl: flavorConfig?.appTitle == AppConstants.localFlavorName
            ? 'http://192.168.1.107:3000'
            : '${ApiConstants.scheme}://${ApiConstants.host}',
        headers: header ?? authHeader));

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
        response = await _dio.get(newURL, queryParameters: url.queryParameters,options: Options(headers:headers));
        //response = await _dio.get(newURL, queryParameters: url.queryParameters);
        responseJson = await _processResponse(response);
        return responseJson;
      } on DioException catch (e) {
        return await onDioExceptionHandler(e);
      }
    }

    postRequest() async {
      try {
        response = await _dio.post(newURL, data: body, queryParameters: url.queryParameters, options: Options(headers: headers ?? _dio.options.headers));
        responseJson = await _processResponse(response);
        return responseJson;
      } on DioException catch (e) {
        return await onDioExceptionHandler(e);
      }
    }

    deleteRequest() async {
      try {
        response = await _dio.delete(newURL, data: body, queryParameters: url.queryParameters, options: Options(headers: headers ?? _dio.options.headers));
        responseJson = await _processResponse(response);
        return responseJson;
      } on DioException catch (e) {
        return await onDioExceptionHandler(e);
      }
    }

    putRequest() async {
      try {
        response = await _dio.put(newURL, data: body, queryParameters: url.queryParameters, options: Options(headers: headers ?? _dio.options.headers));
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
      CommonModel? errorResponse;
      try {
        errorResponse = await compute(CommonModel.parseInfo, response.data as Map<String, dynamic>);
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
      CommonModel? errorResponse = await compute(CommonModel.parseInfo, e.response?.data as Map<String, dynamic>);
      return APIResponse.failure(errorResponse);
    } else if ((e.response?.statusCode ?? 400) >= 400 || (e.response?.statusCode ?? 400) <= 499) {
      // ErrorModel? errorResponse = await compute(ErrorModel.parseInfo, e.response?.data as Map<String, dynamic>);
      return APIResponse.failure(CommonModel(message: ['Service temporarily unavailable. Please check back soon.']));
    }
    if (e.error is SocketException) {
      applicationError = NetworkError.getAppError(NetworkErrorType.netUnreachable);
    } else {
      applicationError = ErrorResponse.getAppError(e.response?.statusCode ?? 0);
    }

    return APIResponse.failure(CommonModel(message: [applicationError.errors.first.message ?? '']));
  }
}
