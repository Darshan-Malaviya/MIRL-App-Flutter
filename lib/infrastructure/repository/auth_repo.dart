import 'dart:async';

import 'package:flutter_boilerplate_may_2023/infrastructure/commons/constants/api_constants.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/data_access_layer/api/api_response.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/models/response/book_service_response.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/services/shared_pref_helper.dart';


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