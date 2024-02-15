



import 'package:mirl/infrastructure/models/common/common_model.dart';

enum APIStatus { success, failure }

class APIResponse {
  Map<String, dynamic>? response;
  CommonModel? failure;
  APIStatus status;

  APIResponse.success(this.response) : status = APIStatus.success;


  APIResponse.failure(this.failure) : status = APIStatus.failure;
}

class ApiHttpResult<T> {
  T? data;
  CommonModel? failure;
  APIStatus status;

  ApiHttpResult.success(this.data) : status = APIStatus.success;


  ApiHttpResult.failure(this.failure) : status = APIStatus.failure;
}
