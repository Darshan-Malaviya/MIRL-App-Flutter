import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/home_data_response_model.dart';
import 'package:mirl/infrastructure/models/response/home_search_response_model.dart';
import 'package:mirl/infrastructure/repository/home_repo.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepo _homeRepo = HomeRepo();

  HomeData? get homeData => _homeData;
  HomeData? _homeData;

  HomeSearchData? get homeSearchData => _homeSearchData;
  HomeSearchData? _homeSearchData;

  bool get isHomeSearchLoading => _isHomeSearchLoading;
  bool _isHomeSearchLoading = false;

  bool get isHomeLoading => _isHomeLoading;
  bool _isHomeLoading = false;

  TextEditingController homeSearchController = TextEditingController();

  void clearSearchData() {
    _homeSearchData = null;
    homeSearchController.clear();
    notifyListeners();
  }

  Future<void> homePageApi() async {
    _isHomeLoading = true;
    notifyListeners();
    ApiHttpResult response = await _homeRepo.homePageService();
    _isHomeLoading = false;
    notifyListeners();
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is HomeDataResponseModel) {
          HomeDataResponseModel responseModel = response.data;
          Logger().d("home page API call successfully${response.data}");
          if (response.data != null && response.data is HomeDataResponseModel) {
            _homeData = responseModel.data;
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on home page Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> homeSearchApi() async {
    _isHomeSearchLoading = true;
    notifyListeners();

    ApiHttpResult response = await _homeRepo.homePageSearchService(searchKeyword: homeSearchController.text);

    _isHomeSearchLoading = false;
    notifyListeners();

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is HomeSearchResponseModel) {
          HomeSearchResponseModel responseModel = response.data;
          Logger().d("home search API call successfully${response.data}");
          if (response.data != null && response.data is HomeSearchResponseModel) {
            _homeSearchData = responseModel.data;
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on home search Api ${response.data}");
        break;
    }
    notifyListeners();
  }
}
