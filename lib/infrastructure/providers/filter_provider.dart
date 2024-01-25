import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class FilterProvider extends ChangeNotifier {
  TextEditingController instantCallAvailabilityController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  List<String> _yesNoSelectionList = ['Yes', 'No'];

  List<String> get yesNoSelectionList => _yesNoSelectionList;

  List<GenderModel> _genderList = [
    GenderModel(title: 'Male', isSelected: false, selectType: 1),
    GenderModel(title: 'Female', isSelected: false, selectType: 2),
    GenderModel(title: 'Other', isSelected: false, selectType: 3)
  ];

  List<GenderModel> get genderList => _genderList;

  List<String> _ratingList = ['1', '2', '3', '4', '5'];

  List<String> get ratingList => _ratingList;

  bool _isCallSelect = false;

  bool _isLocationSelect = false;

  int _selectGender = 1;

  String _selectRating = '1';

  void setValueOfCall(String value) {
    _isCallSelect = (value == 'Yes') ? true : false;
    notifyListeners();
  }

  void setGender(String value) {
    GenderModel data = _genderList.firstWhere((element) => element.title == value);
    _selectGender = data.selectType ?? 1;
    notifyListeners();
  }

  void setRating(String value) {
    _selectRating = value;
    notifyListeners();
  }
}
