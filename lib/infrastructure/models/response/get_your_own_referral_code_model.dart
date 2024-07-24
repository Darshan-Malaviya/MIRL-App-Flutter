// To parse this JSON data, do
//
//     final getYourOwnReferralCodeModel = getYourOwnReferralCodeModelFromJson(jsonString);

import 'dart:convert';

import 'package:logger/logger.dart';

GetYourOwnReferralCodeModel getYourOwnReferralCodeModelFromJson(String str) => GetYourOwnReferralCodeModel.fromJson(json.decode(str));

String getYourOwnReferralCodeModelToJson(GetYourOwnReferralCodeModel data) => json.encode(data.toJson());

class GetYourOwnReferralCodeModel {
  int? status;
  bool? isStatus;
  String? message;
  Data? data;

  GetYourOwnReferralCodeModel({
    this.status,
    this.isStatus,
    this.message,
    this.data,
  });

  factory GetYourOwnReferralCodeModel.fromJson(Map<String, dynamic> json) => GetYourOwnReferralCodeModel(
    status: json["status"],
    isStatus: json["is_status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "is_status": isStatus,
    "message": message,
    "data": data?.toJson(),
  };
  static Future<GetYourOwnReferralCodeModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return GetYourOwnReferralCodeModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("GetYourOwnReferralCodeModel exception : $e");
      return null;
    }
  }
}

class Data {
  int? id;
  String? email;
  String? role;
  int? iat;
  String? refCode;
  DateTime? refActivateDate;

  Data({
    this.id,
    this.email,
    this.role,
    this.iat,
    this.refCode,
    this.refActivateDate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    email: json["email"],
    role: json["role"],
    iat: json["iat"],
    refCode: json["ref_code"],
    refActivateDate: json["ref_activate_date"] == null ? null : DateTime.parse(json["ref_activate_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "role": role,
    "iat": iat,
    "ref_code": refCode,
    "ref_activate_date": refActivateDate?.toIso8601String(),
  };
}
