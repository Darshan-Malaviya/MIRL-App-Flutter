import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class LoginRequestModel {
  String? email;
  int? loginType;
  String? deviceType;
  String? socialId;
  String? deviceToken;
  String? timezone;
  String? voIpToken;
  String? deviceId;

  LoginRequestModel({this.email, this.loginType, this.deviceType, this.socialId, this.deviceToken, this.timezone,this.voIpToken,this.deviceId});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    loginType = json['loginType'];
    deviceType = json['deviceType'];
    socialId = json['socialId'];
    deviceToken = json['deviceToken'];
    timezone = json['timezone'];
    voIpToken = json['voIpToken'];
    voIpToken = json['deviceId'];
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
    data['deviceId'] = this.deviceId;
    return data;
  }

  Map<String, dynamic> toJsonForAppleWhenEmailEmpty() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginType'] = this.loginType;
    data['deviceType'] = this.deviceType;
    data['socialId'] = this.socialId;
    data['deviceToken'] = this.deviceToken;
    data['timezone'] = this.timezone;
    data['voIpToken'] = this.voIpToken;
    data['deviceId'] = this.deviceId;
    return data;
  }

  String prepareRequest() {
    return jsonEncode(toJson());
  }

  String prepareRequestForAppleWhenEmailEmpty() {
    return jsonEncode(toJsonForAppleWhenEmailEmpty());
  }
}
