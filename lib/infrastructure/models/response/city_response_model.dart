import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/response/category_list_response_model.dart';

class CityResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<cityList>? data;

  CityResponseModel({this.status, this.message, this.pagination, this.data});

  CityResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = <cityList>[];
      json['data'].forEach((v) {
        data!.add(new cityList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<CityResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return CityResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("LoginResponseModel exception : $e");
      return null;
    }
  }
}

class cityList {
  String? id;
  String? countryId;
  String? city;

  cityList({this.id, this.countryId, this.city});

  cityList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['city'] = this.city;
    return data;
  }
}
