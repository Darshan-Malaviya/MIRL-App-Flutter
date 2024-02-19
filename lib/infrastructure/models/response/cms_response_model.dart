import 'package:logger/logger.dart';

class CMSResponseModel {
  int? status;
  String? message;
  CmsData? data;

  CMSResponseModel({this.status, this.message, this.data});

  CMSResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CmsData.fromJson(json['data']) : null;
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

  CmsData({this.id, this.pageKey, this.pageTitle, this.content, this.firstCreated, this.lastModified});

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
