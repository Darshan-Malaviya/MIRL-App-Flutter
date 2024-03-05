import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ReportCallRequestModel {
  int? callHistoryId;
  int? reportCallTitleId;
  String? message;

  ReportCallRequestModel({this.callHistoryId, this.reportCallTitleId, this.message});

  ReportCallRequestModel.fromJson(Map<String, dynamic> json) {
    callHistoryId = json['callHistoryId'];
    reportCallTitleId = json['reportCallTitleId'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['callHistoryId'] = this.callHistoryId;
    data['reportCallTitleId'] = this.reportCallTitleId;
    data['message'] = this.message;
    return data;
  }

  String prepareRequest() {
    return jsonEncode(toJson());
  }
}
