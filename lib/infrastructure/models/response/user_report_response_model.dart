import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/response/favorite_response.dart';

class UserReportResponseModel {
  int? status;
  String? message;
  Data? data;

  UserReportResponseModel({this.status, this.message, this.data});

  UserReportResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  static Future<UserReportResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return UserReportResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("UserReportResponseModel exception : $e");
      return null;
    }
  }
}

