
import 'package:api_handler/common/exports.dart';

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
