import 'package:mirl/infrastructure/commons/constants/api_constants.dart';
import 'package:mirl/infrastructure/commons/enums/enum.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/city_response_model.dart';
import 'package:mirl/infrastructure/models/response/country_response_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:dio/src/form_data.dart';

class UpdateUserDetailsRepository extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  Future<ApiHttpResult> updateUserDetails(FormData requestModel) async {
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
    String? searchName,
  }) async {
    final uri;
    if(searchName == null){
       uri = ApiConstants.endpointUri(
          path: ApiConstants.country, queryParameters: {"page": page.toString(), "limit": limit.toString(),"order" :"ASC"});
    } else {
       uri = ApiConstants.endpointUri(
          path: ApiConstants.country, queryParameters: {"page": page.toString(), "limit": limit.toString(),"search" : searchName,
         "order" :"ASC"});
    }


    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithOutToken(),
    );

    return responseHandler(result: result, json: CountryResponseModel.parseInfo);
  }

  /// city API

  Future<ApiHttpResult> cityApiCall({
    required int page,
    required int limit,
    required String countryName,
    String? searchName,
  }) async {
    final uri;
    if(searchName == null) {
       uri = ApiConstants.endpointUri(
          path: ApiConstants.city, queryParameters: {"page": page.toString(), "limit": limit.toString(), "countryName": countryName,
         "order" :"ASC"});
    } else {
       uri = ApiConstants.endpointUri(
          path: ApiConstants.city, queryParameters: {"page": page.toString(), "limit": limit.toString(), "countryName": countryName, "search" : searchName,
         "order" :"ASC"});
    }


    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithOutToken(),
    );

    return responseHandler(result: result, json: CityResponseModel.parseInfo);
  }
}
