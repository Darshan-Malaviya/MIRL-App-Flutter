import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/pagination_model.dart';
import 'package:mirl/infrastructure/models/response/get_single_category_response_model.dart';
import 'package:mirl/infrastructure/models/response/home_data_response_model.dart';

class ExploreExpertCategoryAndUserResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  CategoryAndExpertUser? data;

  ExploreExpertCategoryAndUserResponseModel({this.status, this.message, this.pagination, this.data});

  ExploreExpertCategoryAndUserResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
    data = json['data'] != null ? new CategoryAndExpertUser.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.pagination != null) {
      data['pagination'] = this.pagination?.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }

  static Future<ExploreExpertCategoryAndUserResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return ExploreExpertCategoryAndUserResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("ExploreExpertCategoryAndUserResponseModel exception : $e");
      return null;
    }
  }
}

class CategoryAndExpertUser {
  List<Categories>? category;
  List<ExpertData>? expertUsers;

  CategoryAndExpertUser({this.category, this.expertUsers});

  CategoryAndExpertUser.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Categories>[];
      json['category'].forEach((v) {
        category?.add(new Categories.fromJson(v));
      });
    }
    if (json['expertUsers'] != null) {
      expertUsers = <ExpertData>[];
      json['expertUsers'].forEach((v) {
        expertUsers?.add(new ExpertData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category?.map((v) => v.toJson()).toList();
    }
    if (this.expertUsers != null) {
      data['expertUsers'] = this.expertUsers?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
