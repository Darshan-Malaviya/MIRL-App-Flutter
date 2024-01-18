class GenderModel {
  String? title;
  bool? isSelected;
  int? selectType;

  GenderModel({this.title, this.isSelected, this.selectType});

  GenderModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    isSelected = json['isSelected'];
    selectType = json['selectType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['isSelected'] = isSelected;
    data['selectType'] = selectType;
    return data;
  }
}
