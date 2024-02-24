import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/pagination_model.dart';

class UserBlockResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<BlockDetail>? data;

  UserBlockResponseModel({this.status, this.message, this.pagination, this.data});

  UserBlockResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = <BlockDetail>[];
      json['data'].forEach((v) {
        data!.add(new BlockDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.pagination != null) {
      data['pagination'] = this.pagination?.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  int? status;
  String? firstCreated;
  UserDetail? userDetail;

  BlockDetail({this.id, this.userId, this.userBlockId, this.status, this.firstCreated, this.userDetail});

  BlockDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userBlockId = json['userBlockId'];
    status = json['status'];
    firstCreated = json['firstCreated'];
    userDetail = json['userDetail'] != null ? new UserDetail.fromJson(json['userDetail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['userBlockId'] = this.userBlockId;
    data['status'] = this.status;
    data['firstCreated'] = this.firstCreated;
    if (this.userDetail != null) {
      data['userDetail'] = this.userDetail!.toJson();
    }
    return data;
  }

  static Future<BlockDetail?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return BlockDetail.fromJson(json ?? {});
    } catch (e) {
      Logger().e("BlockDetail exception : $e");
      return null;
    }
  }
}

class UserDetail {
  int? id;
  String? userName;
  String? userProfile;

  UserDetail({this.id, this.userName, this.userProfile});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    userProfile = json['userProfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['userProfile'] = this.userProfile;
    return data;
  }
}
