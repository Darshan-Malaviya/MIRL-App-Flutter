

import 'package:flutter_boilerplate_may_2023/infrastructure/commons/enums/error_type_enum.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/commons/extensions/error_type_extension.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/data_access_layer/api/api_response.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/data_access_layer/api/application_error.dart';

mixin class ApiResponseHandler {
  Future<ApiHttpResult> responseHandler({required APIResponse result, required ComputeCallback<Map<String, dynamic>?, dynamic> json}) {
    successResponse(APIResponse result) async {
      var apiResponse = await compute(json, result.response);
      return ApiHttpResult.success(apiResponse);
    }

    errorResponse(APIResponse result) async {
      return ApiHttpResult.error(result.error);
    }

    failureResponse() async {
      ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
      return ApiHttpResult.error(applicationError);
    }

    return switch (result.status) {
      APIStatus.success => successResponse(result),
      APIStatus.error => errorResponse(result),
      APIStatus.failure => failureResponse()
    };
  }
}
