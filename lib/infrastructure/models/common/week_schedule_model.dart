class WeekScheduleModel {
  String? dayName;
  double startTime;
  double endTime;
  bool isAvailable;

  WeekScheduleModel({this.dayName, required this.startTime, required this.endTime, required this.isAvailable});
}
