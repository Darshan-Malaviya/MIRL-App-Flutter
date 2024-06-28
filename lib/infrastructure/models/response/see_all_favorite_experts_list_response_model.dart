import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/expert_data_model.dart';
import 'package:mirl/infrastructure/models/common/pagination_model.dart';
class SeeAllFavoriteExpertsListResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<ExpertData>? data;

  SeeAllFavoriteExpertsListResponseModel(
      {this.status, this.message, this.pagination, this.data});

  SeeAllFavoriteExpertsListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <ExpertData>[];
      json['data'].forEach((v) {
        data!.add(new ExpertData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  static Future<SeeAllFavoriteExpertsListResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return SeeAllFavoriteExpertsListResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("SeeAllFavoriteExpertsListResponseModel exception : $e");
      return null;
    }
  }
}


// class SeeAllFavoriteExpertsListResponseModel {
//   int? status;
//   String? message;
//   Pagination? pagination;
//   FavoriteExperts? data;
//
//   SeeAllFavoriteExpertsListResponseModel(
//       {this.status, this.message, this.pagination, this.data});
//
//   SeeAllFavoriteExpertsListResponseModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     pagination = json['pagination'] != null
//         ? new Pagination.fromJson(json['pagination'])
//         : null;
//     data = json['data'] != null ? new FavoriteExperts.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.pagination != null) {
//       data['pagination'] = this.pagination!.toJson();
//     }
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
//   static Future<SeeAllFavoriteExpertsListResponseModel?> parseInfo(Map<String, dynamic>? json) async {
//     try {
//       return SeeAllFavoriteExpertsListResponseModel.fromJson(json ?? {});
//     } catch (e) {
//       Logger().e("SeeAllFavoriteExpertsListResponseModel exception : $e");
//       return null;
//     }
//   }
// }
//
// class FavoriteExperts {
//   List<ExpertData>? expertData;
//
//   FavoriteExperts({this.expertData});
//
//   FavoriteExperts.fromJson(Map<String, dynamic> json) {
//     if (json['expertData'] != null) {
//       expertData = <ExpertData>[];
//       json['expertData'].forEach((v) {
//         expertData!.add(new ExpertData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.expertData != null) {
//       data['expertData'] = this.expertData!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
