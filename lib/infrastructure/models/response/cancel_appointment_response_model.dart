import 'package:logger/logger.dart';

class CancelAppointmentResponseModel {
  int? status;
  String? message;
  CancelAppointmentData? data;

  CancelAppointmentResponseModel({this.status, this.message, this.data});

  CancelAppointmentResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CancelAppointmentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }

  static Future<CancelAppointmentResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return CancelAppointmentResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("CancelAppointmentResponseModel exception : $e");
      return null;
    }
  }
}

class CancelAppointmentData {
  int? id;
  String? name;
  String? profileImage;
  String? date;
  String? duration;
  String? startTime;
  String? endTime;
  String? reason;

  CancelAppointmentData({this.id, this.name, this.profileImage, this.date, this.duration, this.startTime, this.endTime, this.reason});

  CancelAppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profileImage'];
    date = json['date'];
    duration = json['duration'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['date'] = this.date;
    data['duration'] = this.duration;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['reason'] = this.reason;
    return data;
  }
}
