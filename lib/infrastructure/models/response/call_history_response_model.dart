import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/pagination_model.dart';

class CallHistoryResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<CallHistoryData>? data;

  CallHistoryResponseModel({this.status, this.message, this.pagination, this.data});

  CallHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = <CallHistoryData>[];
      json['data'].forEach((v) {
        data!.add(new CallHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<CallHistoryResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return CallHistoryResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("CallHistoryResponseModel exception : $e");
      return null;
    }
  }
}

class CallHistoryData {
  int? id;
  String? date;
  String? requestType;
  UserDetails? userDetails;
  int? duration;
  int? totalPayment;
  List<CallStatusHistory>? callStatusHistory;
  String? status;

  CallHistoryData(
      {this.id,
      this.date,
      this.requestType,
      this.userDetails,
      this.duration,
      this.totalPayment,
      this.callStatusHistory,
      this.status});

  CallHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    requestType = json['requestType'];
    userDetails = json['userDetails'] != null ? new UserDetails.fromJson(json['userDetails']) : null;
    duration = json['duration'];
    totalPayment = json['totalPayment'];
    if (json['callStatusHistory'] != null) {
      callStatusHistory = <CallStatusHistory>[];
      json['callStatusHistory'].forEach((v) {
        callStatusHistory!.add(new CallStatusHistory.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['requestType'] = this.requestType;
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    data['duration'] = this.duration;
    data['totalPayment'] = this.totalPayment;
    if (this.callStatusHistory != null) {
      data['callStatusHistory'] = this.callStatusHistory!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class UserDetails {
  String? name;
  String? profile;
  int? fee;

  UserDetails({this.name, this.profile, this.fee});

  UserDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profile = json['profile'];
    fee = json['fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profile'] = this.profile;
    data['fee'] = this.fee;
    return data;
  }
}

class CallStatusHistory {
  String? status;
  String? firstCreated;

  CallStatusHistory({this.status, this.firstCreated});

  CallStatusHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    firstCreated = json['firstCreated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['firstCreated'] = this.firstCreated;
    return data;
  }
}
