class CategoryIdNameCommonModel {
  int? id;
  String? name;
  bool? isCategorySelected;
  CategoryIdNameCommonModel({this.id, this.name,this.isCategorySelected});

  CategoryIdNameCommonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isCategorySelected = json['isCategorySelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
