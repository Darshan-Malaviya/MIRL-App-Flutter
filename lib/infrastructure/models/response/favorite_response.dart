import 'package:logger/logger.dart';

class FavoriteResponseModel {
  int? status;
  String? message;
  Data? data;

  FavoriteResponseModel({this.status, this.message, this.data});

  FavoriteResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

  static Future<FavoriteResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return FavoriteResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("FavoriteResponseModel exception : $e");
      return null;
    }
  }
}

class Data {
  int? id;
  int? userId;
  int? userFavoriteId;
  String? firstCreated;
  String? lastModified;

  Data({this.id, this.userId, this.userFavoriteId, this.firstCreated, this.lastModified});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userFavoriteId = json['userFavoriteId'];
    firstCreated = json['firstCreated'];
    lastModified = json['lastModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['userFavoriteId'] = this.userFavoriteId;
    data['firstCreated'] = this.firstCreated;
    data['lastModified'] = this.lastModified;
    return data;
  }
}
