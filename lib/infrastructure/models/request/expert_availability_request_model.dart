import 'dart:convert';

class ExpertAvailabilityRequestModel {
  String? scheduleType;
  List<WorkDays>? workDays;

  ExpertAvailabilityRequestModel({this.scheduleType, this.workDays});

  ExpertAvailabilityRequestModel.fromJson(Map<String, dynamic> json) {
    scheduleType = json['scheduleType'];
    if (json['workDays'] != null) {
      workDays = <WorkDays>[];
      json['workDays'].forEach((v) {
        workDays?.add(new WorkDays.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheduleType'] = this.scheduleType;
    if (this.workDays != null) {
      data['workDays'] = this.workDays?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String get prepareRequest => jsonEncode(toJson());
}

class WorkDays {
  String? dayOfWeek;
  String? startTime;
  String? endTime;
  int? isAvailable;

  WorkDays({this.dayOfWeek, this.startTime, this.endTime, this.isAvailable});

  WorkDays.fromJson(Map<String, dynamic> json) {
    dayOfWeek = json['dayOfWeek'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayOfWeek'] = this.dayOfWeek;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['isAvailable'] = this.isAvailable;
    return data;
  }
}
