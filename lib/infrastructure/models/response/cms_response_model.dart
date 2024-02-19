import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/pagination_model.dart';

class CMSResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<CmsData>? data;

  CMSResponseModel({this.status, this.message, this.pagination, this.data});

  CMSResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <CmsData>[];
      json['data'].forEach((v) {
        data!.add(new CmsData.fromJson(v));
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


  static Future<CMSResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return CMSResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("CMSResponseModel exception : $e");
      return null;
    }
  }
}

class CmsData {
  int? id;
  String? pageKey;
  String? pageTitle;
  String? content;
  String? firstCreated;
  String? lastModified;

  CmsData(
      {this.id,
        this.pageKey,
        this.pageTitle,
        this.content,
        this.firstCreated,
        this.lastModified});

  CmsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageKey = json['pageKey'];
    pageTitle = json['pageTitle'];
    content = json['content'];
    firstCreated = json['firstCreated'];
    lastModified = json['lastModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pageKey'] = this.pageKey;
    data['pageTitle'] = this.pageTitle;
    data['content'] = this.content;
    data['firstCreated'] = this.firstCreated;
    data['lastModified'] = this.lastModified;
    return data;
  }
}
