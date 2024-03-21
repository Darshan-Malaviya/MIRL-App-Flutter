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
      data['data'] = this.data?.toJson();
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
  int? id;
  String? date;
  int? duration;
  String? startTime;
  String? endTime;
  String? status;
  String? expertTimezone;
  String? userTimezone;
  ExpertDetail? expertDetail;

  AppointmentData({this.id,this.date, this.duration, this.startTime, this.endTime, this.status, this.expertDetail,this.expertTimezone,this.userTimezone});

  AppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    duration = json['duration'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    expertTimezone = json['expertTimezone'];
    userTimezone = json['userTimezone'];
    expertDetail = json['expertDetail'] != null ? new ExpertDetail.fromJson(json['expertDetail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['duration'] = this.duration;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['status'] = this.status;
    data['expertTimezone'] = this.expertTimezone;
    data['userTimezone'] = this.userTimezone;
    if (this.expertDetail != null) {
      data['expertDetail'] = this.expertDetail?.toJson();
    }
    return data;
  }
}

class ExpertDetail {
  int? id;
  String? userName;
  String? expertName;
  String? expertProfile;

  ExpertDetail({this.id, this.userName, this.expertName,this.expertProfile});

  ExpertDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    expertName = json['expertName'];
    expertProfile = json['expertProfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['expertName'] = this.expertName;
    data['expertProfile'] = this.expertProfile;
    return data;
  }
}
