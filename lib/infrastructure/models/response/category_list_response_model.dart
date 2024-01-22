import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/category_model.dart';
import 'package:mirl/infrastructure/models/common/common_model.dart';
import 'package:mirl/infrastructure/models/response/pagination_model/pagination_response_model.dart';

class CategoryListResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<CategoryModel>? data;
  CommonModel? err;

  CategoryListResponseModel({this.status, this.message, this.pagination, this.data});

  CategoryListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = <CategoryModel>[];
      json['data'].forEach((v) {
        data!.add(new CategoryModel.fromJson(v));
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

  static Future<CategoryListResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return CategoryListResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("CategoryListResponseModel exception : $e");
      return null;
    }
  }
}



