import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class SlotsRequestModel {
  String? date;
  int? expertId;
  int? duration;
  String? startDate;
  String? endDate;

  SlotsRequestModel({this.date, this.expertId, this.duration, this.startDate, this.endDate});

  SlotsRequestModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    expertId = json['expertId'];
    duration = json['duration'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['expertId'] = this.expertId;
    data['duration'] = this.duration;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;

    return data;
  }

  String prepareRequest() => jsonEncode(toJson());
}
