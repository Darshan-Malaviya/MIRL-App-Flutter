import 'package:mirl/infrastructure/models/common/expert_data_model.dart';
import 'package:mirl/infrastructure/models/common/pagination_model.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';

class GetSingleCategoryResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  SingleCategoryData? data;

  GetSingleCategoryResponseModel({this.status, this.message, this.pagination, this.data});

  GetSingleCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
    data = json['data'] != null ? new SingleCategoryData.fromJson(json['data']) : null;
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

  static Future<GetSingleCategoryResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return GetSingleCategoryResponseModel.fromJson(json ?? {});
    } catch (e) {
      print('GetSingleCategoryResponseModel parseInfo exception : $e');
      return null;
    }
  }
}

class SingleCategoryData {
  CategoryData? categoryData;
  List<ExpertData>? expertData;

  SingleCategoryData({this.categoryData, this.expertData});

  SingleCategoryData.fromJson(Map<String, dynamic> json) {
    categoryData = json['category'] != null ? new CategoryData.fromJson(json['category']) : null;
    if (json['expertData'] != null) {
      expertData = <ExpertData>[];
      json['expertData'].forEach((v) {
        expertData?.add(new ExpertData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryData != null) {
      data['category'] = this.categoryData?.toJson();
    }
    if (this.expertData != null) {
      data['expertData'] = this.expertData?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryData {
  int? id;
  String? image;
  String? name;
  String? description;
  List<Topic>? topic;

  CategoryData({this.id, this.image, this.name, this.description, this.topic});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    if (json['topic'] != null) {
      topic = <Topic>[];
      json['topic'].forEach((v) {
        topic?.add(new Topic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.topic != null) {
      data['topic'] = this.topic?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpertCategory {
  int? id;
  String? name;
  String? colorCode;

  ExpertCategory({this.id, this.name, this.colorCode});

  ExpertCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    colorCode = json['colorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['colorCode'] = this.colorCode;
    return data;
  }
}
