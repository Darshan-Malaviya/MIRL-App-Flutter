import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ScheduleAppointmentRequestModel {
  int? expertId;
  String? duration;
  String? startTime;
  String? endTime;
  String? status;

  ScheduleAppointmentRequestModel({this.expertId, this.duration, this.startTime, this.endTime, this.status});

  ScheduleAppointmentRequestModel.fromJson(Map<String, dynamic> json) {
    expertId = json['expertId'];
    duration = json['duration'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expertId'] = this.expertId;
    data['duration'] = this.duration;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['status'] = this.status;
    return data;
  }

  String prepareRequest() {
    return jsonEncode(toJson());
  }
}
