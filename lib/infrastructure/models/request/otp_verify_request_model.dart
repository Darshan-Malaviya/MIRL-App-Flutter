import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class OTPVerifyRequestModel {
  String? email;
  String? otp;

  OTPVerifyRequestModel({this.email, this.otp});

  OTPVerifyRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['otp'] = otp;
    return data;
  }
  String prepareRequest() {
    return jsonEncode(toJson());
  }
}
