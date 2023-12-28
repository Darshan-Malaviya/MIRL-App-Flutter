



import 'package:mirl/infrastructure/models/response/error_model.dart';

enum APIStatus { success, failure }

class APIResponse {
  Map<String, dynamic>? response;
  ErrorModel? failure;
  APIStatus status;

  APIResponse.success(this.response) : status = APIStatus.success;


  APIResponse.failure(this.failure) : status = APIStatus.failure;
}

class ApiHttpResult<T> {
  T? data;
  ErrorModel? failure;
  APIStatus status;

  ApiHttpResult.success(this.data) : status = APIStatus.success;


  ApiHttpResult.failure(this.failure) : status = APIStatus.failure;
}
