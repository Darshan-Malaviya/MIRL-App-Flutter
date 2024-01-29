import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';

class ExpertDetailResponseModel {
  int? status;
  UserData? data;
  String? message;

  ExpertDetailResponseModel({this.status, this.data, this.message});

  ExpertDetailResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
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
  static Future<ExpertDetailResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return ExpertDetailResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("ExpertDetailResponseModel exception : $e");
      return null;
    }
  }
}