import 'dart:io';
import 'package:api_handler/data_access_layer/interceptors/dio_connectivity_request_retrier.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  RetryOnConnectionChangeInterceptor({
    required this.requestRetriever,
  });

  final DioConnectivityRequestRetriever requestRetriever;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_shouldRetry(err)) {
      try {
        return handler.resolve(await requestRetriever.scheduleRequestRetry(err.requestOptions));
      } catch (e) {
        Logger().d(e);
      }
    }
    return handler.reject(err);
  }

  bool _shouldRetry(DioException err) {
    return (err.type == DioExceptionType.unknown) && err.error != null && err.error is SocketException;
  }
}
