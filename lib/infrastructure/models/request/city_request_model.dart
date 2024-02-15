class CityRequestModel {
  String? page;
  String? limit;
  String? countryId;
  String? order;
  String? search;

  CityRequestModel({this.page, this.limit, this.countryId, this.order, this.search});

  CityRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    countryId = json['countryId'];
    order = json['order'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['countryId'] = this.countryId;
    data['order'] = this.order;
    data['search'] = this.search;
    return data;
  }
}
