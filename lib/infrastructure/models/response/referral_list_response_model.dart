// To parse this JSON data, do
//
//     final referralListResponseModel = referralListResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:logger/logger.dart';

ReferralListResponseModel referralListResponseModelFromJson(String str) =>
    ReferralListResponseModel.fromJson(json.decode(str));

String referralListResponseModelToJson(ReferralListResponseModel data) => json.encode(data.toJson());

class ReferralListResponseModel {
  int? status;
  String? message;
  bool? isStatus;
  Data? data;
  Pagination? pagination;

  ReferralListResponseModel({
    this.status,
    this.message,
    this.isStatus,
    this.data,
    this.pagination,
  });

  factory ReferralListResponseModel.fromJson(Map<String, dynamic> json) => ReferralListResponseModel(
        status: json["status"],
        message: json["message"],
        isStatus: json["is_status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "is_status": isStatus,
        "data": data?.toJson(),
      };
  static Future<ReferralListResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return ReferralListResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("GetYourOwnReferralCodeModel exception : $e");
      return null;
    }
  }
}

class Data {
  bool? isAdvanceStatus;
  List<Reflist>? reflist;
  List<TotalAllTime>? totalAllTime;

  Data({
    this.isAdvanceStatus,
    this.reflist,
    this.totalAllTime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isAdvanceStatus: json["is_advance_status"],
        reflist: json["reflist"] == null ? [] : List<Reflist>.from(json["reflist"]!.map((x) => Reflist.fromJson(x))),
        totalAllTime: json["totalAllTime"] == null
            ? []
            : List<TotalAllTime>.from(json["totalAllTime"]!.map((x) => TotalAllTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "is_advance_status": isAdvanceStatus,
        "reflist": reflist == null ? [] : List<dynamic>.from(reflist!.map((x) => x.toJson())),
        "totalAllTime": totalAllTime == null ? [] : List<dynamic>.from(totalAllTime!.map((x) => x.toJson())),
      };
}

class Reflist {
  int? refAmount;
  String? validity;
  User? user;
  double? monthlyReferralEarnings;
  double? lifetimeReferralEarnings;

  Reflist({
    this.refAmount,
    this.validity,
    this.user,
    this.monthlyReferralEarnings,
    this.lifetimeReferralEarnings,
  });

  factory Reflist.fromRawJson(String str) => Reflist.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Reflist.fromJson(Map<String, dynamic> json) => Reflist(
        refAmount: json["ref_amount"],
        validity: json["validity"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        monthlyReferralEarnings: json["monthly_referral_earnings"]?.toDouble(),
        lifetimeReferralEarnings: json["lifetime_referral_earnings"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ref_amount": refAmount,
        "validity": validity,
        "user": user?.toJson(),
        "monthly_referral_earnings": monthlyReferralEarnings,
        "lifetime_referral_earnings": lifetimeReferralEarnings,
      };
}

class User {
  String? mirlId;
  String? email;
  String? userName;
  DateTime? referralDateAt;

  User({
    this.mirlId,
    this.email,
    this.userName,
    this.referralDateAt,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        mirlId: json["mirlId"],
        email: json["email"],
        userName: json["userName"],
        referralDateAt: json["referral_date_at"] == null ? null : DateTime.parse(json["referral_date_at"]),
      );

  Map<String, dynamic> toJson() => {
        "mirlId": mirlId,
        "email": email,
        "userName": userName,
        "referral_date_at": referralDateAt?.toIso8601String(),
      };
}

class Pagination {
  int? page;
  int? perPage;
  int? itemCount;
  int? pageCount;
  int? previousPage;
  int? nextPage;

  Pagination({
    this.page,
    this.perPage,
    this.itemCount,
    this.pageCount,
    this.previousPage,
    this.nextPage,
  });

  factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        perPage: json["perPage"],
        itemCount: json["itemCount"],
        pageCount: json["pageCount"],
        previousPage: json["previousPage"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "perPage": perPage,
        "itemCount": itemCount,
        "pageCount": pageCount,
        "previousPage": previousPage,
        "nextPage": nextPage,
      };
}

class TotalAllTime {
  String? title;
  int? value;

  TotalAllTime({
    this.title,
    this.value,
  });

  factory TotalAllTime.fromJson(Map<String, dynamic> json) => TotalAllTime(
        title: json["title"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
      };
}
