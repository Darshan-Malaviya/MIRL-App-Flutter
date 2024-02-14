import 'package:logger/logger.dart';

class UserBlockResponseModel {
  int? status;
  String? message;
  BlockDetail? data;

  UserBlockResponseModel({this.status, this.message, this.data});

  UserBlockResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new BlockDetail.fromJson(json['data']) : null;
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

  static Future<UserBlockResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return UserBlockResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("UserBlockResponseModel exception : $e");
      return null;
    }
  }
}

class BlockDetail {
  int? id;
  int? userId;
  int? userBlockId;
  String? status;
  String? firstCreated;
  String? lastModified;

  BlockDetail({this.id, this.userId, this.userBlockId, this.status, this.firstCreated, this.lastModified});

  BlockDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userBlockId = json['userBlockId'];
    status = json['status'];
    firstCreated = json['firstCreated'];
    lastModified = json['lastModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['userBlockId'] = this.userBlockId;
    data['status'] = this.status;
    data['firstCreated'] = this.firstCreated;
    data['lastModified'] = this.lastModified;
    return data;
  }
}
