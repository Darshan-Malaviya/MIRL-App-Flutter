class ErrorModel {
  int? statusCode;
  String? message;
  String? error;

  ErrorModel({this.statusCode, this.message, this.error});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['error'] = error;
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
