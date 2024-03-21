import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/schedule_appointment_request_model.dart';
import 'package:mirl/infrastructure/models/request/slots_request_model.dart';
import 'package:mirl/infrastructure/models/response/appointment_response_model.dart';
import 'package:mirl/infrastructure/models/response/get_slots_response_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/models/response/week_availability_response_model.dart';
import 'package:mirl/infrastructure/repository/schedule_call_repository.dart';

class ScheduleCallProvider extends ChangeNotifier {
  final _scheduleCallRepository = ScheduleCallRepository();

  TextEditingController reasonController = TextEditingController();

  List<WeeklyAvailableData> get weekAvailability => _weekAvailability;
  List<WeeklyAvailableData> _weekAvailability = [];

  int _callDuration = 20;

  int get callDuration => _callDuration;

  DateTime? selectedDate;

  late DateTime selectedDateStartTime;

  late DateTime selectedDateEndTime;

  String _selectedUTCDate = '';

  String userLocalTimeZone = '';

  List<SlotsData> get slotList => _slotList;
  List<SlotsData> _slotList = [];

  bool get isLoadingSlot => _isLoadingSlot;
  bool _isLoadingSlot = false;

  bool get isLoadingAvailable => _isLoadingAvailable;
  bool _isLoadingAvailable = false;

  SlotsData? selectedSlotData;

  int? oldIndex;

  AppointmentData? get appointmentData => _appointmentData;
  AppointmentData? _appointmentData;

  UserData? expertData;

  double? totalPayAmount;

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
    totalPayAmount = ((expertData?.fee ?? 0) /
        100 *
        (_callDuration == 20
            ? 2
            : _callDuration == 30
                ? 3
                : 1));
    notifyListeners();
  }

  void getSelectedDate(DateTime dateTime) {
    final now = DateTime.now().toLocal();
    selectedDate = DateTime(dateTime.year, dateTime.month, dateTime.day, now.hour, now.minute, now.second).toUtc();
    selectedDateStartTime = DateTime(dateTime.year, dateTime.month, dateTime.day, 00, 00).toUtc();
    selectedDateEndTime = DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59).toUtc();
    _selectedUTCDate = selectedDate?.toIso8601String() ?? '';
    print(_selectedUTCDate);
    print(":selectedDateStartTime ${selectedDateStartTime.toIso8601String()}");
    print(":selectedDateEndTime ${selectedDateEndTime.toIso8601String()}");
    print(_selectedUTCDate);
    getSlotsApi();
    notifyListeners();
  }

  void getTimeZone() async {
    final Duration timeDuration = DateTime.now().timeZoneOffset;
    final String timeZone = DateTime.now().timeZoneName;
    userLocalTimeZone = '$timeZone (UTC ${timeDuration.inHours}:${timeDuration.inMinutes.remainder(60)})';
   // userLocalTimeZone = '$timeZone (UTC $timeDuration)';
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

    ApiHttpResult response = await _scheduleCallRepository.getExpertAvailabilityApi(expertData?.id ?? 0);

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
      request: SlotsRequestModel(
              expertId: expertData?.id,
              date: _selectedUTCDate,
              duration: _callDuration * 60,
              endDate: selectedDateEndTime.toIso8601String(),
              startDate: selectedDateStartTime.toIso8601String())
          .prepareRequest(),
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
      duration: _callDuration * 60,
      expertId: expertData?.id,
      endTime: selectedSlotData?.endTimeUTC ?? '',
      startTime: selectedSlotData?.startTimeUTC ?? '',
      status: '3',
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
}
