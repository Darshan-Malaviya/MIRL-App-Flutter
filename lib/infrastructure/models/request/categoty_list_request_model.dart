class CategoryListRequestModel {
  String? page;
  String? limit;
  String? search;
  int? skillId;
  String? isChild;

  CategoryListRequestModel({this.page, this.limit, this.search, this.skillId, this.isChild});

  CategoryListRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    search = json['search'];
    skillId = json['skillId'];
    isChild = json['isChild'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['search'] = this.search;
    data['skillId'] = this.skillId;
    data['isChild'] = this.isChild;
    return data;
  }
}
