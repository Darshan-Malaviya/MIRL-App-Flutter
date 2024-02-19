import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/pagination_model.dart';

class CountryResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<CountryModel>? data;

  CountryResponseModel({this.status, this.message, this.pagination, this.data});

  CountryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = <CountryModel>[];
      json['data'].forEach((v) {
        data!.add(new CountryModel.fromJson(v));
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

  static Future<CountryResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return CountryResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("CountryResponseModel exception : $e");
      return null;
    }
  }
}

class CountryModel {
  int? id;
  String? country;

  CountryModel({this.id, this.country});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country'] = this.country;
    return data;
  }
}
