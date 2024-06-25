import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/cancel_appointment_request_model.dart';
import 'package:mirl/infrastructure/models/response/cancel_appointment_response_model.dart';
import 'package:mirl/infrastructure/models/response/upcoming_appointment_response_model.dart';
import 'package:mirl/infrastructure/repository/schedule_call_repository.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';

class CancelAppointmentProvider extends ChangeNotifier {
  final _scheduleCallRepository = ScheduleCallRepository();

  TextEditingController reasonController = TextEditingController();

  int? reasonTextLength = 0;

  bool? get isLoadingReason => _isLoadingReason;
  bool? _isLoadingReason = false;

  void setReasonLength(String value) {
    reasonTextLength = value.length;
    notifyListeners();
  }

  Future<void> cancelAppointmentApiCall({required BuildContext context, required GetUpcomingAppointment? appointmentData, required int role, required bool fromScheduled}) async {
    _isLoadingReason = true;
    notifyListeners();

    CancelAppointmentRequestModel requestModel = CancelAppointmentRequestModel(
      userId: appointmentData?.userId,
      expertId: appointmentData?.expertId,
      role: role,
      reason: reasonController.text.trim(),
    );

    ApiHttpResult response = await _scheduleCallRepository.cancelAppointment(request: requestModel.prepareRequest(), appointmentId: appointmentData?.id.toString() ?? '');

    _isLoadingReason = false;
    notifyListeners();

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CancelAppointmentResponseModel) {
          CancelAppointmentResponseModel responseModel = response.data;
          context.toPushNamed(RoutesConstants.canceledAppointmentScreen, args: CancelArgs(cancelData: responseModel.data, fromScheduled: fromScheduled, role: role));
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on cancelAppointmentApiCall Api ${response.data}");
        break;
    }
  }
}
