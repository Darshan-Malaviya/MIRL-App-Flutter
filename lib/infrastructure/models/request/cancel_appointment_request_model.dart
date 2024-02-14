import 'dart:convert';

class CancelAppointmentRequestModel {
  int? expertId;
  int? userId;
  String? cancelByUser;
  String? reason;

  CancelAppointmentRequestModel({this.expertId, this.userId, this.cancelByUser, this.reason});

  CancelAppointmentRequestModel.fromJson(Map<String, dynamic> json) {
    expertId = json['expertId'];
    userId = json['userId'];
    cancelByUser = json['cancelByUser'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expertId'] = this.expertId;
    data['userId'] = this.userId;
    data['cancelByUser'] = this.cancelByUser;
    data['reason'] = this.reason;
    return data;
  }

  String prepareRequest() {
    return jsonEncode(toJson());
  }
}
