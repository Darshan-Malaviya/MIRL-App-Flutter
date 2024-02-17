import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class UnBlockUserResponseModel {
  int? status;
  String? message;
  CommonModel? err;


  UnBlockUserResponseModel({this.status, this.message});

  UnBlockUserResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    err = json['err'] != null ? CommonModel.fromJson(json['err']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
  static Future<UnBlockUserResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return UnBlockUserResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("UnBlockUserResponseModel exception : $e");
      return null;
    }
  }
}
