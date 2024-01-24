import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';

class WeekAvailabilityResponseModel {
  int? status;
  String? message;
  List<WeeklyAvailableData>? data;

  WeekAvailabilityResponseModel({this.status, this.message, this.data});

  WeekAvailabilityResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <WeeklyAvailableData>[];
      json['data'].forEach((v) {
        data!.add(new WeeklyAvailableData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<WeekAvailabilityResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return WeekAvailabilityResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("WeekAvailabilityResponseModel exception : $e");
      return null;
    }
  }
}
