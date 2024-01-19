import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class PaginationRequestModel {
  int? page;
  int? limit;

  PaginationRequestModel({this.page, this.limit});

  PaginationRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    return data;
  }

  String prepareRequest() {
    return jsonEncode(toJson());
  }
}
