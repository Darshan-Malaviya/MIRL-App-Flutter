import 'package:logger/logger.dart';

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
  List<CategoriesSearch>? categories;
  List<Users>? users;
  List<Topics>? topics;

  HomeSearchData({this.categories, this.users, this.topics});

  HomeSearchData.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <CategoriesSearch>[];
      json['categories'].forEach((v) {
        categories!.add(CategoriesSearch.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoriesSearch {
  int? id;
  String? name;
  String? image;

  CategoriesSearch({this.id, this.name, this.image});

  CategoriesSearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Users {
  int? id;
  String? expertName;
  String? expertProfile;
  List<CategoriesSearch>? categoris;

  Users({this.id, this.expertName, this.expertProfile, this.categoris});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expertName = json['expertName'];
    expertProfile = json['expertProfile'];
    if (json['categoris'] != null) {
      categoris = <CategoriesSearch>[];
      json['categoris'].forEach((v) {
        categoris!.add(CategoriesSearch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['expertName'] = this.expertName;
    data['expertProfile'] = this.expertProfile;
    if (this.categoris != null) {
      data['categoris'] = this.categoris!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topics {
  int? id;
  String? name;
  int? categoryId;

  Topics({this.id, this.name, this.categoryId});

  Topics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.categoryId;
    return data;
  }
}
