import 'dart:convert';

class CancelAppointmentRequestModel {
  int? expertId;
  int? userId;
  String? role;
  String? reason;

  CancelAppointmentRequestModel({this.expertId, this.userId, this.role, this.reason});

  CancelAppointmentRequestModel.fromJson(Map<String, dynamic> json) {
    expertId = json['expertId'];
    userId = json['userId'];
    role = json['role'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expertId'] = this.expertId;
    data['userId'] = this.userId;
    data['role'] = this.role;
    data['reason'] = this.reason;
    return data;
  }

  String prepareRequest() {
    return jsonEncode(toJson());
  }
}
