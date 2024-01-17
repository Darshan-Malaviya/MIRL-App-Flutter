import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/country_response_model.dart';
import 'package:mirl/infrastructure/repository/update_expert_profile_repo.dart';

class CityCountryProvider extends ChangeNotifier {
  final _updateUserDetailsRepository = UpdateUserDetailsRepository();

  List<countryList> get country => _country;
  List<countryList> _country = [];

  bool get reachedLastPage => _reachedLastPage;
  bool _reachedLastPage = false;

  int get pageNo => _pageNo;
  int _pageNo = 1;

  Future<void> AreaCategoryListApiCall() async {
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
}
