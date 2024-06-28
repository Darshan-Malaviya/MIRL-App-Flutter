import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class appStartUpRequestModel {
  int? userId;
  String? deviceId;
  String? fcm;

  appStartUpRequestModel({this.userId, this.deviceId, this.fcm});

  appStartUpRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    deviceId = json['deviceId'];
    fcm = json['fcm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['deviceId'] = this.deviceId;
    data['fcm'] = this.fcm;
    return data;
  }
  String prepareRequest() {
    return jsonEncode(toJson());
  }
}
