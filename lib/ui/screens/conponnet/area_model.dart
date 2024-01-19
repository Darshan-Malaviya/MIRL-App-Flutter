import 'package:mirl/infrastructure/models/common/category_model.dart';

class AreaListModel {
  List<CategoryModel>? categoryList;
  bool? isSelected;

  AreaListModel({this.categoryList, this.isSelected});
}
