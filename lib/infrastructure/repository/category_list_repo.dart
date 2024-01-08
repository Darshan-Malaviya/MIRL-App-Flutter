import 'package:mirl/infrastructure/commons/constants/api_constants.dart';
import 'package:mirl/infrastructure/commons/enums/enum.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/category_list_response_model.dart';

class CategoryListRepository extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  Future<ApiHttpResult> categoryListApiCall({required int page, required int limit, required String isChild}) async {
    final uri = ApiConstants.endpointUri(
        path: ApiConstants.category,
        queryParameters: {"page": page.toString(), "limit": limit.toString(), "isChild": isChild.toString()});

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithOutToken(),
    );

    return responseHandler(result: result, json: CategoryListResponseModel.parseInfo);
  }
}
