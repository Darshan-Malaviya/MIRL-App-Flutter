import '../../commons/exports/common_exports.dart';

class CommonSelectionModel {
  String? title;
  String? value;
  bool? isSelected;
  VoidCallback? onTap;
  int? selectType;
  String? screenName;

  CommonSelectionModel({this.title, this.isSelected, this.selectType, this.screenName, this.value, this.onTap});
}
