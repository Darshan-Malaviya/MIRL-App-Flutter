// To parse this JSON data, do
//
//     final submitReferralCodeModel = submitReferralCodeModelFromJson(jsonString);

import 'dart:convert';

import 'package:logger/logger.dart';

SubmitReferralCodeModel submitReferralCodeModelFromJson(String str) => SubmitReferralCodeModel.fromJson(json.decode(str));

String submitReferralCodeModelToJson(SubmitReferralCodeModel data) => json.encode(data.toJson());

class SubmitReferralCodeModel {
  int? status;
  String? message;
  bool? isStatus;
  Data? data;

  SubmitReferralCodeModel({
    this.status,
    this.message,
    this.isStatus,
    this.data,
  });

  factory SubmitReferralCodeModel.fromJson(Map<String, dynamic> json) => SubmitReferralCodeModel(
    status: json["status"],
    message: json["message"],
    isStatus: json["is_status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "is_status": isStatus,
    "data": data?.toJson(),
  };

  static Future<SubmitReferralCodeModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return SubmitReferralCodeModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("SubmitReferralCodeModel exception : $e");
      return null;
    }
  }
}

class Data {
  String? refCode;
  DateTime? refActivateDate;
  int? id;
  String? email;
  String? role;
  int? iat;

  Data({
    this.refCode,
    this.refActivateDate,
    this.id,
    this.email,
    this.role,
    this.iat,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    refCode: json["ref_code"],
    refActivateDate: json["ref_activate_date"] == null ? null : DateTime.parse(json["ref_activate_date"]),
    id: json["id"],
    email: json["email"],
    role: json["role"],
    iat: json["iat"],
  );

  Map<String, dynamic> toJson() => {
    "ref_code": refCode,
    "ref_activate_date": refActivateDate?.toIso8601String(),
    "id": id,
    "email": email,
    "role": role,
    "iat": iat,
  };
}
