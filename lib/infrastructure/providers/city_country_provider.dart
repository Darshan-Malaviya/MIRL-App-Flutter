import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/city_response_model.dart';
import 'package:mirl/infrastructure/models/response/country_response_model.dart';
import 'package:mirl/infrastructure/repository/update_expert_profile_repo.dart';

class CityCountryProvider extends ChangeNotifier {
  final _updateUserDetailsRepository = UpdateUserDetailsRepository();

  TextEditingController countryNameController = TextEditingController();

  List<CountryModel> get country => _country;
  List<CountryModel> _country = [];

  List<cityList> get city => _city;
  List<cityList> _city = [];

  bool get reachedLastPage => _reachedLastPage;
  bool _reachedLastPage = false;

  CountryModel? _selectedCountryModel;

  CountryModel? get selectedCountryModel => _selectedCountryModel;

  int get pageNo => _pageNo;
  int _pageNo = 1;

  void setSelectedCountry({required CountryModel value}) {
    _selectedCountryModel = value;
    notifyListeners();
  }

  displayCountry() {
    countryNameController.text = _selectedCountryModel?.country ?? '';
  }

  Future<void> CountryListApiCall() async {
    CustomLoading.progressDialog(isLoading: true);

    ApiHttpResult response = await _updateUserDetailsRepository.countryApiCall(
      limit: 10,
      page: _pageNo,
    );
    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CountryResponseModel) {
          CountryResponseModel countryResponseModel = response.data;
          Logger().d("Successfully");
          _country.addAll(countryResponseModel.data ?? []);
          if (_pageNo == countryResponseModel.pagination?.itemCount) {
            _reachedLastPage = true;
          } else {
            _pageNo = _pageNo + 1;
            _reachedLastPage = false;
          }
          SharedPrefHelper.saveUserData(jsonEncode(countryResponseModel.data));
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on area category call Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> cityListApiCall() async {
    CustomLoading.progressDialog(isLoading: true);
    ApiHttpResult response = await _updateUserDetailsRepository.cityApiCall(
        limit: 10, page: _pageNo, countryId: _selectedCountryModel?.id.toString() ?? '');
    CustomLoading.progressDialog(isLoading: false);
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CityResponseModel) {
          CityResponseModel cityResponseModel = response.data;
          Logger().d("Successfully");
          _city.addAll(cityResponseModel.data ?? []);
          if (_pageNo == cityResponseModel.pagination?.itemCount) {
            _reachedLastPage = true;
          } else {
            _pageNo = _pageNo + 1;
            _reachedLastPage = false;
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on area category call Api ${response.data}");
        break;
    }
    notifyListeners();
  }
}
