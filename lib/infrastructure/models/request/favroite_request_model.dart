import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class FavoriteRequestModel {
  int? userFavoriteId;

  FavoriteRequestModel({this.userFavoriteId});

  FavoriteRequestModel.fromJson(Map<String, dynamic> json) {
    userFavoriteId = json['userFavoriteId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userFavoriteId'] = this.userFavoriteId;
    return data;
  }
  String prepareRequest() {
    return jsonEncode(toJson());
  }
}
