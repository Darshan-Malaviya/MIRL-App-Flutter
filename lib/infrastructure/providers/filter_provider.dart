import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/filter_model.dart';
import 'package:mirl/infrastructure/models/response/city_response_model.dart';
import 'package:mirl/infrastructure/models/response/country_response_model.dart';
import 'package:mirl/infrastructure/repository/expert_category_repo.dart';

class FilterProvider extends ChangeNotifier {
  final _expertCategoryRepo = ExpertCategoryRepo();

  TextEditingController instantCallAvailabilityController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController searchCityController = TextEditingController();
  TextEditingController searchCountryController = TextEditingController();

  List<String> _yesNoSelectionList = ['SELECT ONE OR LEAVE AS IS', 'Yes', 'No'];

  List<String> get yesNoSelectionList => _yesNoSelectionList;

  List<CommonSelectionModel> _genderList = [
    CommonSelectionModel(title: 'SELECT ONE OR LEAVE AS IS', isSelected: false, selectType: 1),
    CommonSelectionModel(title: 'Male', isSelected: false, selectType: 2),
    CommonSelectionModel(title: 'Female', isSelected: false, selectType: 3),
    CommonSelectionModel(title: 'Non-Binary', isSelected: false, selectType: 4),
  ];

  List<CommonSelectionModel> get genderList => _genderList;

  List<String> _ratingList = ['SELECT ONE OR LEAVE AS IS', '1', '2', '3', '4', '5'];

  List<String> get ratingList => _ratingList;

  int? _isCallSelect;

  int? _selectGender;

  String? _selectRating;

  CountryModel? selectedCountryModel;

  double start = 30;
  double end = 50;

  void setValueOfCall(String value) {
    if (value != _yesNoSelectionList.first) {
      _isCallSelect = (value == 'Yes') ? 1 : 0;
    } else {
      _isCallSelect = null;
    }
    notifyListeners();
  }

  void setGender(String value) {
    if (value != _genderList.first.title) {
      CommonSelectionModel data = _genderList.firstWhere((element) => element.title == value);
      _selectGender = data.selectType ?? 1;
      data.isSelected = true;
      genderController.text = data.title ?? '';
    } else {
      _selectGender = null;
    }
    notifyListeners();
  }

  void setRating(String value) {
    _selectRating = value;
    notifyListeners();
  }

  void setSelectedCountry({required CountryModel value}) {
    selectedCountryModel = value;
    countryNameController.text = selectedCountryModel?.country ?? '';
    notifyListeners();
  }

  void setCity({required CityModel value}) {
    cityNameController.text = value.city ?? '';
    notifyListeners();
  }

  void setRange(RangeValues value) {
    start = value.start;
    end = value.end;
    notifyListeners();
  }

  void clearSearchCityController() {
    searchCityController.clear();
    notifyListeners();
  }

  void clearSearchCountryController() {
    searchCountryController.clear();
    notifyListeners();
  }

  Future<void> FilterApiCall() async {
    CustomLoading.progressDialog(isLoading: true);

    FilterModel filterModel = FilterModel(
      _selectGender.toString(),
      _isCallSelect.toString(),
      countryNameController.text,
      cityNameController.text,
      null,
      start.toString(),
      end.toString(),
      'searchUser',
      '1',
      '10',
    );

    ApiHttpResult response = await _expertCategoryRepo.filterExpertsApi(request: filterModel);

    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CommonModel) {}
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail filter call Api ${response.data}");
        break;
    }
    notifyListeners();
  }
}
