import 'dart:async';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/referral_list_response_model.dart';
import 'package:mirl/infrastructure/models/response/get_your_own_referral_code_model.dart';

import '../models/response/submit_referral_code_response_model.dart';

class MIRLConnectRepository extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  /// get your own referral code in 24 hour
  Future<ApiHttpResult> getOwnReferralCodeApi() async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.getOwnReferralCode);

    APIResponse result = await _apiResponseProvider.requestAPI(
      uri,
      // headers: {
      //   'Authorization':
      //   "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZW1haWwiOiJkZXYxQHlvcG1haWwuY29tIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3MjAwMjc4MDJ9.A3niDxxWycxKstHMNRPMIqKEo1UuPHwW5pbHj1FbfMQ",
      //   'Content-Type': 'application/json',
      //   'mirlAppToken': 'Bearer 123123123'
      // },
      headers: ApiConstants.headerWithToken(),
    );
    return responseHandler(result: result, json: GetYourOwnReferralCodeModel.parseInfo);
  }

  /// submit referral code
  Future<ApiHttpResult> submitReferralCodeApi({required String friendReferralCode}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.submitReferralCode);

    APIResponse result = await _apiResponseProvider.requestAPI(uri,
        // headers: {
        //   'Authorization':
        //   "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZW1haWwiOiJkZXYxQHlvcG1haWwuY29tIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3MjAwMjc4MDJ9.A3niDxxWycxKstHMNRPMIqKEo1UuPHwW5pbHj1FbfMQ",
        //   'Content-Type': 'application/json',
        //   'mirlAppToken': 'Bearer 123123123'
        // },
        headers: ApiConstants.headerWithToken(),
        body: {"ref_code": friendReferralCode});
    return responseHandler(result: result, json: SubmitReferralCodeModel.parseInfo);
  }

  Future<ApiHttpResult> getReferralListApi({int currentPage = 1}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.getReferralList);

    APIResponse result = await _apiResponseProvider.requestAPI(uri,
        // headers: {
        //   'Authorization':
        //   "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZW1haWwiOiJkZXYxQHlvcG1haWwuY29tIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3MjAwMjc4MDJ9.A3niDxxWycxKstHMNRPMIqKEo1UuPHwW5pbHj1FbfMQ",
        //   'Content-Type': 'application/json',
        //   'mirlAppToken': 'Bearer 123123123'
        // },
        apiType: APIType.get,
        headers: ApiConstants.headerWithToken(),
        body: {"page": currentPage, "limit": 10});
    print("result ----> ${result.response!["pagination"]}");
    return responseHandler(result: result, json: ReferralListResponseModel.parseInfo);
  }
}
