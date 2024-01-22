import 'package:mirl/infrastructure/models/common/category_model.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';

class AreaListModel {
  List<CategoryModel>? categoryList;
  bool? isSelected;

  AreaListModel({this.categoryList, this.isSelected});
}

// class AreaOfListModel {
//   List<categoryListData>? areaOfList;
//   bool? isSelected;
//
//   AreaOfListModel({this.areaOfList, this.isSelected});
// }
