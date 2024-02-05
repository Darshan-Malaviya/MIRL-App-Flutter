import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/explore_expert_category_and_user_response.dart';
import 'package:mirl/infrastructure/models/response/get_single_category_response_model.dart';

class ExpertCategoryRepo extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  Future<ApiHttpResult> getSingleCategoryApi({required String categoryId}) async {
    final uri = ApiConstants.endpointUri(
        path: '${ApiConstants.category}/app/$categoryId', queryParameters: {'userId': SharedPrefHelper.getUserId});

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: GetSingleCategoryResponseModel.parseInfo);
  }

  Future<ApiHttpResult> exploreExpertUserAndCategoryApi({required Map<String, dynamic> request}) async {
    // final uri = ApiConstants.endpointUri(path: ApiConstants.user, queryParameters: {
    //   'search': request.search,
    //   'gender': request.gender,
    //   'instantCallAvailable': request.instantCallAvailable,
    //   'country': request.country,
    //   'categoryId': request.categoryId,
    //   'minFee': request.minFee,
    //   'maxFee': request.maxFee,
    // });

    final uri = ApiConstants.endpointUri(path: ApiConstants.user, queryParameters: request);
    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: ExploreExpertCategoryAndUserResponseModel.parseInfo);
  }
}
