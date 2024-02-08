
class ExpertDataRequestModel {
  String? userId;
  String? page;
  String? limit;
  String? feeOrder;
  String? reviewOrder;
  String? experienceOder;
  String? search;
  String? gender;
  String? instantCallAvailable;
  String? country;
  String? city;
  String? minFee;
  String? maxFee;
  String? topicIds;
  String? categoryId;


  ExpertDataRequestModel(
      {
        this.userId,
      this.page,
        this.limit,
        this.feeOrder,
        this.reviewOrder,
        this.experienceOder,
        this.search,
        this.gender,
        this.instantCallAvailable,
        this.country,
        this.city,
        this.minFee,
        this.maxFee,
        this.topicIds,
      this.categoryId});

  ExpertDataRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['search'] != null) {
      search = json['search'];
    }
    if (json['limit'] != null) {
      limit = json['limit'];
    }
    if (json['userId'] != null) {
      userId = json['userId'];
    }
    reviewOrder = json['reviewOrder'];
    experienceOder = json['experienceOder'];
    search = json['search'];
    gender = json['gender'];
    instantCallAvailable = json['instantCallAvailable'];
    country = json['country'];
    city = json['city'];
    minFee = json['minFee'];
    maxFee = json['maxFee'];
    topicIds = json['topicIds'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.search != null) {
      data['search'] = this.search;
    }
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['userId'] = this.userId;
    data['feeOrder'] = this.feeOrder;
    data['reviewOrder'] = this.reviewOrder;
    data['experienceOder'] = this.experienceOder;
    data['search'] = this.search;
    data['gender'] = this.gender;
    data['instantCallAvailable'] = this.instantCallAvailable;
    data['country'] = this.country;
    data['city'] = this.city;
    data['minFee'] = this.minFee;
    data['maxFee'] = this.maxFee;
    data['topicIds'] = this.topicIds;
    data['categoryId'] = this.categoryId;
    return data;
  }

  Map<String, dynamic> toNullFreeJson() {
    var json = toJson();
    json.removeWhere((key, value) => value == null);
    return json;
  }

}

