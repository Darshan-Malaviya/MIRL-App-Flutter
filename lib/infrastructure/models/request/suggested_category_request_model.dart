import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class SuggestedCategoryRequestModel {
  String? userId;
  String? topicName;
  int? categoryId;
  String? categoryName;

  SuggestedCategoryRequestModel({this.userId, this.topicName, this.categoryId, this.categoryName});

  SuggestedCategoryRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    topicName = json['topicName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['topicName'] = this.topicName;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    return data;
  }

  String prepareRequest() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> toNullFreeJson() {
    var json = toJson();
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
