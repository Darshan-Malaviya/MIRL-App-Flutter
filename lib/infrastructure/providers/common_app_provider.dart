import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/city_response_model.dart';
import 'package:mirl/infrastructure/models/response/country_response_model.dart';
import 'package:mirl/infrastructure/repository/update_expert_profile_repo.dart';

class CommonAppProvider extends ChangeNotifier {
  final _updateUserDetailsRepository = UpdateUserDetailsRepository();

  List<CountryModel> get country => _country;
  List<CountryModel> _country = [];

  List<CityModel> get city => _city;
  List<CityModel> _city = [];

  bool get reachedCityLastPage => _reachedCityLastPage;
  bool _reachedCityLastPage = false;

  bool get reachedLastPage => _reachedLastPage;
  bool _reachedLastPage = false;

  int get pageNo => _pageNo;
  int _pageNo = 1;

  int get cityPageNo => _cityPageNo;
  int _cityPageNo = 1;

  Future<void> CountryListApiCall({bool isFullScreenLoader = false, String? searchName}) async {
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: true);
    }

    ApiHttpResult response =
        await _updateUserDetailsRepository.countryApiCall(limit: 30, page: _pageNo, searchName: searchName);
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: false);
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CountryResponseModel) {
          CountryResponseModel countryResponseModel = response.data;
          Logger().d("Successfully call country list");
          _country.addAll(countryResponseModel.data ?? []);
          if (_pageNo == countryResponseModel.pagination?.pageCount) {
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
    ApiHttpResult response = await _updateUserDetailsRepository.cityApiCall(
        limit: 30, page: _cityPageNo, countryId: id, searchName: searchName);
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: false);
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CityResponseModel) {
          CityResponseModel cityResponseModel = response.data;
          Logger().d("Successfully call city list api");
          _city.addAll(cityResponseModel.data ?? []);
          if (_cityPageNo == cityResponseModel.pagination?.pageCount) {
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
}
