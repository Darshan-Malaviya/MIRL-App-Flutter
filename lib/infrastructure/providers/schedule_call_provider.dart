import 'package:flutter/cupertino.dart';
import 'package:mirl/infrastructure/models/common/week_availability_model.dart';


class ScheduleCallProvider extends ChangeNotifier {
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

  incrementCallDuration(){
    _callDuration += 10;
    notifyListeners();
  }

  decrementCallDuration(){
    _callDuration -= 10;
    notifyListeners();
  }


}
