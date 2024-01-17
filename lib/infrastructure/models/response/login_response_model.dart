import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/common_model.dart';

class LoginResponseModel {
  int? status;
  UserData? data;
  String? message;
  String? token;
  CommonModel? err;

  LoginResponseModel({this.status, this.data, this.message, this.token , this.err});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
    message = json['message'];
    token = json['token'];
    err = json['err'] != null ? CommonModel.fromJson(json['err']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['message'] = message;
    data['token'] = token;
    if (err != null) {
      data['err'] = err?.toJson();
    }
    return data;
  }

  static Future<LoginResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return LoginResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("LoginResponseModel exception : $e");
      return null;
    }
  }
}

class UserData {
  int? id;
  String? userName;
  String? expertName;
  String? mirlId;
  String? email;
  String? phone;
  String? location;
  String? about;
  String? otp;
  String? gender;
  String? loginType;
  String? googleId;
  String? appleId;
  String? facebookId;
  String? userProfile;
  String? expertProfile;
  String? deviceToken;
  String? deviceType;
  int? expirationTime;
  String? fee;
  bool? userProfileFlag;
  bool? expertProfileFlag;
  bool? aboutFlag;
  bool? feeFlag;
  bool? areaOfExpertiseFlag;
  bool? weeklyAvailableFlag;
  bool? instantCallAvailableFlag;
  bool? locationFlag;
  bool? isLocationVisible;
  bool? genderFlag;
  bool? certificateFlag;
  bool? bankDetailsFlag;
  String? firstCreated;
  String? lastModified;

  UserData(
      {this.id,
      this.userName,
      this.expertName,
      this.mirlId,
      this.email,
      this.phone,
      this.location,
      this.about,
      this.otp,
      this.gender,
      this.loginType,
      this.googleId,
      this.appleId,
      this.facebookId,
      this.userProfile,
      this.expertProfile,
      this.deviceToken,
      this.deviceType,
      this.expirationTime,
      this.fee,
      this.userProfileFlag,
      this.expertProfileFlag,
      this.aboutFlag,
      this.feeFlag,
      this.areaOfExpertiseFlag,
      this.weeklyAvailableFlag,
      this.instantCallAvailableFlag,
      this.locationFlag,
      this.isLocationVisible,
      this.genderFlag,
      this.certificateFlag,
      this.bankDetailsFlag,
      this.firstCreated,
      this.lastModified});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    expertName = json['expertName'];
    mirlId = json['mirlId'];
    email = json['email'];
    phone = json['phone'];
    location = json['location'];
    about = json['about'];
    otp = json['otp'];
    gender = json['gender'];
    loginType = json['loginType'];
    googleId = json['googleId'];
    appleId = json['appleId'];
    facebookId = json['facebookId'];
    userProfile = json['userProfile'];
    expertProfile = json['expertProfile'];
    deviceToken = json['deviceToken'];
    deviceType = json['deviceType'];
    expirationTime = json['expirationTime'];
    fee = json['fee'];
    userProfileFlag = json['userProfileFlag'];
    expertProfileFlag = json['expertProfileFlag'];
    aboutFlag = json['aboutFlag'];
    feeFlag = json['feeFlag'];
    areaOfExpertiseFlag = json['areaOfExpertiseFlag'];
    weeklyAvailableFlag = json['weeklyAvailableFlag'];
    instantCallAvailableFlag = json['instantCallAvailableFlag'];
    locationFlag = json['locationFlag'];
    isLocationVisible = json['isLocationVisible'];
    genderFlag = json['genderFlag'];
    certificateFlag = json['certificateFlag'];
    bankDetailsFlag = json['bankDetailsFlag'];
    firstCreated = json['firstCreated'];
    lastModified = json['lastModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['expertName'] = expertName;
    data['mirlId'] = mirlId;
    data['email'] = email;
    data['phone'] = phone;
    data['location'] = location;
    data['about'] = about;
    data['otp'] = otp;
    data['gender'] = gender;
    data['loginType'] = loginType;
    data['googleId'] = googleId;
    data['appleId'] = appleId;
    data['facebookId'] = facebookId;
    data['userProfile'] = userProfile;
    data['expertProfile'] = expertProfile;
    data['deviceToken'] = deviceToken;
    data['deviceType'] = deviceType;
    data['expirationTime'] = expirationTime;
    data['fee'] = fee;
    data['userProfileFlag'] = userProfileFlag;
    data['expertProfileFlag'] = expertProfileFlag;
    data['aboutFlag'] = aboutFlag;
    data['feeFlag'] = feeFlag;
    data['areaOfExpertiseFlag'] = areaOfExpertiseFlag;
    data['weeklyAvailableFlag'] = weeklyAvailableFlag;
    data['instantCallAvailableFlag'] = instantCallAvailableFlag;
    data['locationFlag'] = locationFlag;
    data['isLocationVisible'] = isLocationVisible;
    data['genderFlag'] = genderFlag;
    data['certificateFlag'] = certificateFlag;
    data['bankDetailsFlag'] = bankDetailsFlag;
    data['firstCreated'] = firstCreated;
    data['lastModified'] = lastModified;
    return data;
  }
}
