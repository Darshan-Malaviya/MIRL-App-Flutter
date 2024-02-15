
class CategoryModel {
  int? id;
  String? image;
  String? name;
  String? description;
  int? skillId;
  String? firstCreated;
  String? lastModified;
  String? parentCategory;
  bool expanded = false;

  CategoryModel(
      {this.id,
        this.image,
        this.name,
        this.description,
        this.skillId,
        this.firstCreated,
        this.lastModified,
        this.parentCategory,
        this.expanded = false});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    skillId = json['skillId'];
    firstCreated = json['firstCreated'];
    lastModified = json['lastModified'];
    parentCategory = json['parentCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['skillId'] = this.skillId;
    data['firstCreated'] = this.firstCreated;
    data['lastModified'] = this.lastModified;
    data['parentCategory'] = this.parentCategory;
    return data;
  }
}