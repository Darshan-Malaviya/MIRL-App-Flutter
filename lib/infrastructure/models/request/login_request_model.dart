class LoginRequestModel {
  String? email;
  String? loginType;
  String? deviceType;
  String? socialId;

  LoginRequestModel({this.email, this.loginType, this.deviceType, this.socialId});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    loginType = json['loginType'];
    deviceType = json['deviceType'];
    socialId = json['socialId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (email?.isNotEmpty ?? false) data['email'] = email;
    data['loginType'] = loginType;
    data['deviceType'] = deviceType;
    data['socialId'] = socialId;
    return data;
  }
}
