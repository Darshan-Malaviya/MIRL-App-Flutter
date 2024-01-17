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

// Future<FormData> toJsonProfilePic() async {
//   FormData formData = FormData.fromMap({
//     "image": await MultipartFile.fromFile(image ?? '', filename: DateTime.now().toIso8601String()),
//   });
//   return formData;
// }
}
