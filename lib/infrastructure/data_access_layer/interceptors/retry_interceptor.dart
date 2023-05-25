import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/data_access_layer/interceptors/dio_connectivity_request_retrier.dart';
import 'package:logger/logger.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {

  RetryOnConnectionChangeInterceptor({
    required this.requestRetriever,
  });
  final DioConnectivityRequestRetriever requestRetriever;

  @override
  Future<void> onError(
    DioError err,
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

  bool _shouldRetry(DioError err) {
    return (err.type == DioErrorType.unknown) && err.error != null && err.error is SocketException;
  }
}
