import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart';
import 'package:http_parser/http_parser.dart';

class UpdateExpertProfileRequestModel {
  String? userName;
  String? expertName;
  String? mirlId;
  String? location;
  String? about;
  int? gender;
  String? fee;
  String? userProfile;
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
  String? city;
  String? country;

  UpdateExpertProfileRequestModel(
      {this.userName,
      this.expertName,
      this.mirlId,
      this.location,
      this.about,
      this.gender,
      this.fee,
      this.userProfile,
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
      this.accountNumber,
      this.city,
      this.country});

  UpdateExpertProfileRequestModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    expertName = json['expertName'];
    mirlId = json['mirlId'];
    location = json['location'];
    about = json['about'];
    gender = json['gender'];
    fee = json['fee'];
    userProfile = json['userProfile'];
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
    city = json['city'];
    accountNumber = json['accountNumber'];
    country = json['country'];
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
      'userProfile': userProfile,
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
      'city': city,
      'country': country
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

  Future<FormData> toJsonProfile() async {
    Map<String, dynamic> request = {};
    request['expertProfile'] = await MultipartFile.fromFile(
      userProfile ?? '',
      filename: DateTime.now().toIso8601String(),
      contentType: MediaType('image', request['expertProfile']?.split('.').last ?? 'jpg'),
    );
    FormData formData = FormData.fromMap(request);
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

  FormData toJsonYourLocation() {
    FormData formData = FormData.fromMap({
      'locationFlag': locationFlag,
      'location': location,
      'isLocationVisible': isLocationVisible,
      'country': country,
      'city': city,
    });
    return formData;
  }
}
