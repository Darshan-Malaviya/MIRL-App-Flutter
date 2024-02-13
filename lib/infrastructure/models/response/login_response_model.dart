import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/common_model.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';

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
  int? gender;
  int? loginType;
  String? country;
  String? userProfile;
  String? expertProfile;
  int? fee;
  bool? instantCallAvailable;
  bool? isLocationVisible;
  String? timezone;
  bool? isDeleted;
  String? firstCreated;
  String? lastModified;
  String? activeAt;
  bool? isFavorite;
  int? onlineStatus;
  List<CertificationData>? certification;
  List<WeeklyAvailableData>? expertAvailability;
  List<AreasOfExpertise>? areaOfExpertise;

  UserData(
      {this.id,
      this.userName,
      this.expertName,
      this.mirlId,
      this.email,
      this.phone,
      this.city,
      this.about,
      this.gender,
      this.loginType,
      this.country,
      this.userProfile,
      this.expertProfile,
      this.fee,
      this.instantCallAvailable,
      this.isLocationVisible,
      this.timezone,
      this.isDeleted,
      this.firstCreated,
      this.lastModified,
      this.activeAt,
      this.certification,
      this.isFavorite,
      this.expertAvailability,
      this.areaOfExpertise,this.onlineStatus});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    expertName = json['expertName'];
    mirlId = json['mirlId'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    about = json['about'];
    gender = json['gender'];
    loginType = json['loginType'];
    country = json['country'];
    userProfile = json['userProfile'];
    expertProfile = json['expertProfile'];
    fee = json['fee'];
    instantCallAvailable = json['instantCallAvailable'];
    isLocationVisible = json['isLocationVisible'];
    timezone = json['timezone'];
    isDeleted = json['isDeleted'];
    firstCreated = json['firstCreated'];
    lastModified = json['lastModified'];
    activeAt = json['activeAt'];
    onlineStatus = json['onlineStatus'];
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
    if (json['areaOfExpertise'] != null) {
      areaOfExpertise = <AreasOfExpertise>[];
      json['areaOfExpertise'].forEach((v) {
        areaOfExpertise?.add(new AreasOfExpertise.fromJson(v));
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
    data['gender'] = this.gender;
    data['loginType'] = this.loginType;
    data['country'] = this.country;
    data['userProfile'] = this.userProfile;
    data['expertProfile'] = this.expertProfile;
    data['fee'] = this.fee;
    data['instantCallAvailable'] = this.instantCallAvailable;
    data['isLocationVisible'] = this.isLocationVisible;
    data['timezone'] = this.timezone;
    data['isDeleted'] = this.isDeleted;
    data['firstCreated'] = this.firstCreated;
    data['lastModified'] = this.lastModified;
    data['activeAt'] = this.activeAt;
    data['isFavorite'] = this.isFavorite;
    data['onlineStatus'] = this.onlineStatus;
    if (this.certification != null) {
      data['certification'] = this.certification?.map((v) => v.toJson()).toList();
    }
    if (this.expertAvailability != null) {
      data['expertAvailability'] = this.expertAvailability?.map((v) => v.toJson()).toList();
    }
    if (this.areaOfExpertise != null) {
      data['areaOfExpertise'] = this.areaOfExpertise?.map((v) => v.toJson()).toList();
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

  WeeklyAvailableData({this.id, this.userId, this.dayOfWeek, this.startTime, this.endTime, this.isAvailable, this.scheduleType, this.firstCreated, this.lastModified});

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
  String? title;
  String? url;
  String? description;

  CertificationData({this.id, this.title, this.url, this.description});

  CertificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['description'] = this.description;
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
  int? id;
  String? name;
  String? image;
  String? description;
  List<Topic>? topic;

  AreasOfExpertise({this.id, this.name, this.image, this.description, this.topic});

  AreasOfExpertise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    if (json['topic'] != null) {
      topic = <Topic>[];
      json['topic'].forEach((v) {
        topic?.add(new Topic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    if (this.topic != null) {
      data['topic'] = this.topic?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
