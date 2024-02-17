import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UpdateExpertProfileRequestModel {
  String? userName;
  String? expertName;
  String? mirlId;
  String? location;
  String? about;
  String? gender;
  String? fee;
  String? userProfile;
  String? expertProfile;
  bool? instantCallAvailable;
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
      this.expertProfile,
      this.instantCallAvailable,
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
    expertProfile = json['expertProfile'];
    instantCallAvailable = json['instantCallAvailable'];
    phone = json['phone'];
    isLocationVisible = json['isLocationVisible'];
    bankAccountHolderName = json['bankAccountHolderName'];
    bankName = json['bankName'];
    city = json['city'];
    accountNumber = json['accountNumber'];
    country = json['country'];
  }

  FormData toJsonGender() {
    FormData formData = FormData.fromMap({
      'gender': gender,
    });
    return formData;
  }

  FormData toJsonFees() {
    FormData formData = FormData.fromMap({
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
      expertProfile ?? '',
      filename: DateTime.now().toIso8601String(),
      contentType: MediaType('image', expertProfile?.split('.').last ?? 'jpg'),
    );
    FormData formData = FormData.fromMap(request);
    return formData;
  }

  FormData toJsonBank() {
    FormData formData = FormData.fromMap({
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
      'about': about,
    });
    return formData;
  }

  FormData toJsonYourLocation() {
    FormData formData = FormData.fromMap({
      'isLocationVisible': isLocationVisible,
      'country': country,
      'city': city,
    });
    return formData;
  }
}
