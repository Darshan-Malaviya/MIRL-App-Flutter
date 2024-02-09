import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class GetSlotsResponseModel {
  int? status;
  String? message;
  List<SlotsData>? data;

  GetSlotsResponseModel({this.status, this.message, this.data});

  GetSlotsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SlotsData>[];
      json['data'].forEach((v) {
        data?.add(new SlotsData.fromJson(v));
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

  static Future<GetSlotsResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return GetSlotsResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("GetSlotsResponseModel exception : $e");
      return null;
    }
  }
}

class SlotsData {
  String? startTimeUTC;
  String? endTimeUTC;

  SlotsData({this.startTimeUTC, this.endTimeUTC});

  SlotsData.fromJson(Map<String, dynamic> json) {
    startTimeUTC = (json['startTimeUTC'] as String).to12HourTimeFormat();
    endTimeUTC = json['endTimeUTC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startTimeUTC'] = this.startTimeUTC;
    data['endTimeUTC'] = this.endTimeUTC;
    return data;
  }
}
