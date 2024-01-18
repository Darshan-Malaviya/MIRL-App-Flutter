import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class LoginRequestModel {
  String? email;
  String? loginType;
  String? deviceType;
  String? socialId;
  String? deviceToken;
  String? timezone;
  String? voIpToken;

  LoginRequestModel({this.email, this.loginType, this.deviceType, this.socialId, this.deviceToken, this.timezone,this.voIpToken});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    loginType = json['loginType'];
    deviceType = json['deviceType'];
    socialId = json['socialId'];
    deviceToken = json['deviceToken'];
    timezone = json['timezone'];
    voIpToken = json['voIpToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['loginType'] = this.loginType;
    data['deviceType'] = this.deviceType;
    data['socialId'] = this.socialId;
    data['deviceToken'] = this.deviceToken;
    data['timezone'] = this.timezone;
    data['voIpToken'] = this.voIpToken;
    return data;
  }
  String prepareRequest() {
    return jsonEncode(toJson());
  }
}
