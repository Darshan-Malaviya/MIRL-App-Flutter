import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ScheduleAppointmentRequestModel {
  int? expertId;
  int? amount;
  int? duration;
  String? startTime;
  String? endTime;
  String? status;

  ScheduleAppointmentRequestModel({this.expertId, this.duration, this.startTime, this.endTime, this.status,this.amount});

  ScheduleAppointmentRequestModel.fromJson(Map<String, dynamic> json) {
    expertId = json['expertId'];
    amount = json['amount'];
    duration = json['duration'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expertId'] = this.expertId;
    data['amount'] = this.amount;
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
