class UpdateExpertProfileResponseModel {
  int? status;
  Data? data;
  String? message;

  UpdateExpertProfileResponseModel({this.status, this.data, this.message});

  UpdateExpertProfileResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? userName;
  String? expertName;
  String? mirlId;
  String? email;
  Null phone;
  Null location;
  String? about;
  String? otp;
  Null gender;
  String? loginType;
  Null googleId;
  Null appleId;
  Null facebookId;
  Null country;
  Null userProfile;
  String? expertProfile;
  Null deviceToken;
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
  String? bankAccountHolderName;
  String? bankName;
  String? accountNumber;
  bool? isDeleted;
  String? firstCreated;
  String? lastModified;
  String? activeAt;

  Data(
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
        this.instantCallAvailableFlag,
        this.locationFlag,
        this.isLocationVisible,
        this.genderFlag,
        this.certificateFlag,
        this.bankDetailsFlag,
        this.bankAccountHolderName,
        this.bankName,
        this.accountNumber,
        this.isDeleted,
        this.firstCreated,
        this.lastModified,
        this.activeAt});

  Data.fromJson(Map<String, dynamic> json) {
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
    instantCallAvailableFlag = json['instantCallAvailableFlag'];
    locationFlag = json['locationFlag'];
    isLocationVisible = json['isLocationVisible'];
    genderFlag = json['genderFlag'];
    certificateFlag = json['certificateFlag'];
    bankDetailsFlag = json['bankDetailsFlag'];
    bankAccountHolderName = json['bankAccountHolderName'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    isDeleted = json['isDeleted'];
    firstCreated = json['firstCreated'];
    lastModified = json['lastModified'];
    activeAt = json['activeAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['expertName'] = this.expertName;
    data['mirlId'] = this.mirlId;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['location'] = this.location;
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
    data['instantCallAvailableFlag'] = this.instantCallAvailableFlag;
    data['locationFlag'] = this.locationFlag;
    data['isLocationVisible'] = this.isLocationVisible;
    data['genderFlag'] = this.genderFlag;
    data['certificateFlag'] = this.certificateFlag;
    data['bankDetailsFlag'] = this.bankDetailsFlag;
    data['bankAccountHolderName'] = this.bankAccountHolderName;
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    data['isDeleted'] = this.isDeleted;
    data['firstCreated'] = this.firstCreated;
    data['lastModified'] = this.lastModified;
    data['activeAt'] = this.activeAt;
    return data;
  }
}
