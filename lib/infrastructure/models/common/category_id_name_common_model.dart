class CategoryIdNameCommonModel {
  int? id;
  String? name;
  String? image;
  String? description;
  bool? isCategorySelected;
  CategoryIdNameCommonModel({this.id, this.name,this.isCategorySelected, this.image,this.description});

  CategoryIdNameCommonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description=json['descriptionName'];
    isCategorySelected = json['isCategorySelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['descriptionName']=this.description;
    data['image'] = this.image;
    return data;
  }

}
