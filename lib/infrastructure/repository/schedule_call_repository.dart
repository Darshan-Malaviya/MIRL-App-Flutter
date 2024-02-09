import 'dart:async';
import 'package:mirl/infrastructure/commons/constants/api_constants.dart';
import 'package:mirl/infrastructure/commons/enums/enum.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/get_slots_response_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';

class ScheduleCallRepository extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  /// get slots
  Future<ApiHttpResult> getTimeSlotsApi({required String request}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.timeSlots);

    APIResponse result = await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithToken(), body: request);

    return responseHandler(result: result, json: GetSlotsResponseModel.parseInfo);
  }
}
