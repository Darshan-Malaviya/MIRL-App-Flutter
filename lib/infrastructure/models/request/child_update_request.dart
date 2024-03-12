import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ChildUpdateRequestModel {
  List<CategoryIds>? categoryIds;

  ChildUpdateRequestModel({this.categoryIds});

  ChildUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['categoryIds'] != null) {
      categoryIds = <CategoryIds>[];
      json['categoryIds'].forEach((v) {
        categoryIds!.add(new CategoryIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryIds != null) {
      data['categoryIds'] = this.categoryIds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  String prepareRequest() {
    return jsonEncode(toJson());
  }
}

class CategoryIds {
  int? parentId;
  List<int>? childIds;

  CategoryIds({this.parentId, this.childIds});

  CategoryIds.fromJson(Map<String, dynamic> json) {
    parentId = json['parentId'];
    childIds = json['childIds'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parentId'] = this.parentId;
    data['childIds'] = this.childIds?.toSet().toList();
    return data;
  }
}
