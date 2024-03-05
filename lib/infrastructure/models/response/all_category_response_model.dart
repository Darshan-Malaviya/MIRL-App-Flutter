import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/category_id_name_common_model.dart';
import 'package:mirl/infrastructure/models/common/pagination_model.dart';

class AllCategoryListResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<CategoryIdNameCommonModel>? data;

  AllCategoryListResponseModel({this.status, this.message, this.pagination, this.data});

  AllCategoryListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = <CategoryIdNameCommonModel>[];
      json['data'].forEach((v) {
        data?.add(CategoryIdNameCommonModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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

  static Future<AllCategoryListResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return AllCategoryListResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("AllCategoryListResponseModel exception : $e");
      return null;
    }
  }
}
