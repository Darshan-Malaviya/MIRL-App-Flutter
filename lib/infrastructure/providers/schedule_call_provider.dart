import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/cancel_appointment_request_model.dart';
import 'package:mirl/infrastructure/models/request/schedule_appointment_request_model.dart';
import 'package:mirl/infrastructure/models/request/slots_request_model.dart';
import 'package:mirl/infrastructure/models/response/appointment_response_model.dart';
import 'package:mirl/infrastructure/models/response/cancel_appointment_response_model.dart';
import 'package:mirl/infrastructure/models/response/get_slots_response_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/models/response/week_availability_response_model.dart';
import 'package:mirl/infrastructure/repository/schedule_call_repository.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';

class ScheduleCallProvider extends ChangeNotifier {
  final _scheduleCallRepository = ScheduleCallRepository();

  TextEditingController reasonController = TextEditingController();

  List<WeeklyAvailableData> get weekAvailability => _weekAvailability;
  List<WeeklyAvailableData> _weekAvailability = [];

  int _callDuration = 20;

  int get callDuration => _callDuration;

  DateTime? selectedDate;

  String _selectedUTCDate = '';

  List<SlotsData> get slotList => _slotList;
  List<SlotsData> _slotList = [];

  bool get isLoadingSlot => _isLoadingSlot;
  bool _isLoadingSlot = false;

  bool get isLoadingAvailable => _isLoadingAvailable;
  bool _isLoadingAvailable = false;

  SlotsData? selectedSlotData;

  int? oldIndex;

  UserData? expertData;

  double? totalPayAmount;

  int? reasonTextLength = 0;

  AppointmentData? get appointmentData => _appointmentData;
  AppointmentData? _appointmentData;

  bool? get isLoadingReason => _isLoadingReason;
  bool? _isLoadingReason = false;

  void incrementCallDuration() {
    _callDuration += 10;
    getSlotsApi();
    notifyListeners();
  }

  void decrementCallDuration() {
    _callDuration -= 10;
    getSlotsApi();
    notifyListeners();
  }

  void getExpertData(UserData? data) {
    expertData = data;
    notifyListeners();
  }

  void getPayValue() {
    totalPayAmount = ((expertData?.fee ?? 0) / 100 * _callDuration);
    notifyListeners();
  }

  void setReasonLength(String value) {
    reasonTextLength = value.length;
    notifyListeners();
  }

  void getSelectedDate(DateTime dateTime) {
    final now = DateTime.now().toLocal();
    selectedDate = DateTime(dateTime.year, dateTime.month, dateTime.day, now.hour, now.minute, now.second);
    _selectedUTCDate = selectedDate?.toUtc().toString() ?? '';
    print(_selectedUTCDate);

    String getDate = _selectedUTCDate.to12HourTimeFormat();
    print(getDate);
    getSlotsApi();
    notifyListeners();
  }

  void getSelectedSlotData(SlotsData value, int index) {
    if (oldIndex == index) {
      if (_slotList[index].isSelected ?? false) {
        selectedSlotData = null;
        _slotList[index].isSelected = false;
        oldIndex = null;
      }
    } else {
      _slotList.forEach((element) {
        element.isSelected = false;
      });
      _slotList[index].isSelected = true;
      oldIndex = index;
      selectedSlotData = value;
    }
    notifyListeners();
  }

  Future<void> expertAvailabilityApi() async {
    _isLoadingAvailable = true;
    notifyListeners();

    ApiHttpResult response = await _scheduleCallRepository.getExpertAvailabilityApi(expertData?.id.toString() ?? '');

    _isLoadingAvailable = false;
    notifyListeners();

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is WeekAvailabilityResponseModel) {
          WeekAvailabilityResponseModel responseModel = response.data;
          _weekAvailability.addAll(responseModel.data ?? []);
          notifyListeners();
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on get expert availability Api ${response.data}");
        break;
    }
  }

  Future<void> getSlotsApi() async {
    _isLoadingSlot = true;
    notifyListeners();

    ApiHttpResult response = await _scheduleCallRepository.getTimeSlotsApi(
      request: SlotsRequestModel(expertId: expertData?.id.toString(), date: _selectedUTCDate, duration: _callDuration.toString()).prepareRequest(),
    );

    _isLoadingSlot = false;
    notifyListeners();

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is GetSlotsResponseModel) {
          GetSlotsResponseModel responseModel = response.data;
          _slotList.clear();
          selectedSlotData = null;
          oldIndex = null;
          _slotList.addAll(responseModel.data ?? []);
          notifyListeners();
        }
        break;
      case APIStatus.failure:
        _slotList.clear();
        selectedSlotData = null;
        oldIndex = null;
        notifyListeners();
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on get slots Api ${response.data}");
        break;
    }
  }

  Future<void> scheduleAppointmentApiCall({required BuildContext context}) async {
    CustomLoading.progressDialog(isLoading: true);

    ScheduleAppointmentRequestModel requestModel = ScheduleAppointmentRequestModel(
      duration: _callDuration.toString(),
      expertId: expertData?.id,
      endTime: selectedSlotData?.endTimeUTC ?? '',
      startTime: selectedSlotData?.startTimeUTC ?? '',
      status: '0',
      amount: ((totalPayAmount ?? 0) * 100).toInt(),
    );

    ApiHttpResult response = await _scheduleCallRepository.bookAppointment(request: requestModel.prepareRequest());

    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is AppointmentResponseModel) {
          AppointmentResponseModel responseModel = response.data;
          _appointmentData = responseModel.data;
          context.toPushNamed(RoutesConstants.bookingConfirmScreen);
          notifyListeners();
        }
        break;
      case APIStatus.failure:
        if (response.failure?.statusCode == 302) {
          context.toPop(result: 'callApi');
        }
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on scheduleAppointmentApiCall Api ${response.data}");
        break;
    }
  }

  Future<void> cancelAppointmentApiCall({required BuildContext context}) async {
    _isLoadingReason = true;
    notifyListeners();

    CancelAppointmentRequestModel requestModel = CancelAppointmentRequestModel(
      userId: int.parse(SharedPrefHelper.getUserId),
      expertId: expertData?.id,
      cancelByUser: '1',
      reason: reasonController.text.trim(),
    );

    ApiHttpResult response = await _scheduleCallRepository.cancelAppointment(request: requestModel.prepareRequest(), appointmentId: _appointmentData?.id.toString() ?? '');

    _isLoadingReason = false;
    notifyListeners();

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CancelAppointmentResponseModel) {
          CancelAppointmentResponseModel responseModel = response.data;
          context.toPushNamed(RoutesConstants.canceledAppointmentScreen, args: AppointmentArgs(cancelData: responseModel.data, fromUser: true));
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on cancelAppointmentApiCall Api ${response.data}");
        break;
    }
  }
}
