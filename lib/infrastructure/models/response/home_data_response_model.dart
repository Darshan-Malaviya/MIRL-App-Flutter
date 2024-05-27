import 'package:logger/logger.dart';

class HomeDataResponseModel {
  int? status;
  String? message;
  HomeData? data;

  HomeDataResponseModel({this.status, this.message, this.data});

  HomeDataResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
  static Future<HomeDataResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return HomeDataResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("HomeDataResponseModel exception : $e");
      return null;
    }
  }
}

class HomeData {
  List<Categories>? categories;
  List<UserFavorites>? userFavorites;
  List<LastConversionList>? lastConversionList;

  HomeData({this.categories, this.userFavorites, this.lastConversionList});

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories?.add(new Categories.fromJson(v));
      });
    }
    if (json['userFavorites'] != null) {
      userFavorites = <UserFavorites>[];
      json['userFavorites'].forEach((v) {
        userFavorites?.add(new UserFavorites.fromJson(v));
      });
    }
    if (json['lastConversionList'] != null) {
      lastConversionList = <LastConversionList>[];
      json['lastConversionList'].forEach((v) {
        lastConversionList?.add(new LastConversionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories?.map((v) => v.toJson()).toList();
    }
    if (this.userFavorites != null) {
      data['userFavorites'] =
          this.userFavorites!.map((v) => v.toJson()).toList();
    }
    if (this.lastConversionList != null) {
      data['lastConversionList'] =
          this.lastConversionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? image;
  String? colorCode;

  Categories({this.id, this.name, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    colorCode = json['colorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['colorCode'] = this.colorCode;
    return data;
  }
}
class UserFavorites {
  int? id;
  String? expertName;
  String? expertProfile;
  bool? isFavorite;

  UserFavorites({this.id, this.expertName, this.expertProfile,this.isFavorite});

  UserFavorites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expertName = json['expertName'];
    expertProfile = json['expertProfile'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['expertName'] = this.expertName;
    data['expertProfile'] = this.expertProfile;
    return data;
  }
}

class LastConversionList {
  int? id;
  String? expertName;
  String? expertProfile;

  LastConversionList({this.id, this.expertName, this.expertProfile});

  LastConversionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expertName = json['expertName'];
    expertProfile = json['expertProfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expertName'] = this.expertName;
    data['expertProfile'] = this.expertProfile;
    return data;
  }
}


