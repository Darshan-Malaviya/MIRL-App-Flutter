class CommonModel {
  int? statusCode;
  var message;
  String? error;

  CommonModel({this.statusCode, this.message, this.error});

  CommonModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['message'] is List<dynamic>) {
      message = json['message'].cast<String>();
    } else {
      message = [json['message']];
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }

  static Future<CommonModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return CommonModel.fromJson(json ?? {});
    } catch (e) {
      print('CommonModel parseInfo exception : $e');
      return null;
    }
  }
}
