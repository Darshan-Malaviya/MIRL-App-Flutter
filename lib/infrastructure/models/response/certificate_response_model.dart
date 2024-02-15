import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';

class CertificateResponseModel {
  int? status;
  String? message;
  List<CertificationData>? data;

  CertificateResponseModel({this.status, this.message, this.data});

  CertificateResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CertificationData>[];
      json['data'].forEach((v) {
        data?.add(new CertificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<CertificateResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return CertificateResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("CertificateResponseModel exception : $e");
      return null;
    }
  }
}
