import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/category_id_name_common_model.dart';
import 'package:mirl/infrastructure/models/request/expert_data_request_model.dart';
import 'package:mirl/infrastructure/models/request/search_pagination_common_request_model.dart';
import 'package:mirl/infrastructure/models/response/all_category_response_model.dart';
import 'package:mirl/infrastructure/models/response/city_response_model.dart';
import 'package:mirl/infrastructure/models/response/country_response_model.dart';
import 'package:mirl/infrastructure/models/response/explore_expert_category_and_user_response.dart';
import 'package:mirl/infrastructure/models/response/get_single_category_response_model.dart';
import 'package:mirl/infrastructure/repository/common_repo.dart';
import 'package:mirl/infrastructure/repository/expert_category_repo.dart';

class FilterProvider extends ChangeNotifier {
  ChangeNotifierProviderRef<FilterProvider> ref;

  FilterProvider(this.ref);
  final _expertCategoryRepo = ExpertCategoryRepo();
  final _commonRepository = CommonRepository();


  TextEditingController instantCallAvailabilityController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  TextEditingController searchCategoryController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController searchTopicController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController searchCityController = TextEditingController();
  TextEditingController searchCountryController = TextEditingController();
  TextEditingController exploreExpertController = TextEditingController();
  TextEditingController feeOrderController = TextEditingController();
  TextEditingController experienceOrderController = TextEditingController();
  TextEditingController reviewOrderController = TextEditingController();

  List<String> get yesNoSelectionList => _yesNoSelectionList;
  List<String> _yesNoSelectionList = ['SELECT ONE OR LEAVE AS IS', 'Yes', 'No'];

  List<CommonSelectionModel> get genderList => _genderList;
  List<CommonSelectionModel> _genderList = [
    CommonSelectionModel(title: 'SELECT ONE OR LEAVE AS IS', isSelected: false, selectType: 1),
    CommonSelectionModel(title: 'Male', isSelected: false, selectType: 2),
    CommonSelectionModel(title: 'Female', isSelected: false, selectType: 3),
    CommonSelectionModel(title: 'Non-Binary', isSelected: false, selectType: 4),
  ];

  String sortBySelectedItem = 'PRICE';
  String sortBySelectedOrder = 'HIGH TO LOW';

  List<String> sortByItems = ['PRICE', 'REVIEW SCORE', 'EXPERIENCE'];
  List<String> orderFilterList = ['HIGH TO LOW', ' LOW TO HIGH'];


  List<String> get ratingList => _ratingList;
  List<String> _ratingList = ['SELECT ONE OR LEAVE AS IS', '1', '2', '3', '4', '5'];

  int? _isCallSelect;
  int? get isCallSelect => _isCallSelect;

  int? _selectGender;
  int? get selectGender => _selectGender;

  String dropdown = 'PRICE';
  String dropdownValue = 'HIGH TO LOW';


  List<CategoryIdNameCommonModel> get allCategory => _allCategory;
  List<CategoryIdNameCommonModel> _allCategory = [];

  List<CategoryIdNameCommonModel> get allTopic => _allTopic;
  List<CategoryIdNameCommonModel> _allTopic = [];

  bool get reachedOneCategoryScreenLastPage => _reachedOneCategoryScreenLastPage;
  bool _reachedOneCategoryScreenLastPage = false;

  bool get reachedCategoryLastPage => _reachedCategoryLastPage;
  bool _reachedCategoryLastPage = false;

  bool get reachedExploreExpertLastPage => _reachedExploreExpertLastPage;
  bool _reachedExploreExpertLastPage = false;

  bool get reachedTopicLastPage => _reachedTopicLastPage;
  bool _reachedTopicLastPage = false;

  int get categoryPageNo => _categoryPageNo;
  int _categoryPageNo = 1;

  int get exploreExpertPageNo => _exploreExpertPageNo;
  int _exploreExpertPageNo = 1;

  int get oneCategoryScreenPageNo => _oneCategoryScreenPageNo;
  int _oneCategoryScreenPageNo = 1;

  int get topicPageNo => _topicPageNo;
  int _topicPageNo = 1;

  String? _selectRating;

  CountryModel? selectedCountryModel;

  CategoryIdNameCommonModel? selectedCategory;

  List<CategoryIdNameCommonModel>? _selectedTopicList = [];
  List<CategoryIdNameCommonModel>?  get selectedTopicList => _selectedTopicList;

  //String? selectedTopic;

  double start = 30;
  double end = 50;

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  bool get isSearchTopicBottomSheetLoading => _isSearchTopicBottomSheetLoading;
  bool _isSearchTopicBottomSheetLoading = false;

  bool get isSearchCategoryBottomSheetLoading => _isSearchCategoryBottomSheetLoading;
  bool _isSearchCategoryBottomSheetLoading = false;

  int get categorySelectionIndex => _categorySelectionIndex;
  int _categorySelectionIndex = -1;

  List<CommonSelectionModel> commonSelectionModel = [];

  SingleCategoryData? get singleCategoryData => _singleCategoryData;
  SingleCategoryData? _singleCategoryData;

  CategoryAndExpertUser? get categoryList => _categoryList;
  CategoryAndExpertUser? _categoryList;

  Future<void> removeFilter(
      {required int index,
      bool isFromExploreExpert = false,
      required BuildContext context,
      String? singleCategoryId}) async {
    String? selectedTopicId;
    if (commonSelectionModel[index].title == FilterType.Topic.name) {
      _selectedTopicList = null;
      selectedTopicId = null;
      topicController.clear();
      searchTopicController.clear();
      _allTopic.forEach((element) {
        element.isCategorySelected = false;
      });
    } else {
      if (_selectedTopicList?.isNotEmpty ?? false) {
        selectedTopicId = _selectedTopicList?.map((e) => e.id).join(",");
      }
    }

    ExpertDataRequestModel data = ExpertDataRequestModel(
        page: _exploreExpertPageNo.toString(),
        limit: '10',
        city: commonSelectionModel[index].title == FilterType.City.name
            ? null
            : cityNameController.text.isNotEmpty
                ? cityNameController.text
                : null,
        country: commonSelectionModel[index].title == FilterType.Country.name
            ? null
            : countryNameController.text.isNotEmpty
                ? countryNameController.text
                : null,
        gender: commonSelectionModel[index].title == FilterType.Gender.name
            ? null
            : genderController.text.isNotEmpty
                ? ((selectGender ?? 0) - 1).toString()
                : null,
        instantCallAvailable: commonSelectionModel[index].title == FilterType.InstantCall.name
            ? null
            : instantCallAvailabilityController.text.isNotEmpty
                ? isCallSelect == 1
                    ? "true"
                    : "false"
                : null,
        // experienceOder: requestModel?.experienceOder,
        // feeOrder: requestModel?.feeOrder,
        // maxFee: requestModel?.maxFee,
        //minFee: requestModel?.minFee,
        // reviewOrder: requestModel?.reviewOrder,
        topicIds: selectedTopicId,
        categoryId: isFromExploreExpert
            ? (commonSelectionModel[index].title == FilterType.Category.name)
                ? null
                : selectedCategory?.id.toString()
            : singleCategoryId,
        userId: SharedPrefHelper.getUserId);
    if (commonSelectionModel[index].title == FilterType.Country.name) {
      countryNameController.clear();
      searchCategoryController.clear();
      selectedCountryModel = null;
    } else if (commonSelectionModel[index].title == FilterType.City.name) {
      cityNameController.clear();
      searchCityController.clear();
    } else if (commonSelectionModel[index].title == FilterType.InstantCall.name) {
      instantCallAvailabilityController.clear();
      _isCallSelect = null;
    } else if (commonSelectionModel[index].title == FilterType.Gender.name) {
      genderController.clear();
      _selectGender = null;
    } else if (commonSelectionModel[index].title == FilterType.Category.name) {
      int index = _allCategory.indexWhere((element) => element.id == (selectedCategory?.id ?? -1));
      if (index != -1) {
        _allCategory[index].isCategorySelected = false;
      }
      _categorySelectionIndex = -1;
      selectedCategory = null;
      categoryController.clear();
    } else if (commonSelectionModel[index].title == FilterType.OverAllRating.name) {
      _selectRating = null;
      ratingController.clear();
    }
    commonSelectionModel.removeAt(index);
    if (isFromExploreExpert) {
      clearExploreExpertSearchData();
      clearExploreController();
      exploreExpertUserAndCategoryApiCall(context: context);
    } else {
      clearSingleCategoryData();
      await getSingleCategoryApiCall(categoryId: singleCategoryId ?? "", requestModel: data, context: context);
    }
    notifyListeners();
  }

  void clearSingleCategoryData() {
    _singleCategoryData = null;
    _reachedOneCategoryScreenLastPage = false;
    _oneCategoryScreenPageNo = 1;
    notifyListeners();
  }

  void clearAllFilter(){
    commonSelectionModel = [];
    instantCallAvailabilityController.clear();
    genderController.clear();
    countryNameController.clear();
    searchCategoryController.clear();
    topicController.clear();
    searchTopicController.clear();
    categoryController.clear();
    ratingController.clear();
    cityNameController.clear();
    searchCityController.clear();
    searchCountryController.clear();
    exploreExpertController.clear();
    feeOrderController.clear();
    experienceOrderController.clear();
    reviewOrderController.clear();
    selectedCategory = null;
    selectedCountryModel = null;
    _allCategory = [];
    _allTopic = [];
    _reachedCategoryLastPage = false;
    _reachedTopicLastPage = false;
    _categoryPageNo = 1;
    _topicPageNo = 1;
    _selectedTopicList = [];
    _selectGender = null;
    _selectRating = null;
   _ratingList = ['SELECT ONE OR LEAVE AS IS', '1', '2', '3', '4', '5'];
    _yesNoSelectionList = ['SELECT ONE OR LEAVE AS IS', 'Yes', 'No'];
    _genderList = [
      CommonSelectionModel(title: 'SELECT ONE OR LEAVE AS IS', isSelected: false, selectType: 1),
      CommonSelectionModel(title: 'Male', isSelected: false, selectType: 2),
      CommonSelectionModel(title: 'Female', isSelected: false, selectType: 3),
      CommonSelectionModel(title: 'Non-Binary', isSelected: false, selectType: 4),
    ];
    _categorySelectionIndex = -1;
    notifyListeners();
  }


  void setOtherCategoryValueFalse(){
    _allCategory.forEach((element) {
      element.isCategorySelected = false;
    });
    notifyListeners();
  }

  void setTopicList({required CategoryIdNameCommonModel topic}) {
    int index = _allTopic.indexWhere((element) => element.id == topic.id);
    if (index != -1) {
      if (_allTopic[index].isCategorySelected ?? false) {
        _allTopic[index].isCategorySelected = false;
      } else {
        _allTopic[index].isCategorySelected = true;
      }
      notifyListeners();
    }
  }

  void setSelectionBoolValueOfChild({required CategoryIdNameCommonModel topic}) {
    if(_selectedTopicList?.isNotEmpty ?? false) {
    } else {
     /* for (var element in singleCategoryData?.categoryData?.topic ?? []) {
        element.isSelected = false;
      }*/
      int index = singleCategoryData?.categoryData?.topic?.indexWhere((element) => element.id == topic.id) ?? -1;
      if (index != -1) {
        if (singleCategoryData?.categoryData?.topic?[index].isSelected ?? false) {
          singleCategoryData?.categoryData?.topic?[index].isSelected = false;
        //  selectedTopic  = selectedTopic?.replaceAll(singleCategoryData?.categoryData?.topic?[index].name ?? '', '');
        } else {
          singleCategoryData?.categoryData?.topic?[index].isSelected = true;
         // selectedTopic =  singleCategoryData?.categoryData?.topic?.takeWhile((element) => element.isSelected ==true).map((e) => e.name).join("\n");
        }
        notifyListeners();
      }
    }
    notifyListeners();
  }

  void setTopicByCategory() {
    _selectedTopicList = [];
    _allTopic.forEach((element) {
      if(element.isCategorySelected ?? false){
        _selectedTopicList?.add(CategoryIdNameCommonModel(
            isCategorySelected: true,
            name: element.name ?? '',
            id: element.id ?? 0));
      }
    });
    int? index = commonSelectionModel.indexWhere((element) => element.title == FilterType.Topic.name);
    String selectedTopicName = _selectedTopicList?.map((e) => e.name).join(",") ??'';
    topicController.text = selectedTopicName;
    if (index == -1) {
      commonSelectionModel.add(CommonSelectionModel(title: FilterType.Topic.name, value: selectedTopicName));
    } else {
      commonSelectionModel[index].value = selectedTopicName;
    }
    notifyListeners();
  }

  void setCategory({required int selectionIndex}) {
    _categorySelectionIndex = selectionIndex;
    selectedCategory = _allCategory[selectionIndex];
    notifyListeners();
    categoryController.text = selectedCategory?.name ?? '';
     int? index = commonSelectionModel.indexWhere((element) => element.title == FilterType.Category.name);
     if (index == -1) {
       commonSelectionModel.add(CommonSelectionModel(title: FilterType.Category.name, value: _allCategory[selectionIndex].name));
     } else {
       commonSelectionModel[index].value = _allCategory[selectionIndex].name;
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
    searchCategoryController.clear();
    notifyListeners();
  }

  void clearSearchTopicController() {
    searchTopicController.clear();
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

  void clearExploreExpertSearchData() {
     _categoryList = null;
     _exploreExpertPageNo = 1;
     _reachedExploreExpertLastPage = false;
    notifyListeners();
  }

  void clearExploreController(){
     exploreExpertController.clear();
    notifyListeners();
  }



  void clearCategoryPaginationData() {
    _categoryPageNo = 1;
    _reachedCategoryLastPage = false;
    _allCategory = [];
    _categorySelectionIndex = -1;
    notifyListeners();
  }

  void clearTopicPaginationData() {
    _topicPageNo = 1;
    _reachedTopicLastPage = false;
    _allTopic = [];
    notifyListeners();
  }

  Future<void> allCategoryListApi({bool isFullScreenLoader = false, String? searchName}) async {
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: true);
    } else {
      _isSearchCategoryBottomSheetLoading = true;
      notifyListeners();
    }
    SearchPaginationCommonRequestModel model = SearchPaginationCommonRequestModel(page: _categoryPageNo.toString(),limit: "40",search: searchName);

    ApiHttpResult response = await _commonRepository.allCategoryLIstService(requestModel: model.toNullFreeJson());
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: false);
    }  else {
      _isSearchCategoryBottomSheetLoading = false;
      notifyListeners();
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is AllCategoryListResponseModel) {
          AllCategoryListResponseModel categoryResponseModel = response.data;
          Logger().d("Successfully call category list api");
          _allCategory.addAll(categoryResponseModel.data ?? []);
          if (_categoryPageNo == categoryResponseModel.pagination?.pageCount) {
            _reachedCategoryLastPage = true;
          } else {
            _categoryPageNo = _categoryPageNo + 1;
            _reachedCategoryLastPage = false;
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on category list call Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> topicListByCategory(
      {bool isFullScreenLoader = false, String? searchName, required String categoryId}) async {
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: true);
    } else {
      _isSearchTopicBottomSheetLoading = true;
      notifyListeners();
    }
    SearchPaginationCommonRequestModel model = SearchPaginationCommonRequestModel(
        page: _topicPageNo.toString(), limit: '40', search: searchName, categoryId: categoryId);

    ApiHttpResult response =
    await _commonRepository.allTopicListByCategoryService(requestModel: model.toNullFreeJson());
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: false);
    } else {
      _isSearchTopicBottomSheetLoading = false;
      notifyListeners();
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is AllCategoryListResponseModel) {
          AllCategoryListResponseModel categoryResponseModel = response.data;
          Logger().d("Successfully call topic list api");
          _allTopic.addAll(categoryResponseModel.data ?? []);
          if (_topicPageNo == categoryResponseModel.pagination?.pageCount) {
            _reachedTopicLastPage = true;
          } else {
            _topicPageNo = _topicPageNo + 1;
            _reachedTopicLastPage = false;
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on topic list call Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> getSingleCategoryApiCall(
      {required String categoryId,
      ExpertDataRequestModel? requestModel,
      bool isFromFilter = false,
      bool isPaginating = false,
      required BuildContext context}) async {
    if(isFromFilter){
      CustomLoading.progressDialog(isLoading: true);
    } else {
      if (!isPaginating) {
        _isLoading = true;
        notifyListeners();
      }
    }

    requestModel?.page = _oneCategoryScreenPageNo.toString();
    requestModel?.limit = '2';

    ApiHttpResult response = await _expertCategoryRepo.getSingleCategoryApi(categoryId: categoryId,
    requestModel: requestModel?.toNullFreeJson());

    if(isFromFilter){
      CustomLoading.progressDialog(isLoading: false);
    } else {
      if (!isPaginating) {
        _isLoading = false;
        notifyListeners();
      }
    }

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is GetSingleCategoryResponseModel) {
          GetSingleCategoryResponseModel responseModel = response.data;
          if(_oneCategoryScreenPageNo == 1){
            _singleCategoryData = responseModel.data;
          } else{
            _singleCategoryData?.expertData?.addAll(responseModel.data?.expertData ?? []);
          }
          if (_oneCategoryScreenPageNo == responseModel.pagination?.pageCount) {
            _reachedOneCategoryScreenLastPage = true;
          } else {
            _oneCategoryScreenPageNo = _oneCategoryScreenPageNo + 1;
            _reachedOneCategoryScreenLastPage = false;
          }
          if(isFromFilter){
            Navigator.pop(context);
          }
          notifyListeners();
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail get category call Api ${response.data}");
        break;
    }
  }


  Future<void> exploreExpertUserAndCategoryApiCall({ExpertDataRequestModel? requestModel,
    required BuildContext context,
    bool isFromFilter = false,
    bool isPaginating = false,}) async {
    if(isFromFilter){
      CustomLoading.progressDialog(isLoading: true);
    } else {
      if (!isPaginating) {
        _isLoading = true;
        notifyListeners();
      }
    }
    ExpertDataRequestModel data = ExpertDataRequestModel(
        page: _exploreExpertPageNo.toString(),
        limit: '10',
      search: requestModel?.search,
      city: requestModel?.city,
      country: requestModel?.country,
      experienceOder: requestModel?.experienceOder,
      feeOrder: requestModel?.feeOrder,
      gender: requestModel?.gender,
      instantCallAvailable: requestModel?.instantCallAvailable,
      maxFee: requestModel?.maxFee,
      minFee: requestModel?.minFee,
      reviewOrder: requestModel?.reviewOrder,
      topicIds: requestModel?.topicIds,
      categoryId: requestModel?.categoryId,
      userId: SharedPrefHelper.getUserId
    );

    ApiHttpResult response =
        await _expertCategoryRepo.exploreExpertUserAndCategoryApi(request: data.toNullFreeJson());

    if(isFromFilter){
      CustomLoading.progressDialog(isLoading: false);
    } else {
      if (!isPaginating) {
        _isLoading = false;
        notifyListeners();
      }
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is ExploreExpertCategoryAndUserResponseModel) {
          ExploreExpertCategoryAndUserResponseModel responseModel = response.data;
          Logger().d("explore expert data  API call successfully${response.data}");
          if(_exploreExpertPageNo == 1){
            _categoryList = responseModel.data;
          } else{
            _categoryList?.expertData?.addAll(responseModel.data?.expertData ?? []);
          }
          if (_exploreExpertPageNo == responseModel.pagination?.pageCount) {
            _reachedExploreExpertLastPage = true;
          } else {
            _exploreExpertPageNo = _exploreExpertPageNo + 1;
            _reachedExploreExpertLastPage = false;
          }
          if(isFromFilter){
            Navigator.pop(context);
          }
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
