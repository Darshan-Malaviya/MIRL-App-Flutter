import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/infrastructure/models/response/home_data_response_model.dart';

class HomeSearchResponseModel {
  int? status;
  String? message;
  HomeSearchData? data;

  HomeSearchResponseModel({this.status, this.message, this.data});

  HomeSearchResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? HomeSearchData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  static Future<HomeSearchResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return HomeSearchResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("HomeSearchResponseModel exception : $e");
      return null;
    }
  }
}

class HomeSearchData {
  List<Categories>? categories;
  List<Users>? users;
  List<Topic>? topics;

  HomeSearchData({this.categories, this.users, this.topics});

  HomeSearchData.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
    if (json['topics'] != null) {
      topics = <Topic>[];
      json['topics'].forEach((v) {
        topics?.add(Topic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories?.map((v) => v.toJson()).toList();
    }
    if (this.users != null) {
      data['users'] = this.users?.map((v) => v.toJson()).toList();
    }
    if (this.topics != null) {
      data['topics'] = this.topics?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? expertName;
  String? expertProfile;
  List<Categories>? categories;

  Users({this.id, this.expertName, this.expertProfile, this.categories});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expertName = json['expertName'];
    expertProfile = json['expertProfile'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['expertName'] = this.expertName;
    data['expertProfile'] = this.expertProfile;
    if (this.categories != null) {
      data['categories'] = this.categories?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
