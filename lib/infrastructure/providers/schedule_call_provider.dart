import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/week_availability_model.dart';
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

  void incrementCallDuration() {
    _callDuration += 10;
    notifyListeners();
  }

  void decrementCallDuration() {
    _callDuration -= 10;
    notifyListeners();
  }

  void getSelectedDate(DateTime dateTime) {
    selectedDate = dateTime.toUtc();
    print(selectedDate);
    notifyListeners();
  }

  Future<void> getSlotsApi(BuildContext context) async {
    ApiHttpResult response = await _scheduleCallRepository.getTimeSlotsApi(date: '', duration: _callDuration.toString(), expertId: '');

    switch (response.status) {
      case APIStatus.success:
        // if (response.data != null && response.data is CertificateResponseModel) {}
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on get slots Api ${response.data}");
        break;
    }
  }
}
