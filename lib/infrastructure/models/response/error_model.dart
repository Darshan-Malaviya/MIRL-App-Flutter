class ErrorModel {
  int? statusCode;
  List<String>? message;
  String? error;

  ErrorModel({this.statusCode, this.message, this.error});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'].cast<String>();
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }

  static Future<ErrorModel?> parseInfo(Map<String, dynamic> json) async {
    try {
      return ErrorModel.fromJson(json);
    } catch (e) {
      print('ErrorModel parseInfo exception : $e');
      return null;
    }
  }
}
