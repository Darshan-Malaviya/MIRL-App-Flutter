import 'package:logger/logger.dart';

class AppointmentResponseModel {
  int? status;
  AppointmentData? data;
  String? message;

  AppointmentResponseModel({this.status, this.data, this.message});

  AppointmentResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new AppointmentData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }

  static Future<AppointmentResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return AppointmentResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("AppointmentResponseModel exception : $e");
      return null;
    }
  }
}

class AppointmentData {
  String? date;
  String? duration;
  String? startTime;
  String? endTime;
  String? status;
  String? reason;
  ExpertDetail? expertDetail;

  AppointmentData(
      {this.date,
        this.duration,
        this.startTime,
        this.endTime,
        this.status,
        this.reason,
        this.expertDetail});

  AppointmentData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    duration = json['duration'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    reason = json['reason'];
    expertDetail = json['expertDetail'] != null
        ? new ExpertDetail.fromJson(json['expertDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['duration'] = this.duration;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['status'] = this.status;
    data['reason'] = this.reason;
    if (this.expertDetail != null) {
      data['expertDetail'] = this.expertDetail!.toJson();
    }
    return data;
  }
}

class ExpertDetail {
  int? id;
  String? userName;
  String? expertName;

  ExpertDetail({this.id, this.userName, this.expertName});

  ExpertDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    expertName = json['expertName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['expertName'] = this.expertName;
    return data;
  }
}
