import 'dart:async';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/appointment_response_model.dart';
import 'package:mirl/infrastructure/models/response/call_history_response_model.dart';
import 'package:mirl/infrastructure/models/response/cancel_appointment_response_model.dart';
import 'package:mirl/infrastructure/models/response/get_slots_response_model.dart';
import 'package:mirl/infrastructure/models/response/upcoming_appointment_response_model.dart';
import 'package:mirl/infrastructure/models/response/week_availability_response_model.dart';

class ScheduleCallRepository extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  /// get slots
  Future<ApiHttpResult> getTimeSlotsApi({required String request}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.timeSlots);

    APIResponse result = await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithToken(), body: request);

    return responseHandler(result: result, json: GetSlotsResponseModel.parseInfo);
  }

  /// get expertAvailability
  Future<ApiHttpResult> getExpertAvailabilityApi(int expertId) async {
    final uri = ApiConstants.endpointUri(path: '${ApiConstants.expertAvailability}/$expertId');

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithToken(), apiType: APIType.get);

    return responseHandler(result: result, json: WeekAvailabilityResponseModel.parseInfo);
  }

  /// booked appointment
  Future<ApiHttpResult> bookAppointment({required String request}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.appointment);

    APIResponse result = await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithToken(), body: request);

    return responseHandler(result: result, json: AppointmentResponseModel.parseInfo);
  }

  /// canceled appointment
  Future<ApiHttpResult> cancelAppointment({required String request, required String appointmentId}) async {
    final uri = ApiConstants.endpointUri(path: '${ApiConstants.appointment}/$appointmentId');

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithToken(), body: request, apiType: APIType.put);

    return responseHandler(result: result, json: CancelAppointmentResponseModel.parseInfo);
  }

  /// view appointment
  Future<ApiHttpResult> viewUpcomingAppointment({required Map<String, dynamic> queryParameters}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.appointment, queryParameters: queryParameters);

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithToken(), apiType: APIType.get);

    return responseHandler(result: result, json: UpcomingAppointmentResponseModel.parseInfo);
  }

  /// call history
  Future<ApiHttpResult> callHistory({required int page, required int limit, required int role}) async {
    final uri = ApiConstants.endpointUri(
        path: '${ApiConstants.callHistory}/${SharedPrefHelper.getUserId}',
        queryParameters: {"page": page.toString(), "limit": limit.toString(), "role": role.toString()});

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithToken(), apiType: APIType.get);

    return responseHandler(result: result, json: CallHistoryResponseModel.parseInfo);
  }
}
