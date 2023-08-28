import 'dart:async';
import 'package:api_handler/common/constant/api_constants.dart';
import 'package:api_handler/common/handler/api_response_handler.dart';
import 'package:api_handler/common/services/shared_pref_helper.dart';
import 'package:api_handler/data_access_layer/api/api_response.dart';
import 'package:api_handler/data_access_layer/api/api_response_provider.dart';
import 'package:api_handler/models/response/book_service_response.dart';


class AuthRepository extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider =
      ApiResponseProvider(header: ApiConstants.headerWithAuthToken(SharedPrefHelper.getAuthToken));

  /// login
  Future<ApiHttpResult> login(String requestModel) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.login);

    APIResponse result = await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithoutAccessToken(), body: requestModel);

    return responseHandler(result: result, json: ServiceResponseModel.parseInfo);
  }
}