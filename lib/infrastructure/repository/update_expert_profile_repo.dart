import 'package:mirl/infrastructure/commons/constants/api_constants.dart';
import 'package:mirl/infrastructure/commons/enums/enum.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/country_response_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:dio/src/form_data.dart';

class UpdateUserDetailsRepository extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  Future<ApiHttpResult> UpdateUserDetails(FormData requestModel) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.updateUser);

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.put,
      body: requestModel,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: LoginResponseModel.parseInfo);
  }

  /// country API

  Future<ApiHttpResult> countryApiCall({
    required int page,
    required int limit,
  }) async {
    final uri = ApiConstants.endpointUri(
        path: ApiConstants.country, queryParameters: {"page": page.toString(), "limit": limit.toString()});

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithOutToken(),
    );

    return responseHandler(result: result, json: CountryResponseModel.parseInfo);
  }
}
