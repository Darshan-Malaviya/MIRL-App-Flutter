import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/home_data_response_model.dart';
import 'package:mirl/infrastructure/models/response/home_search_response_model.dart';
import 'package:mirl/infrastructure/models/response/see_all_favorite_experts_list_response_model.dart';

class HomeRepo extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  Future<ApiHttpResult> homePageService() async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.homepage + SharedPrefHelper.getUserId);

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithToken(),
    );
    return responseHandler(result: result, json: HomeDataResponseModel.parseInfo);
  }

  Future<ApiHttpResult> homePageSearchService({required String searchKeyword}) async {
    final uri = ApiConstants.endpointUri(
        path: ApiConstants.homepageSearch + SharedPrefHelper.getUserId, queryParameters: {"search": searchKeyword});

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithToken(),
    );
    return responseHandler(result: result, json: HomeSearchResponseModel.parseInfo);
  }

  Future<ApiHttpResult> favoriteExpertsList({required int page, required int limit}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.favorite + SharedPrefHelper.getUserId,queryParameters: {"page": page.toString(), "limit": limit.toString()});

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithToken(),
    );
    return responseHandler(result: result, json: SeeAllFavoriteExpertsListResponseModel.parseInfo);
  }

  Future<ApiHttpResult> lastConversationList({required int page, required int limit}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.lastConversation + SharedPrefHelper.getUserId,queryParameters: {"page": page.toString(), "limit": limit.toString()});

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithToken(),
    );
    return responseHandler(result: result, json: SeeAllFavoriteExpertsListResponseModel.parseInfo);
  }
}
