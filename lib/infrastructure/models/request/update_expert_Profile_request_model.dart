class UpdateExpertProfileRequestModel {
  String? userName;
  String? expertName;
  String? mirlId;
  String? location;
  String? about;
  String? gender;
  String? fee;
  String? userProfileFlag;
  String? expertProfileFlag;
  String? aboutFlag;
  String? feeFlag;
  String? areaOfExpertiseFlag;
  String? weeklyAvailableFlag;
  String? instantCallAvailableFlag;
  String? locationFlag;
  String? genderFlag;
  String? certificateFlag;
  String? bankDetailsFlag;
  String? phone;
  String? isLocationVisible;
  String? bankAccountHolderName;
  String? bankName;
  String? accountNumber;

  UpdateExpertProfileRequestModel(
      {this.userName,
        this.expertName,
        this.mirlId,
        this.location,
        this.about,
        this.gender,
        this.fee,
        this.userProfileFlag,
        this.expertProfileFlag,
        this.aboutFlag,
        this.feeFlag,
        this.areaOfExpertiseFlag,
        this.weeklyAvailableFlag,
        this.instantCallAvailableFlag,
        this.locationFlag,
        this.genderFlag,
        this.certificateFlag,
        this.bankDetailsFlag,
        this.phone,
        this.isLocationVisible,
        this.bankAccountHolderName,
        this.bankName,
        this.accountNumber});

  UpdateExpertProfileRequestModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    expertName = json['expertName'];
    mirlId = json['mirlId'];
    location = json['location'];
    about = json['about'];
    gender = json['gender'];
    fee = json['fee'];
    userProfileFlag = json['userProfileFlag'];
    expertProfileFlag = json['expertProfileFlag'];
    aboutFlag = json['aboutFlag'];
    feeFlag = json['feeFlag'];
    areaOfExpertiseFlag = json['areaOfExpertiseFlag'];
    weeklyAvailableFlag = json['weeklyAvailableFlag'];
    instantCallAvailableFlag = json['instantCallAvailableFlag'];
    locationFlag = json['locationFlag'];
    genderFlag = json['genderFlag'];
    certificateFlag = json['certificateFlag'];
    bankDetailsFlag = json['bankDetailsFlag'];
    phone = json['phone'];
    isLocationVisible = json['isLocationVisible'];
    bankAccountHolderName = json['bankAccountHolderName'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['expertName'] = this.expertName;
    data['mirlId'] = this.mirlId;
    data['location'] = this.location;
    data['about'] = this.about;
    data['gender'] = this.gender;
    data['fee'] = this.fee;
    data['userProfileFlag'] = this.userProfileFlag;
    data['expertProfileFlag'] = this.expertProfileFlag;
    data['aboutFlag'] = this.aboutFlag;
    data['feeFlag'] = this.feeFlag;
    data['areaOfExpertiseFlag'] = this.areaOfExpertiseFlag;
    data['weeklyAvailableFlag'] = this.weeklyAvailableFlag;
    data['instantCallAvailableFlag'] = this.instantCallAvailableFlag;
    data['locationFlag'] = this.locationFlag;
    data['genderFlag'] = this.genderFlag;
    data['certificateFlag'] = this.certificateFlag;
    data['bankDetailsFlag'] = this.bankDetailsFlag;
    data['phone'] = this.phone;
    data['isLocationVisible'] = this.isLocationVisible;
    data['bankAccountHolderName'] = this.bankAccountHolderName;
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    return data;
  }
}
