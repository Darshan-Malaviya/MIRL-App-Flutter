import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/response/error_model.dart';

class CategoryListResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<CategoryList>? data;
  ErrorModel? err;

  CategoryListResponseModel({this.status, this.message, this.pagination, this.data});

  CategoryListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = <CategoryList>[];
      json['data'].forEach((v) {
        data!.add(new CategoryList.fromJson(v));
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
      Logger().e("LoginResponseModel exception : $e");
      return null;
    }
  }
}

class Pagination {
  int? page;
  int? perPage;
  int? itemCount;
  int? pageCount;
  int? previousPage;
  int? nextPage;

  Pagination({this.page, this.perPage, this.itemCount, this.pageCount, this.previousPage, this.nextPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    itemCount = json['itemCount'];
    pageCount = json['pageCount'];
    previousPage = json['previousPage'];
    nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['perPage'] = this.perPage;
    data['itemCount'] = this.itemCount;
    data['pageCount'] = this.pageCount;
    data['previousPage'] = this.previousPage;
    data['nextPage'] = this.nextPage;
    return data;
  }
}

class CategoryList {
  int? id;
  String? categoryImage;
  String? categoryName;
  String? description;
  int? skillId;
  String? firstCreated;
  String? lastModified;
  String? parentCategory;
  bool expanded = false;

  CategoryList(
      {this.id,
      this.categoryImage,
      this.categoryName,
      this.description,
      this.skillId,
      this.firstCreated,
      this.lastModified,
      this.parentCategory,
      this.expanded = false});

  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryImage = json['categoryImage'];
    categoryName = json['categoryName'];
    description = json['description'];
    skillId = json['skillId'];
    firstCreated = json['firstCreated'];
    lastModified = json['lastModified'];
    parentCategory = json['parentCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryImage'] = this.categoryImage;
    data['categoryName'] = this.categoryName;
    data['description'] = this.description;
    data['skillId'] = this.skillId;
    data['firstCreated'] = this.firstCreated;
    data['lastModified'] = this.lastModified;
    data['parentCategory'] = this.parentCategory;
    return data;
  }
}
