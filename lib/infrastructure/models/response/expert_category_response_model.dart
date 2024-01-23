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
  String? parentName;
  int? badgecount;
  String? categoryImage;
  List<Child>? child;
  bool? isVisible;
  bool? selectAllCategory;

  CategoryListData({this.id, this.parentName,this.isVisible, this.badgecount, this.categoryImage, this.child,this.selectAllCategory});

  CategoryListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentName = json['parentName'];
    badgecount = json['badgecount'];
    categoryImage = json['categoryImage'];
    isVisible = false;
    selectAllCategory = false;
    if (json['child'] != null) {
      child = <Child>[];
      json['child'].forEach((v) {
        child!.add(new Child.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parentName'] = this.parentName;
    data['badgecount'] = this.badgecount;
    data['categoryImage'] = this.categoryImage;
    if (this.child != null) {
      data['child'] = this.child!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Child {
  int? id;
  String? categoryName;
  bool? isSelected;

  Child({this.id, this.categoryName, this.isSelected});

  Child.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
