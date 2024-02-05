class ExpertDataRequestModel {
  String? search;
  int? gender;
  int? instantCallAvailable;
  String? country;
  int? minFee;
  int? maxFee;
  int? categoryId;

  ExpertDataRequestModel(
      {this.search, this.gender, this.instantCallAvailable, this.country, this.minFee, this.maxFee, this.categoryId});

  ExpertDataRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['search'] != null) {
      search = json['search'];
    }
    gender = json['gender'];
    instantCallAvailable = json['instantCallAvailable'];
    country = json['country'];
    minFee = json['minFee'];
    maxFee = json['maxFee'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.search != null) {
      data['search'] = this.search;
    }
    data['gender'] = this.gender;

    data['instantCallAvailable'] = this.instantCallAvailable;
    data['country'] = this.country;
    data['minFee'] = this.minFee;
    data['maxFee'] = this.maxFee;
    data['categoryId'] = this.categoryId;
    return data;
  }
  Map<String, dynamic> toNullFreeJson() {
    var json = toJson();
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
