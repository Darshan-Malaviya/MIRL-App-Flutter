import '../../commons/exports/common_exports.dart';

class CommonSelectionModel {
  String? title;
  String? value;
  String? displayText;
  bool? isSelected;
  VoidCallback? onTap;
  int? selectType;
  String? screenName;
  int? ratingCategory;
  int? rating;

  CommonSelectionModel({this.title, this.isSelected, this.selectType, this.screenName, this.value, this.onTap,this.ratingCategory, this.rating,this.displayText});
}
