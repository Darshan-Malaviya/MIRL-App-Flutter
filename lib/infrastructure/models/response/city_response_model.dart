import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/pagination_model.dart';

class CityResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<CityModel>? data;

  CityResponseModel({this.status, this.message, this.pagination, this.data});

  CityResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = <CityModel>[];
      json['data'].forEach((v) {
        data!.add(new CityModel.fromJson(v));
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
      Logger().e("CityResponseModel exception : $e");
      return null;
    }
  }
}

class CityModel {
  int? id;
  int? countryId;
  String? city;

  CityModel({this.id, this.countryId, this.city});

  CityModel.fromJson(Map<String, dynamic> json) {
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
