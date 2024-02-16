import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class UserBlockRequestModel {
  int? userBlockId;
  int? status;

  UserBlockRequestModel({this.userBlockId, this.status});

  UserBlockRequestModel.fromJson(Map<String, dynamic> json) {
    userBlockId = json['userBlockId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userBlockId'] = this.userBlockId;
    data['status'] = this.status;
    return data;
  }

  String prepareRequest() {
    return jsonEncode(toJson());
  }
}
