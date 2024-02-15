import 'package:mirl/infrastructure/models/response/login_response_model.dart';

class CertificateRequestModel {
  List<CertificationData>? certificationData;

  CertificateRequestModel({this.certificationData});

  CertificateRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['certificationData'] != null) {
      certificationData = <CertificationData>[];
      json['certificationData'].forEach((v) {
        certificationData?.add(new CertificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.certificationData != null) {
      data['certificationData'] =
          this.certificationData?.map((v) => v.toJsonForRequest()).toList();
    }
    return data;
  }
}
