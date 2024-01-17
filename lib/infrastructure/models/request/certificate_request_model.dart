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
          this.certificationData?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CertificationData {
  String? title;
  String? url;
  String? description;

  CertificationData({this.title, this.url, this.description});

  CertificationData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['description'] = this.description;
    return data;
  }
}
