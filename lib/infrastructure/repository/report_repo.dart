import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/rate_and_review_response_model.dart';
import 'package:mirl/infrastructure/models/response/report_list_response_model.dart';
import 'package:mirl/infrastructure/models/response/un_block_user_response_model.dart';
import 'package:mirl/infrastructure/models/response/user_report_response_model.dart';

class ReportListRepository extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  Future<ApiHttpResult> reportListApi({required int page, required int limit, required int role}) async {
    final uri = ApiConstants.endpointUri(
        path: ApiConstants.reportList,
        queryParameters: {"page": page.toString(), "limit": limit.toString(), "role": role.toString()});

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithToken(), apiType: APIType.get);

    return responseHandler(result: result, json: ReportListResponseModel.parseInfo);
  }

  Future<ApiHttpResult> userReportApi({required Object requestModel}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.userReport);

    APIResponse result = await _apiResponseProvider.requestAPI(uri,
        headers: ApiConstants.headerWithToken(), apiType: APIType.post, body: requestModel);

    return responseHandler(result: result, json: UserReportResponseModel.parseInfo);
  }

  Future<ApiHttpResult> reviewAndRateListApi({required Map<String, dynamic> paras, required int id}) async {
    final uri = ApiConstants.endpointUri(path: '${ApiConstants.rateExpert}/$id', queryParameters: paras);

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithToken(), apiType: APIType.get);

    return responseHandler(result: result, json: RatingAndReviewResponseModel.parseInfo);
  }

  Future<ApiHttpResult> rateExpertApi({required Object requestModel}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.rateExpert);

    APIResponse result = await _apiResponseProvider.requestAPI(uri,
        headers: ApiConstants.headerWithToken(), apiType: APIType.post, body: requestModel);

    return responseHandler(result: result, json: UnBlockUserResponseModel.parseInfo);
  }
}
