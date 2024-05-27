import 'package:mirl/infrastructure/models/common/instance_call_emits_response_model.dart';

class NotificationData {
  String? key;
  String? date;
  String? expertId;
  String? sendTo;
  String? role;
  String? appointmentId;
  String? userId;
  String? id;
  String? profile;
  String? name;
  String? duration;
  String? startTime;
  String? endTime;
  String? reason;
  String? callRequestId;
  String? time;
  String? requestedDuration;
  List<ExpertDetails>? experts;

  NotificationData(
      {this.date,
      this.expertId,
      this.sendTo,
      this.role,
      this.appointmentId,
      this.userId,
      this.key,
      this.id,
      this.profile,
      this.name,
      this.duration,
      this.startTime,
      this.endTime,
      this.reason,
      this.callRequestId,
      this.time,
      this.requestedDuration,
      this.experts});

  NotificationData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    date = json['date'];
    expertId = json['expertId'];
    sendTo = json['sendTo'];
    role = json['role'];
    appointmentId = json['appointmentId'];
    userId = json['userId'];
  }

  NotificationData.fromJsonMultiConnect(Map<String, dynamic> json) {
    key = json['key'];
    date = json['date'];
    sendTo = json['sendTo'];
    role = json['role'];
    callRequestId = json['callRequestId'];
    time = json['time'];
    requestedDuration = json['requestedDuration'];
    if (json['experts'] != null) {
      experts = <ExpertDetails>[];
      json['experts'].forEach((v) {
        experts?.add(new ExpertDetails.fromJson(v));
      });
    }
  }

  NotificationData.fromJsonCanceled(Map<String, dynamic> json) {
    key = json['key'];
    date = json['date'];
    role = json['role'];
    id = json['id'];
    profile = json['profile'];
    name = json['name'];
    duration = json['duration'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['date'] = this.date;
    data['expertId'] = this.expertId;
    data['sendTo'] = this.sendTo;
    data['role'] = this.role;
    data['appointmentId'] = this.appointmentId;
    data['userId'] = this.userId;
    if (this.experts != null) {
      data['experts'] = this.experts?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
