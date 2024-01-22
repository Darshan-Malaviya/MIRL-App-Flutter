import 'package:mirl/infrastructure/commons/constants/api_constants.dart';
import 'package:mirl/infrastructure/commons/enums/enum.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/child_update_response.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';

class AddYourAreaExpertiseRepository extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  Future<ApiHttpResult> areaExpertiseApiCall({required int page, required int limit}) async {
    final uri = ApiConstants.endpointUri(
        path: ApiConstants.expertCategory, queryParameters: {"page": page.toString(), "limit": limit.toString()});

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: ExpertCategoryResponseModel.parseInfo);
  }

  Future<ApiHttpResult> expertiseChildUpdateApiCall({required dynamic request}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.expertCategorySelection);

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.put,
      body: request,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: ChildUpdateResponseModel.parseInfo);
  }
}
