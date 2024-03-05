import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/pagination_model.dart';

class ReportCallTitleResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<ReportCallTitleList>? data;

  ReportCallTitleResponseModel(
      {this.status, this.message, this.pagination, this.data});

  ReportCallTitleResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <ReportCallTitleList>[];
      json['data'].forEach((v) {
        data!.add(new ReportCallTitleList.fromJson(v));
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

  static Future<ReportCallTitleResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return ReportCallTitleResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("ReportCallTitleResponseModel exception : $e");
      return null;
    }
  }
}

class ReportCallTitleList {
  int? id;
  String? title;
  String? description;
  bool? isDeleted;
  String? firstCreated;
  String? lastModified;

  ReportCallTitleList(
      {this.id,
        this.title,
        this.description,
        this.isDeleted,
        this.firstCreated,
        this.lastModified});

  ReportCallTitleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isDeleted = json['isDeleted'];
    firstCreated = json['firstCreated'];
    lastModified = json['lastModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['isDeleted'] = this.isDeleted;
    data['firstCreated'] = this.firstCreated;
    data['lastModified'] = this.lastModified;
    return data;
  }
}
