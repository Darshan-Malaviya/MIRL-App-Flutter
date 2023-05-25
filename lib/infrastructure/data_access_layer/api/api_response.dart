

import 'package:flutter_boilerplate_may_2023/infrastructure/data_access_layer/api/application_error.dart';

enum APIStatus { SUCCESS, ERROR }

class APIResponse {
  Map<String, dynamic>? response;
  ApplicationError? error;
  APIStatus status;

  APIResponse.success(this.response) : status = APIStatus.SUCCESS;

  APIResponse.error(this.error) : status = APIStatus.ERROR;
}

class ApiHttpResult<T> {
  T? data;
  ApplicationError? error;
  APIStatus status;

  ApiHttpResult.success(this.data) : status = APIStatus.SUCCESS;

  ApiHttpResult.error(this.error) : status = APIStatus.ERROR;
}
