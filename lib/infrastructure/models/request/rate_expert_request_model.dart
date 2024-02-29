
class RateExpertRequestModel {
  int? callHistoryId;
  int? rating;
  String? review;
  List<RatingCriteria>? ratingCriteria;

  RateExpertRequestModel({this.callHistoryId, this.rating, this.review, this.ratingCriteria});

  RateExpertRequestModel.fromJson(Map<String, dynamic> json) {
    callHistoryId = json['callHistoryId'];
    rating = json['rating'];
    review = json['review'];
    if (json['ratingCriteria'] != null) {
      ratingCriteria = <RatingCriteria>[];
      json['ratingCriteria'].forEach((v) {
        ratingCriteria!.add(new RatingCriteria.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['callHistoryId'] = this.callHistoryId;
    data['rating'] = this.rating;
    data['review'] = this.review;
    if (this.ratingCriteria != null) {
      data['ratingCriteria'] = this.ratingCriteria!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RatingCriteria {
  int? ratingCategory;
  int? rating;

  RatingCriteria({this.ratingCategory, this.rating});

  RatingCriteria.fromJson(Map<String, dynamic> json) {
    ratingCategory = json['ratingCategory'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ratingCategory'] = this.ratingCategory;
    data['rating'] = this.rating;
    return data;
  }
}
