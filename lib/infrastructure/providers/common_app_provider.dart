import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/category_id_name_common_model.dart';
import 'package:mirl/infrastructure/models/request/search_pagination_common_request_model.dart';
import 'package:mirl/infrastructure/models/response/all_category_response_model.dart';
import 'package:mirl/infrastructure/models/response/city_response_model.dart';
import 'package:mirl/infrastructure/models/response/country_response_model.dart';
import 'package:mirl/infrastructure/repository/common_repo.dart';
import 'package:mirl/infrastructure/repository/update_expert_profile_repo.dart';

class CommonAppProvider extends ChangeNotifier {
  final _updateUserDetailsRepository = UpdateUserDetailsRepository();
  final _commonRepository = CommonRepository();

  List<CountryModel> get country => _country;
  List<CountryModel> _country = [];

  List<CityModel> get city => _city;
  List<CityModel> _city = [];

  List<CategoryIdNameCommonModel> get allCategory => _allCategory;
  List<CategoryIdNameCommonModel> _allCategory = [];

  List<CategoryIdNameCommonModel> get allTopic => _allTopic;
  List<CategoryIdNameCommonModel> _allTopic = [];

  bool get reachedCityLastPage => _reachedCityLastPage;
  bool _reachedCityLastPage = false;

  bool get reachedLastPage => _reachedLastPage;
  bool _reachedLastPage = false;

  bool get reachedCategoryLastPage => _reachedCategoryLastPage;
  bool _reachedCategoryLastPage = false;

  bool get reachedTopicLastPage => _reachedTopicLastPage;
  bool _reachedTopicLastPage = false;

  int get pageNo => _pageNo;
  int _pageNo = 1;

  int get cityPageNo => _cityPageNo;
  int _cityPageNo = 1;

  int get categoryPageNo => _categoryPageNo;
  int _categoryPageNo = 1;

  int get topicPageNo => _topicPageNo;
  int _topicPageNo = 1;

  Future<void> CountryListApiCall({bool isFullScreenLoader = false, String? searchName}) async {
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: true);
    }

    ApiHttpResult response = await _updateUserDetailsRepository.countryApiCall(limit: 30, page: _pageNo, searchName: searchName);
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: false);
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CountryResponseModel) {
          CountryResponseModel countryResponseModel = response.data;
          Logger().d("Successfully call country list");
          _country.addAll(countryResponseModel.data ?? []);
          if (_pageNo == countryResponseModel.pagination?.itemCount) {
            _reachedLastPage = true;
          } else {
            _pageNo = _pageNo + 1;
            _reachedLastPage = false;
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on country list call Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> cityListApiCall({bool isFullScreenLoader = false, String? searchName, required String id}) async {
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: true);
    }
    ApiHttpResult response = await _updateUserDetailsRepository.cityApiCall(limit: 30, page: _cityPageNo, countryId: id, searchName: searchName);
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: false);
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CityResponseModel) {
          CityResponseModel cityResponseModel = response.data;
          Logger().d("Successfully call city list api");
          _city.addAll(cityResponseModel.data ?? []);
          if (_cityPageNo == cityResponseModel.pagination?.itemCount) {
            _reachedCityLastPage = true;
          } else {
            _cityPageNo = _cityPageNo + 1;
            _reachedCityLastPage = false;
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on city list call Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> allCategoryListApi({bool isFullScreenLoader = false, String? searchName}) async {
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: true);
    }

/*    SearchPaginationCommonRequestModel model;

    if(searchName?.isNotEmpty ?? false){
      SearchPaginationCommonRequestModel model = SearchPaginationCommonRequestModel(page: _categoryPageNo.toString(),limit:'40',search: searchName);
    } else {
      model = SearchPaginationCommonRequestModel(page: _categoryPageNo.toString(),limit:'40');
    }*/
    SearchPaginationCommonRequestModel model = SearchPaginationCommonRequestModel(page: _categoryPageNo.toString(),limit:'40',search: searchName);

    ApiHttpResult response = await _commonRepository.allCategoryLIstService(requestModel: model.toNullFreeJson());
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: false);
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is AllCategoryListResponseModel) {
          AllCategoryListResponseModel categoryResponseModel = response.data;
          Logger().d("Successfully call category list api");
          _allCategory.addAll(categoryResponseModel.data ?? []);
          if (_categoryPageNo == categoryResponseModel.pagination?.itemCount) {
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
    }
    SearchPaginationCommonRequestModel model = SearchPaginationCommonRequestModel(
        page: _topicPageNo.toString(), limit: '40', search: searchName, categoryId: categoryId);

    ApiHttpResult response =
        await _commonRepository.allTopicListByCategoryService(requestModel: model.toNullFreeJson());
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: false);
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is AllCategoryListResponseModel) {
          AllCategoryListResponseModel categoryResponseModel = response.data;
          Logger().d("Successfully call topic list api");
          _allTopic.addAll(categoryResponseModel.data ?? []);
          if (_topicPageNo == categoryResponseModel.pagination?.itemCount) {
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

  void clearCityPaginationData() {
    _cityPageNo = 1;
    _reachedCityLastPage = false;
    _city = [];
    notifyListeners();
  }

  void clearCountryPaginationData() {
    _pageNo = 1;
    _reachedLastPage = false;
    _country = [];
    notifyListeners();
  }

  void clearCategoryPaginationData() {
    _categoryPageNo = 1;
    _reachedCategoryLastPage = false;
    _allCategory = [];
    notifyListeners();
  }

  void clearTopicPaginationData() {
    _topicPageNo = 1;
    _reachedTopicLastPage = false;
    _allTopic = [];
    notifyListeners();
  }


}
