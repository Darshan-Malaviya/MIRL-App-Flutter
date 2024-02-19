class CityRequestModel {
  String? page;
  String? limit;
  int? countryName;
  String? order;
  String? search;

  CityRequestModel({this.page, this.limit, this.countryName, this.order, this.search});

  CityRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    countryName = json['countryName'];
    order = json['order'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['countryName'] = this.countryName;
    data['order'] = this.order;
    data['search'] = this.search;
    return data;
  }
}
