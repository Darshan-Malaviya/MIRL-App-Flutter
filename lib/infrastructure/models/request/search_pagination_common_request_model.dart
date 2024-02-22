import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class SearchPaginationCommonRequestModel {
  String? page;
  String? limit;
  String? search;
  String? categoryId;
  String? countryName;

  SearchPaginationCommonRequestModel({this.page, this.limit, this.search,this.categoryId,this.countryName});

  SearchPaginationCommonRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    search = json['search'];
    categoryId = json['categoryId'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['search'] = this.search;
    data['categoryId'] = this.categoryId;
    data['countryName'] = this.countryName;

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
