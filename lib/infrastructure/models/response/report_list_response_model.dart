import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/response/upcoming_appointment_response_model.dart';

class ReportListResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<ReportList>? data;

  ReportListResponseModel({this.status, this.message, this.pagination, this.data});

  ReportListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = <ReportList>[];
      json['data'].forEach((v) {
        data!.add(new ReportList.fromJson(v));
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

  static Future<ReportListResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return ReportListResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("ReportListResponseModel exception : $e");
      return null;
    }
  }
}

class ReportList {
  int? id;
  String? title;
  String? description;

  ReportList({this.id, this.title, this.description});

  ReportList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
