import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/common/pagination_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';

class RatingAndReviewResponseModel {
  int? status;
  String? message;
  Pagination? pagination;
  ReviewAndRatingData? data;

  RatingAndReviewResponseModel({this.status, this.message, this.pagination, this.data});

  RatingAndReviewResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
    data = json['data'] != null ? new ReviewAndRatingData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  static Future<RatingAndReviewResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return RatingAndReviewResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("RateAndReviewResponseModel exception : $e");
      return null;
    }
  }
}

class ReviewAndRatingData {
  int? overAllRating;
  List<RatingCriteria>? ratingCriteria;
  List<ExpertReviews>? expertReviews;

  ReviewAndRatingData({this.overAllRating, this.ratingCriteria, this.expertReviews});

  ReviewAndRatingData.fromJson(Map<String, dynamic> json) {
    overAllRating = json['overAllRating'];
    if (json['ratingCriteria'] != null) {
      ratingCriteria = <RatingCriteria>[];
      json['ratingCriteria'].forEach((v) {
        ratingCriteria?.add(new RatingCriteria.fromJson(v));
      });
    }
    if (json['expertReviews'] != null) {
      expertReviews = <ExpertReviews>[];
      json['expertReviews'].forEach((v) {
        expertReviews?.add(new ExpertReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['overAllRating'] = this.overAllRating;
    if (this.ratingCriteria != null) {
      data['ratingCriteria'] = this.ratingCriteria!.map((v) => v.toJson()).toList();
    }
    if (this.expertReviews != null) {
      data['expertReviews'] = this.expertReviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
