import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class SlotsRequestModel {
  String? date;
  int? expertId;
  String? duration;

  SlotsRequestModel({this.date, this.expertId, this.duration});

  SlotsRequestModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    expertId = json['expertId'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['expertId'] = this.expertId;
    data['duration'] = this.duration;

    return data;
  }

  String prepareRequest() {
    return jsonEncode(toJson());
  }
}
