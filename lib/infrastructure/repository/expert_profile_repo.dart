import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';

class ExpertProfileRepo extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  Future<ApiHttpResult> editExpertAvailabilityApi({required dynamic request}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.expertAvailability);

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      body: request,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: CommonModel.parseInfo);
  }

  Future<ApiHttpResult> editExpertCertificateApi({required dynamic request}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.certification);

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      body: request,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: CommonModel.parseInfo);
  }

  Future<ApiHttpResult> expertCertificateDeleteApi({required dynamic certiId}) async {
    final uri = ApiConstants.endpointUri(path: '${ApiConstants.deleteCertification}/$certiId');

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.delete,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: CommonModel.parseInfo);
  }
}
