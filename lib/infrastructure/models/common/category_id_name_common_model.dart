class CategoryIdNameCommonModel {
  int? id;
  String? name;
  String? image;
  bool? isCategorySelected;
  CategoryIdNameCommonModel({this.id, this.name,this.isCategorySelected, this.image});

  CategoryIdNameCommonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    isCategorySelected = json['isCategorySelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }

}
