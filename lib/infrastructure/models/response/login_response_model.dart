import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/common_model.dart';

class LoginResponseModel {
  int? status;
  UserData? data;
  String? message;
  String? token;
  CommonModel? err;

  LoginResponseModel({this.status, this.data, this.message, this.token});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
    message = json['message'];
    token = json['token'];
    err = json['err'] != null ? CommonModel.fromJson(json['err']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['message'] = this.message;
    data['token'] = this.token;
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
  String? city;
  String? about;
  String? otp;
  String? gender;
  String? loginType;
  String? googleId;
  String? appleId;
  String? facebookId;
  String? country;
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
  bool? instantCallAvailable;
  bool? locationFlag;
  bool? isLocationVisible;
  bool? genderFlag;
  bool? certificateFlag;
  bool? bankDetailsFlag;
  bool? mirlIdFlag;
  String? bankAccountHolderName;
  String? bankName;
  String? accountNumber;
  String? timezone;
  bool? isDeleted;
  String? firstCreated;
  String? lastModified;
  String? activeAt;
  bool? isFavorite;
  List<CertificationData>? certification;
  List<WeeklyAvailableData>? expertAvailability;
  List<AreasOfExpertise>? areasOfExpertise;

  UserData(
      {this.id,
      this.userName,
      this.expertName,
      this.mirlId,
      this.email,
      this.phone,
      this.city,
      this.about,
      this.otp,
      this.gender,
      this.loginType,
      this.googleId,
      this.appleId,
      this.facebookId,
      this.country,
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
      this.instantCallAvailable,
      this.locationFlag,
      this.isLocationVisible,
      this.genderFlag,
      this.certificateFlag,
      this.bankDetailsFlag,
      this.mirlIdFlag,
      this.bankAccountHolderName,
      this.bankName,
      this.accountNumber,
      this.timezone,
      this.isDeleted,
      this.firstCreated,
      this.lastModified,
      this.activeAt,
      this.certification,
      this.isFavorite,
      this.expertAvailability,
      this.areasOfExpertise});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    expertName = json['expertName'];
    mirlId = json['mirlId'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    about = json['about'];
    otp = json['otp'];
    gender = json['gender'];
    loginType = json['loginType'];
    googleId = json['googleId'];
    appleId = json['appleId'];
    facebookId = json['facebookId'];
    country = json['country'];
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
    instantCallAvailable = json['instantCallAvailable'];
    locationFlag = json['locationFlag'];
    isLocationVisible = json['isLocationVisible'];
    genderFlag = json['genderFlag'];
    certificateFlag = json['certificateFlag'];
    bankDetailsFlag = json['bankDetailsFlag'];
    mirlIdFlag = json['mirlIdFlag'];
    bankAccountHolderName = json['bankAccountHolderName'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    timezone = json['timezone'];
    isDeleted = json['isDeleted'];
    firstCreated = json['firstCreated'];
    lastModified = json['lastModified'];
    activeAt = json['activeAt'];
    isFavorite = json['isFavorite'];
    if (json['certification'] != null) {
      certification = <CertificationData>[];
      json['certification'].forEach((v) {
        certification?.add(new CertificationData.fromJson(v));
      });
    }
    if (json['expertAvailability'] != null) {
      expertAvailability = <WeeklyAvailableData>[];
      json['expertAvailability'].forEach((v) {
        expertAvailability?.add(new WeeklyAvailableData.fromJson(v));
      });
    }
    if (json['areasOfExpertise'] != null) {
      areasOfExpertise = <AreasOfExpertise>[];
      json['areasOfExpertise'].forEach((v) {
        areasOfExpertise!.add(new AreasOfExpertise.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['expertName'] = this.expertName;
    data['mirlId'] = this.mirlId;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['about'] = this.about;
    data['otp'] = this.otp;
    data['gender'] = this.gender;
    data['loginType'] = this.loginType;
    data['googleId'] = this.googleId;
    data['appleId'] = this.appleId;
    data['facebookId'] = this.facebookId;
    data['country'] = this.country;
    data['userProfile'] = this.userProfile;
    data['expertProfile'] = this.expertProfile;
    data['deviceToken'] = this.deviceToken;
    data['deviceType'] = this.deviceType;
    data['expirationTime'] = this.expirationTime;
    data['fee'] = this.fee;
    data['userProfileFlag'] = this.userProfileFlag;
    data['expertProfileFlag'] = this.expertProfileFlag;
    data['aboutFlag'] = this.aboutFlag;
    data['feeFlag'] = this.feeFlag;
    data['areaOfExpertiseFlag'] = this.areaOfExpertiseFlag;
    data['weeklyAvailableFlag'] = this.weeklyAvailableFlag;
    data['instantCallAvailable'] = this.instantCallAvailable;
    data['locationFlag'] = this.locationFlag;
    data['isLocationVisible'] = this.isLocationVisible;
    data['genderFlag'] = this.genderFlag;
    data['certificateFlag'] = this.certificateFlag;
    data['bankDetailsFlag'] = this.bankDetailsFlag;
    data['mirlIdFlag'] = this.mirlIdFlag;
    data['bankAccountHolderName'] = this.bankAccountHolderName;
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    data['timezone'] = this.timezone;
    data['isDeleted'] = this.isDeleted;
    data['firstCreated'] = this.firstCreated;
    data['lastModified'] = this.lastModified;
    data['activeAt'] = this.activeAt;
    data['isFavorite'] = this.isFavorite;

    if (this.certification != null) {
      data['certification'] = this.certification?.map((v) => v.toJson()).toList();
    }
    if (this.expertAvailability != null) {
      data['expertAvailability'] = this.expertAvailability?.map((v) => v.toJson()).toList();
    }
    if (this.areasOfExpertise != null) {
      data['areasOfExpertise'] = this.areasOfExpertise!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WeeklyAvailableData {
  int? id;
  int? userId;
  String? dayOfWeek;
  String? startTime;
  String? endTime;
  bool? isAvailable;
  String? scheduleType;
  String? firstCreated;
  String? lastModified;

  WeeklyAvailableData(
      {this.id,
      this.userId,
      this.dayOfWeek,
      this.startTime,
      this.endTime,
      this.isAvailable,
      this.scheduleType,
      this.firstCreated,
      this.lastModified});

  WeeklyAvailableData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    dayOfWeek = json['dayOfWeek'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    isAvailable = json['isAvailable'];
    scheduleType = json['scheduleType'];
    firstCreated = json['firstCreated'];
    lastModified = json['lastModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['dayOfWeek'] = this.dayOfWeek;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['isAvailable'] = this.isAvailable;
    data['scheduleType'] = this.scheduleType;
    data['firstCreated'] = this.firstCreated;
    data['lastModified'] = this.lastModified;
    return data;
  }
}

class CertificationData {
  int? id;
  int? userId;
  String? title;
  String? url;
  String? description;
  String? firstCreated;
  String? lastModified;

  CertificationData({this.id, this.userId, this.title, this.url, this.description, this.firstCreated, this.lastModified});

  CertificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    url = json['url'];
    description = json['description'];
    firstCreated = json['firstCreated'];
    lastModified = json['lastModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['url'] = this.url;
    data['description'] = this.description;
    data['firstCreated'] = this.firstCreated;
    data['lastModified'] = this.lastModified;
    return data;
  }

  Map<String, dynamic> toJsonForRequest() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['description'] = this.description;
    return data;
  }
}

class AreasOfExpertise {
  String? parentName;
  String? image;
  List<ExpertiseData>? data;

  AreasOfExpertise({this.parentName, this.image, this.data});

  AreasOfExpertise.fromJson(Map<String, dynamic> json) {
    parentName = json['parentName'];
    image = json['image'];
    if (json['data'] != null) {
      data = <ExpertiseData>[];
      json['data'].forEach((v) {
        data!.add(new ExpertiseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parentName'] = this.parentName;
    data['image'] = this.image;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpertiseData {
  int? id;
  String? name;
  String? description;

  ExpertiseData({this.id, this.name, this.description});

  ExpertiseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
