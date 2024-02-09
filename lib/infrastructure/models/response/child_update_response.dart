import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';

class ChildUpdateResponseModel {
  int? status;
  String? message;
  List<AreasOfExpertise>? data;

  ChildUpdateResponseModel({this.status, this.message, this.data});

  ChildUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AreasOfExpertise>[];
      json['data'].forEach((v) {
        data!.add(AreasOfExpertise.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
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
