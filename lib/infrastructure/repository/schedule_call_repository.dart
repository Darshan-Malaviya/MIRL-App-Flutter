import 'dart:async';
import 'package:mirl/infrastructure/commons/constants/api_constants.dart';
import 'package:mirl/infrastructure/commons/enums/enum.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';

class ScheduleCallRepository extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  /// get slots
  Future<ApiHttpResult> getTimeSlotsApi({required String date, required String expertId, required String duration}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.timeSlots, queryParameters: {'date': date, 'expertId': expertId, 'duration': duration});

    APIResponse result = await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithOutToken(), apiType: APIType.get);

    return responseHandler(result: result, json: LoginResponseModel.parseInfo);
  }
}
