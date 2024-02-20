import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class UserReportRequestModel {
  int? reportToId;
  int? reportListId;

  UserReportRequestModel({this.reportToId, this.reportListId});

  UserReportRequestModel.fromJson(Map<String, dynamic> json) {
    reportToId = json['reportToId'];
    reportListId = json['reportListId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reportToId'] = this.reportToId;
    data['reportListId'] = this.reportListId;
    return data;
  }

  String prepareRequest() {
    return jsonEncode(toJson());
  }
}
