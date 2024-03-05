import 'package:logger/logger.dart';

class BlockDetailsResponseModel {
  int? status;
  String? message;
  BlockDetails? data;


  BlockDetailsResponseModel({this.status, this.message, this.data});

  BlockDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new BlockDetails.fromJson(json['data']) : null;
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
  static Future<BlockDetailsResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return BlockDetailsResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("BlockDetailsResponseModel exception : $e");
      return null;
    }
  }
}

class BlockDetails {
  int? id;
  int? userId;
  int? userBlockId;
  int? status;
  String? firstCreated;
  UserDetail? userDetail;

  BlockDetails(
      {this.id,
        this.userId,
        this.userBlockId,
        this.status,
        this.firstCreated,
        this.userDetail});

  BlockDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userBlockId = json['userBlockId'];
    status = json['status'];
    firstCreated = json['firstCreated'];
    userDetail = json['userDetail'] != null
        ? new UserDetail.fromJson(json['userDetail'])
        : null;
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
