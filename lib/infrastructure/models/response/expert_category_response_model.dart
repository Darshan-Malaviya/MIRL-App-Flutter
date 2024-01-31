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
      data['data'] = this.data?.map((v) => v.toJson()).toList();
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
  String? parentName;
  int? badgecount;
  String? image;
  List<TopicData>? child;
  bool? isVisible;
  bool? selectAllCategory;

  CategoryListData({this.id, this.parentName, this.isVisible, this.badgecount, this.image, this.child, this.selectAllCategory});

  CategoryListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentName = json['parentName'];
    badgecount = json['badgecount'];
    image = json['image'];
    isVisible = false;
    selectAllCategory = false;
    if (json['child'] != null) {
      child = <TopicData>[];
      json['child'].forEach((v) {
        child?.add(new TopicData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parentName'] = this.parentName;
    data['badgecount'] = this.badgecount;
    data['image'] = this.image;
    if (this.child != null) {
      data['child'] = this.child!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopicData {
  int? id;
  String? name;
  bool? isSelected;

  TopicData({this.id, this.name, this.isSelected});

  TopicData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
