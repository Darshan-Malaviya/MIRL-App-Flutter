import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/response/pagination_model/pagination_response_model.dart';

class ExpertCategoryResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<CategoryListData>? data;

  ExpertCategoryResponseModel({this.status, this.message, this.pagination, this.data});

  ExpertCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = <CategoryListData>[];
      json['data'].forEach((v) {
        data!.add(new CategoryListData.fromJson(v));
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

  static Future<ExpertCategoryResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return ExpertCategoryResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("ExpertCategoryResponseModel exception : $e");
      return null;
    }
  }
}

class CategoryListData {
  int? id;
  String? name;
  String? image;
  String? description;
  List<Topic>? topic;
  int? badgeCount;
  bool? isVisible;
  bool? selectAllCategory;

  CategoryListData({this.id, this.name, this.image, this.description, this.topic, this.badgeCount, this.isVisible, this.selectAllCategory});

  CategoryListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    if (json['topic'] != null) {
      topic = <Topic>[];
      json['topic'].forEach((v) {
        topic!.add(new Topic.fromJson(v));
      });
    }
    badgeCount = json['badgeCount'];
    isVisible = false;
    selectAllCategory = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    if (this.topic != null) {
      data['topic'] = this.topic!.map((v) => v.toJson()).toList();
    }
    data['badgeCount'] = this.badgeCount;
    return data;
  }
}

class Topic {
  int? id;
  String? name;
  int? categoryId;
  bool? isSelected;

  Topic({this.id, this.name, this.categoryId, this.isSelected});

  Topic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['categoryId'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['categoryId'] = this.categoryId;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
