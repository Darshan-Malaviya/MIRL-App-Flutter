import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/certificate_response_model.dart';
import 'package:mirl/infrastructure/models/response/expert_detail_response_model.dart';
import 'package:mirl/infrastructure/models/response/week_availability_response_model.dart';

class ExpertProfileRepo extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  Future<ApiHttpResult> editExpertAvailabilityApi({required dynamic request}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.expertAvailability);

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      body: request,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: WeekAvailabilityResponseModel.parseInfo);
  }

  Future<ApiHttpResult> editExpertCertificateApi({required dynamic request}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.certification);

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      body: request,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: CertificateResponseModel.parseInfo);
  }

  Future<ApiHttpResult> expertCertificateDeleteApi({required int certiId}) async {
    final uri = ApiConstants.endpointUri(path: '${ApiConstants.certification}/$certiId');

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.delete,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: CommonModel.parseInfo);
  }

  Future<ApiHttpResult> expertDetailApi() async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.updateUser);

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      apiType: APIType.get,
      headers: ApiConstants.headerWithToken(),
    );

    return responseHandler(result: result, json: ExpertDetailResponseModel.parseInfo);
  }
}
