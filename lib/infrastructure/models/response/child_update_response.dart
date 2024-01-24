import 'package:logger/logger.dart';

class ChildUpdateResponseModel {
  int? status;
  String? message;

  ChildUpdateResponseModel({this.status, this.message});

  ChildUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }

  static Future<ChildUpdateResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return ChildUpdateResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("ChildUpdateResponseModel exception : $e");
      return null;
    }
  }
}
