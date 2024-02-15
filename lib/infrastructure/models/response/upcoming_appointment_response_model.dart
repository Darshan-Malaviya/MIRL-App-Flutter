import 'package:logger/logger.dart';

class UpcomingAppointmentResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  upcomingAppointmentData? data;

  UpcomingAppointmentResponseModel(
      {this.status, this.message, this.pagination, this.data});

  UpcomingAppointmentResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    data = json['data'] != null ? new upcomingAppointmentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.pagination != null) {
      data['pagination'] = this.pagination?.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }

  static Future<UpcomingAppointmentResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return UpcomingAppointmentResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("UpcomingAppointmentResponseModel exception : $e");
      return null;
    }
  }
}

class Pagination {
  int? page;
  int? perPage;
  int? itemCount;
  int? pageCount;
  int? previousPage;
  int? nextPage;

  Pagination(
      {this.page,
        this.perPage,
        this.itemCount,
        this.pageCount,
        this.previousPage,
        this.nextPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    itemCount = json['itemCount'];
    pageCount = json['pageCount'];
    previousPage = json['previousPage'];
    nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['perPage'] = this.perPage;
    data['itemCount'] = this.itemCount;
    data['pageCount'] = this.pageCount;
    data['previousPage'] = this.previousPage;
    data['nextPage'] = this.nextPage;
    return data;
  }
}

class upcomingAppointmentData {
  List<DateLists>? dateLists;
  List<GetUpcomingAppointment>? getUpcomingAppointment;

  upcomingAppointmentData({this.dateLists, this.getUpcomingAppointment});

  upcomingAppointmentData.fromJson(Map<String, dynamic> json) {
    if (json['dateLists'] != null) {
      dateLists = <DateLists>[];
      json['dateLists'].forEach((v) {
        dateLists!.add(new DateLists.fromJson(v));
      });
    }
    if (json['getUpcomingAppointment'] != null) {
      getUpcomingAppointment = <GetUpcomingAppointment>[];
      json['getUpcomingAppointment'].forEach((v) {
        getUpcomingAppointment!.add(new GetUpcomingAppointment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dateLists != null) {
      data['dateLists'] = this.dateLists!.map((v) => v.toJson()).toList();
    }
    if (this.getUpcomingAppointment != null) {
      data['getUpcomingAppointment'] =
          this.getUpcomingAppointment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DateLists {
  String? date;

  DateLists({this.date});

  DateLists.fromJson(Map<String, dynamic> json) {
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    return data;
  }
}

class GetUpcomingAppointment {
  int? id;
  int? userId;
  int? expertId;
  String? duration;
  String? startTime;
  String? endTime;
  String? date;
  DetailData? detail;

  GetUpcomingAppointment(
      {this.id,
        this.userId,
        this.expertId,
        this.duration,
        this.startTime,
        this.endTime,
        this.date,
        this.detail});

  GetUpcomingAppointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    expertId = json['expertId'];
    duration = json['duration'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    date = json['date'];
    detail =
    json['detail'] != null ? new DetailData.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['expertId'] = this.expertId;
    data['duration'] = this.duration;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['date'] = this.date;
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    return data;
  }
}

class DetailData {
  int? id;
  String? name;
  String? profileImage;

  DetailData({this.id, this.name, this.profileImage});

  DetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
