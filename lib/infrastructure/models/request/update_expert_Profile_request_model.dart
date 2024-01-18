import 'package:dio/src/form_data.dart';

class UpdateExpertProfileRequestModel {
  String? userName;
  String? expertName;
  String? mirlId;
  String? location;
  String? about;
  int? gender;
  String? fee;
  String? userProfileFlag;
  bool? expertProfileFlag;
  bool? aboutFlag;
  bool? feeFlag;
  String? areaOfExpertiseFlag;
  String? weeklyAvailableFlag;
  bool? instantCallAvailable;
  bool? locationFlag;
  bool? genderFlag;
  String? certificateFlag;
  bool? bankDetailsFlag;
  String? phone;
  bool? isLocationVisible;
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
      this.instantCallAvailable,
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
    instantCallAvailable = json['instantCallAvailable'];
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

  Future<FormData> toJson() async {
    FormData formData = FormData.fromMap({
      'userName': userName,
      'expertName': expertName,
      'mirlId': mirlId,
      'location': location,
      'about': about,
      'gender': gender,
      'fee': fee,
      'userProfileFlag': userProfileFlag,
      'expertProfileFlag': expertProfileFlag,
      'aboutFlag': aboutFlag,
      'feeFlag': feeFlag,
      'areaOfExpertiseFlag': areaOfExpertiseFlag,
      'weeklyAvailableFlag': weeklyAvailableFlag,
      'instantCallAvailable': instantCallAvailable,
      'locationFlag': locationFlag,
      'genderFlag': genderFlag,
      'certificateFlag': certificateFlag,
      'bankDetailsFlag': bankDetailsFlag,
      'phone': phone,
      'isLocationVisible': isLocationVisible,
      'bankAccountHolderName': bankAccountHolderName,
      'bankName': bankName,
      'accountNumber': accountNumber,
    });
    return formData;
  }

  FormData toJsonGender() {
    FormData formData = FormData.fromMap({
      'genderFlag': genderFlag,
      'gender': gender,
    });
    return formData;
  }

  FormData toJsonFees() {
    FormData formData = FormData.fromMap({
      'feeFlag': feeFlag,
      'fee': fee,
    });
    return formData;
  }

  FormData toJsonInstantCall() {
    FormData formData = FormData.fromMap({
      'instantCallAvailable': instantCallAvailable,
    });
    return formData;
  }

  FormData toJsonProfile() {
    FormData formData = FormData.fromMap({
      'expertProfileFlag': expertProfileFlag,
    });
    return formData;
  }

  FormData toJsonBank() {
    FormData formData = FormData.fromMap({
      'bankDetailsFlag': bankDetailsFlag,
      'bankAccountHolderName': bankAccountHolderName,
      'bankName': bankName,
      'accountNumber': accountNumber,
    });
    return formData;
  }

  FormData toJsonName() {
    FormData formData = FormData.fromMap({
      'expertName': expertName,
    });
    return formData;
  }

  FormData toJsonMirlId() {
    FormData formData = FormData.fromMap({
      'mirlId': mirlId,
    });
    return formData;
  }

  FormData toJsonAbout() {
    FormData formData = FormData.fromMap({
      'aboutFlag': aboutFlag,
      'about': about,
    });
    return formData;
  }
}
