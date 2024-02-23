import 'package:mirl/infrastructure/commons/constants/api_constants.dart';
import 'package:mirl/infrastructure/commons/enums/enum.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/all_category_response_model.dart';

class CommonRepository extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  Future<ApiHttpResult> allCategoryLIstService({Map<String, dynamic>? requestModel}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.category, queryParameters: requestModel);
    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: AllCategoryListResponseModel.parseInfo);
  }


  Future<ApiHttpResult> allTopicListByCategoryService({Map<String, dynamic>? requestModel}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.topicByCategory, queryParameters: requestModel);
    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: AllCategoryListResponseModel.parseInfo);
  }
}
