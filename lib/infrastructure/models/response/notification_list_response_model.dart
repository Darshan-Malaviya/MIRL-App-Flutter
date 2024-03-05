import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/pagination_model.dart';

class NotificationListResponseModel {
  int? status;
  String? message;
  NotificationListData? data;
  Pagination? pagination;

  NotificationListResponseModel({this.status, this.message, this.data, this.pagination});

  NotificationListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new NotificationListData.fromJson(json['data']) : null;
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination?.toJson();
    }
    return data;
  }

  static Future<NotificationListResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return NotificationListResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("NotificationListResponseModel exception : $e");
      return null;
    }
  }
}

class NotificationListData {
  int? count;
  List<NotificationDetails>? notification;

  NotificationListData({this.count, this.notification});

  NotificationListData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['notification'] != null) {
      notification = <NotificationDetails>[];
      json['notification'].forEach((v) {
        notification?.add(new NotificationDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.notification != null) {
      data['notification'] = this.notification?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationDetails {
  int? id;
  String? isRead;
  NotificationData? notification;

  NotificationDetails({this.id, this.isRead, this.notification});

  NotificationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isRead = json['isRead'];
    notification = json['notification'] != null ? new NotificationData.fromJson(json['notification']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isRead'] = this.isRead;
    if (this.notification != null) {
      data['notification'] = this.notification?.toJson();
    }
    return data;
  }
}

class NotificationData {
  int? id;
  String? key;
  String? title;
  String? message;
  String? data;
  String? firstCreated;

  NotificationData({this.id, this.key, this.title, this.message, this.data, this.firstCreated});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    title = json['title'];
    message = json['message'];
    data = json['data'];
    firstCreated = json['firstCreated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['title'] = this.title;
    data['message'] = this.message;
    data['data'] = this.data;
    data['firstCreated'] = this.firstCreated;
    return data;
  }
}
