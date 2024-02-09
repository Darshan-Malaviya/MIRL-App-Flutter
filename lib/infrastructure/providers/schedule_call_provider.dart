import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/week_availability_model.dart';
import 'package:mirl/infrastructure/models/response/get_slots_response_model.dart';
import 'package:mirl/infrastructure/repository/schedule_call_repository.dart';

class ScheduleCallProvider extends ChangeNotifier {
  final _scheduleCallRepository = ScheduleCallRepository();

  TextEditingController reasonController = TextEditingController();

  List<weeklyAvailabilityModel> weekAvailability = [
    weeklyAvailabilityModel(weekDay: 'MONDAY', dayTime: '9:00AM  - 5:00PM'),
    weeklyAvailabilityModel(weekDay: 'TUESDAY', dayTime: '9:00AM  - 5:00PM'),
    weeklyAvailabilityModel(weekDay: 'WEDNESDAY', dayTime: '9:00AM  - 5:00PM'),
    weeklyAvailabilityModel(weekDay: 'THURSDAY', dayTime: '9:00AM  - 5:00PM'),
    weeklyAvailabilityModel(weekDay: 'FRIDAY', dayTime: '9:00AM  - 5:00PM'),
    weeklyAvailabilityModel(weekDay: 'SATURDAY', dayTime: '9:00AM  - 5:00PM'),
    weeklyAvailabilityModel(weekDay: 'SUNDAY', dayTime: '9:00AM  - 5:00PM'),
  ];

  int _callDuration = 20;

  int get callDuration => _callDuration;

  DateTime? selectedDate;

  String _selectedUTCDate = '';

  List<SlotsData> get slotList => _slotList;
  List<SlotsData> _slotList = [];

  bool get isLoadingSlot => _isLoadingSlot;
  bool _isLoadingSlot = false;

  void incrementCallDuration() {
    _callDuration += 10;
    notifyListeners();
  }

  void decrementCallDuration() {
    _callDuration -= 10;
    notifyListeners();
  }

  void getSelectedDate(DateTime dateTime) {
    final now = DateTime.now().toLocal();
    selectedDate = DateTime(dateTime.year, dateTime.month, dateTime.day, now.hour, now.minute, now.second);
    _selectedUTCDate = selectedDate?.toUtc().toIso8601String() ?? '';
    print(_selectedUTCDate);

    String getDate = _selectedUTCDate.to12HourTimeFormat();
    print(getDate);

    notifyListeners();
  }

  Future<void> getSlotsApi(BuildContext context) async {
    _isLoadingSlot = true;
    notifyListeners();
    ApiHttpResult response = await _scheduleCallRepository.getTimeSlotsApi(date: _selectedUTCDate, duration: _callDuration.toString(), expertId: '');
    _isLoadingSlot = false;
    notifyListeners();

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is GetSlotsResponseModel) {
          GetSlotsResponseModel responseModel = response.data;
          if (responseModel.data?.isNotEmpty ?? false) {
            _slotList.addAll(responseModel.data ?? []);
          }
          notifyListeners();
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on get slots Api ${response.data}");
        break;
    }
  }
}
