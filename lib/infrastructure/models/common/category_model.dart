
class CategoryModel {
  int? id;
  String? categoryImage;
  String? categoryName;
  String? description;
  int? skillId;
  String? firstCreated;
  String? lastModified;
  String? parentCategory;
  bool expanded = false;

  CategoryModel(
      {this.id,
        this.categoryImage,
        this.categoryName,
        this.description,
        this.skillId,
        this.firstCreated,
        this.lastModified,
        this.parentCategory,
        this.expanded = false});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryImage = json['categoryImage'];
    categoryName = json['categoryName'];
    description = json['description'];
    skillId = json['skillId'];
    firstCreated = json['firstCreated'];
    lastModified = json['lastModified'];
    parentCategory = json['parentCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryImage'] = this.categoryImage;
    data['categoryName'] = this.categoryName;
    data['description'] = this.description;
    data['skillId'] = this.skillId;
    data['firstCreated'] = this.firstCreated;
    data['lastModified'] = this.lastModified;
    data['parentCategory'] = this.parentCategory;
    return data;
  }
}