import 'dart:async';
import 'package:mirl/infrastructure/commons/constants/api_constants.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/models/response/user_block_response_model.dart';

class AuthRepository extends ApiResponseHandler {

  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  /// login
  Future<ApiHttpResult> loginCallApi({required Object requestModel}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.login);

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithOutToken(), body: requestModel);

    return responseHandler(result: result, json: LoginResponseModel.parseInfo);
  }

  /// otp verify

  Future<ApiHttpResult> otpVerifyCallApi({required Object requestModel}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.otpVerify);

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithOutToken(), body: requestModel);

    return responseHandler(result: result, json: LoginResponseModel.parseInfo);
  }

  /// user block

  Future<ApiHttpResult> userBlockApi({required Object requestModel}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.userBlock);

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithToken(), body: requestModel);

    return responseHandler(result: result, json: UserBlockResponseModel.parseInfo);
  }
}
