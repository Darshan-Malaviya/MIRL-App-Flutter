import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/report_list_response_model.dart';

class ReportListRepository extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  Future<ApiHttpResult> reportListApi({required int page, required int limit, required int role}) async {
    final uri = ApiConstants.endpointUri(
        path: ApiConstants.reportList, queryParameters: {"page": page.toString(), "limit": limit.toString(), "role": role.toString()});

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithToken(), apiType: APIType.get);

    return responseHandler(result: result, json: ReportListResponseModel.parseInfo);
  }
}
