import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class SortByReviewRequestModel {
  String? firstCreatedOrder;
  String? ratingOrder;
  String? page;
  String? limit;

  SortByReviewRequestModel(
      {this.firstCreatedOrder, this.ratingOrder, this.page, this.limit});

  SortByReviewRequestModel.fromJson(Map<String, dynamic> json) {
    firstCreatedOrder = json['firstCreatedOrder'];
    ratingOrder = json['ratingOrder'];
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstCreatedOrder'] = this.firstCreatedOrder;
    data['ratingOrder'] = this.ratingOrder;
    data['page'] = this.page;
    data['limit'] = this.limit;
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
