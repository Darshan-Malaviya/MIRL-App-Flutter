import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/common/filter_model.dart';
import 'package:mirl/infrastructure/models/response/get_single_category_response_model.dart';

class ExpertCategoryRepo extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  Future<ApiHttpResult> filterExpertsApi({required FilterModel request}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.user, queryParameters: {
      'page': request.page,
      'limit': request.limit,
      'gender': request.gender,
      'instantCallAvailable': request.instantCallAvailable,
      'country': request.country,
      'city': request.city,
      'filterByCategoryId': request.filterByCategoryId,
      'minFee': request.minFee,
      'maxFee': request.maxFee,
    });

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: CommonModel.parseInfo);
  }

  Future<ApiHttpResult> getSingleCategoryApi({required String categoryId}) async {
    final uri = ApiConstants.endpointUri(path: '${ApiConstants.category}/app/$categoryId', queryParameters: {'userId': SharedPrefHelper.getUserId});

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: GetSingleCategoryResponseModel.parseInfo);
  }
}
