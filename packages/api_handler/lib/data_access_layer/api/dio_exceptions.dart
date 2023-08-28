import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    message = switch (dioError.type) {
      DioExceptionType.cancel => "Request to API server was cancelled",
      DioExceptionType.connectionTimeout => "Connection timeout with API server",
      DioExceptionType.receiveTimeout => "Receive timeout in connection with API server",
      DioExceptionType.badResponse => _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        ),
      DioExceptionType.sendTimeout => "Send timeout in connection with API server",
      DioExceptionType.connectionError => _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        ),
      _ => "Something went wrong"
    };
  }

  String _handleError(int? statusCode, dynamic error) {
    return switch (statusCode) {
      400 => 'Bad request',
      401 => 'Unauthorized',
      403 => 'Forbidden',
      404 => error['message'],
      500 => 'Internal server error',
      502 => 'Bad gateway',
      _ => 'Oops something went wrong',
    };
  }

  @override
  String toString() => message;
}
