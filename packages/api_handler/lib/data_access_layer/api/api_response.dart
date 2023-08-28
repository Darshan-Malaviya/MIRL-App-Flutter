


import 'package:api_handler/common/exports.dart';

enum APIStatus { success, error, failure }

class APIResponse {
  Map<String, dynamic>? response;
  ApplicationError? error;
  ApplicationError? failure;
  APIStatus status;

  APIResponse.success(this.response) : status = APIStatus.success;

  APIResponse.error(this.error) : status = APIStatus.error;

  APIResponse.failure(this.failure) : status = APIStatus.failure;
}

class ApiHttpResult<T> {
  T? data;
  ApplicationError? error;
  ApplicationError? failure;
  APIStatus status;

  ApiHttpResult.success(this.data) : status = APIStatus.success;

  ApiHttpResult.error(this.error) : status = APIStatus.error;

  ApiHttpResult.failure(this.failure) : status = APIStatus.failure;
}
