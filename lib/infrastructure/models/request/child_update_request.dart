import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ChildUpdateRequest {
  List<int>? categoryIds;

  ChildUpdateRequest({this.categoryIds});

  ChildUpdateRequest.fromJson(Map<String, dynamic> json) {
    categoryIds = json['categoryIds'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryIds'] = this.categoryIds?.toList();
    return data;
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   if (this.categoryIds != null) {
//     data['categoryIds'] = this.categoryIds?.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}
