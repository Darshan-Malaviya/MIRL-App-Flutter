

import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response.dart';

mixin class ApiResponseHandler {
  Future<ApiHttpResult> responseHandler({required APIResponse result, required ComputeCallback<Map<String, dynamic>?, dynamic> json}) {
    successResponse(APIResponse result) async {
      var apiResponse = await compute(json, result.response);

      return ApiHttpResult.success(apiResponse);
    }

    failureResponse() async {
      return ApiHttpResult.failure(result.failure);
    }

    return switch (result.status) { APIStatus.success => successResponse(result), APIStatus.failure => failureResponse() };
  }
}
