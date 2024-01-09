import 'package:mirl/infrastructure/models/response/category_list_response_model.dart';

class AreaListModel {
  List<CategoryList>? categoryList;
  bool? isSelected;

  AreaListModel({this.categoryList, this.isSelected});
}
