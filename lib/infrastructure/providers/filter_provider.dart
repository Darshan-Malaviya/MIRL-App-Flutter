import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/category_id_name_common_model.dart';
import 'package:mirl/infrastructure/models/common/filter_model.dart';
import 'package:mirl/infrastructure/models/response/city_response_model.dart';
import 'package:mirl/infrastructure/models/response/country_response_model.dart';
import 'package:mirl/infrastructure/models/response/explore_expert_category_and_user_response.dart';
import 'package:mirl/infrastructure/models/response/get_single_category_response_model.dart';
import 'package:mirl/infrastructure/repository/expert_category_repo.dart';

class FilterProvider extends ChangeNotifier {
  ChangeNotifierProviderRef<FilterProvider> ref;

  FilterProvider(this.ref);
  final _expertCategoryRepo = ExpertCategoryRepo();

  TextEditingController instantCallAvailabilityController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController searchCityController = TextEditingController();
  TextEditingController searchCountryController = TextEditingController();

  List<String> get yesNoSelectionList => _yesNoSelectionList;
  List<String> _yesNoSelectionList = ['SELECT ONE OR LEAVE AS IS', 'Yes', 'No'];

  List<CommonSelectionModel> get genderList => _genderList;
  List<CommonSelectionModel> _genderList = [
    CommonSelectionModel(title: 'SELECT ONE OR LEAVE AS IS', isSelected: false, selectType: 1),
    CommonSelectionModel(title: 'Male', isSelected: false, selectType: 2),
    CommonSelectionModel(title: 'Female', isSelected: false, selectType: 3),
    CommonSelectionModel(title: 'Non-Binary', isSelected: false, selectType: 4),
  ];

  List<String> get ratingList => _ratingList;
  List<String> _ratingList = ['SELECT ONE OR LEAVE AS IS', '1', '2', '3', '4', '5'];

  int? _isCallSelect;

  int? _selectGender;

  String? _selectRating;

  CountryModel? selectedCountryModel;

  CategoryIdNameCommonModel? selectedCategory;


  List<CategoryIdNameCommonModel>? _selectedTopicList = [];
  List<CategoryIdNameCommonModel>?  get selectedTopicList => _selectedTopicList;

  String? selectedTopic;

  double start = 30;
  double end = 50;

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  List<CommonSelectionModel> commonSelectionModel = [];

  SingleCategoryData? get singleCategoryData => _singleCategoryData;
  SingleCategoryData? _singleCategoryData;

  CategoryAndExpertUser? get categoryList => _categoryList;
  CategoryAndExpertUser? _categoryList;


  void setCategory({required CategoryIdNameCommonModel value}) {
     int? index = commonSelectionModel.indexWhere((element) => element.title == FilterType.Category.name);
     selectedCategory = value;
     selectedCategory?.isCategorySelected = true;
     categoryController.text = selectedCategory?.name ?? '';
     if (index == -1) {
       commonSelectionModel.add(CommonSelectionModel(title: FilterType.Category.name, value: value.name));
     } else {
       commonSelectionModel[index].value = value.name;
     }
     notifyListeners();
  }

  void getSelectedCategory() {
    int? index = commonSelectionModel.indexWhere((element) => element.title == FilterType.Category.name);
    selectedCategory = CategoryIdNameCommonModel(
        name: _singleCategoryData?.categoryData?.name.toString() ?? '',
        isCategorySelected: true,
        id: _singleCategoryData?.categoryData?.id);
    categoryController.text = selectedCategory?.name ?? '';
    if (index == -1) {
      commonSelectionModel
          .add(CommonSelectionModel(title: FilterType.Category.name, value: selectedCategory?.name ?? ''));
    } else {
      commonSelectionModel[index].value = selectedCategory?.name ?? '';
    }
    notifyListeners();
  }

  void setTopicByCategory() {
    List<CategoryIdNameCommonModel> topicList = ref.watch(commonAppProvider).allTopic;
    topicList.forEach((element) {
      if(_selectedTopicList?.isEmpty ?? false){
        if(element.isCategorySelected ?? false){
          _selectedTopicList?.add(CategoryIdNameCommonModel(
              isCategorySelected: true,
              name: element.name ?? '',
              id: element.id ?? 0));
        }
      }
    });
    int? index = commonSelectionModel.indexWhere((element) => element.title == FilterType.Topic.name);
    topicController.text = selectedTopicList?.first.name ?? '';
    if (index == -1) {
      commonSelectionModel.add(CommonSelectionModel(title: FilterType.Topic.name, value: selectedTopicList?.first.name ?? ''));
    } else {
      commonSelectionModel[index].value = selectedTopicList?.first.name ?? '';
    }
    notifyListeners();
  }


  void setValueOfCall(String value) {
    int? index = commonSelectionModel.indexWhere((element) => element.title == FilterType.InstantCall.name);
    if (value != _yesNoSelectionList.first) {
      _isCallSelect = (value == 'Yes') ? 1 : 0;
      instantCallAvailabilityController.text = value;
      if (index == -1) {
        commonSelectionModel.add(CommonSelectionModel(title: FilterType.InstantCall.name, value: value));
      } else {
        commonSelectionModel[index].value = value;
      }
    } else {
      _isCallSelect = null;
      instantCallAvailabilityController.text = '';
      if (index != -1) {
        commonSelectionModel.removeAt(index);
      }
    }
    notifyListeners();
  }

  void setGender(String value) {
    int? index = commonSelectionModel.indexWhere((element) => element.title == FilterType.Gender.name);
    if (value != _genderList.first.title) {
      CommonSelectionModel data = _genderList.firstWhere((element) => element.title == value);
      _selectGender = data.selectType ?? 1;
      data.isSelected = true;
      genderController.text = data.title ?? '';
      if (index == -1) {
        commonSelectionModel.add(CommonSelectionModel(title: FilterType.Gender.name, value: value));
      } else {
        commonSelectionModel[index].value = value;
      }
    } else {
      _selectGender = null;
      genderController.text = '';
      if (index != -1) {
        commonSelectionModel.removeAt(index);
      }
    }
    notifyListeners();
  }

  void setRating(String value) {
    int? index = commonSelectionModel.indexWhere((element) => element.title == FilterType.OverAllRating.name);
    if (value != _ratingList.first) {
      _selectRating = value;
      ratingController.text = value;
      if (index == -1) {
        commonSelectionModel.add(CommonSelectionModel(title: FilterType.OverAllRating.name, value: value));
      } else {
        commonSelectionModel[index].value = value;
      }
    } else {
      _selectRating = null;
      ratingController.text = '';
      if (index != -1) {
        commonSelectionModel.removeAt(index);
      }
    }
    notifyListeners();
  }

  void setSelectedCountry({required CountryModel value}) {
    int? index = commonSelectionModel.indexWhere((element) => element.title == FilterType.Country.name);
    selectedCountryModel = value;
    countryNameController.text = selectedCountryModel?.country ?? '';
    if (index == -1) {
      commonSelectionModel.add(CommonSelectionModel(title: FilterType.Country.name, value: value.country));
    } else {
      commonSelectionModel[index].value = value.country;
    }
    notifyListeners();
  }

  void setCity({required CityModel value}) {
    int? index = commonSelectionModel.indexWhere((element) => element.title == FilterType.City.name);
    cityNameController.text = value.city ?? '';
    if (index == -1) {
      commonSelectionModel.add(CommonSelectionModel(title: FilterType.City.name, value: value.city));
    } else {
      commonSelectionModel[index].value = value.city;
    }
    notifyListeners();
  }

  void setRange(RangeValues value) {
    start = value.start;
    end = value.end;
    notifyListeners();
  }

  void clearSearchCategoryController() {
    categoryController.clear();
    notifyListeners();
  }

  void clearSearchTopicController() {
    categoryController.clear();
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

  void setSelectionBoolValueOfChild({required int position}) {
    for (var element in singleCategoryData?.categoryData?.topic ?? []) {
      element.isSelected = false;
    }
    singleCategoryData?.categoryData?.topic?[position].isSelected = true;
    selectedTopic = singleCategoryData?.categoryData?.topic?[position].name;
    notifyListeners();
  }

  Future<void> filterApiCall() async {
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
  }

  Future<void> getSingleCategoryApiCall({required String categoryId}) async {
    _isLoading = true;
    notifyListeners();

    ApiHttpResult response = await _expertCategoryRepo.getSingleCategoryApi(categoryId: categoryId);

    _isLoading = false;
    notifyListeners();
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is GetSingleCategoryResponseModel) {
          GetSingleCategoryResponseModel responseModel = response.data;
          _singleCategoryData = responseModel.data;
          notifyListeners();
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail get category call Api ${response.data}");
        break;
    }
  }

  Future<void> exploreExpertUserAndCategoryApiCall() async {
    _isLoading = true;
    notifyListeners();

    ApiHttpResult response = await _expertCategoryRepo.exploreExpertUserAndCategoryApi();

    _isLoading = false;
    notifyListeners();
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is ExploreExpertCategoryAndUserResponseModel) {
          ExploreExpertCategoryAndUserResponseModel responseModel = response.data;
          _categoryList = responseModel.data;
          notifyListeners();
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail exploreExpertUserAndCategory call Api ${response.data}");
        break;
    }
  }
}
