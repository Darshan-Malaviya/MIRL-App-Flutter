import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/home_data_response_model.dart';
import 'package:mirl/infrastructure/models/response/home_search_response_model.dart';
import 'package:mirl/infrastructure/repository/home_repo.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepo _homeRepo = HomeRepo();

  HomeData? get homeData => _homeData;
  HomeData? _homeData;

  HomeSearchData? get homeSearchData=> _homeSearchData;
  HomeSearchData? _homeSearchData;

  TextEditingController homeSearchController = TextEditingController();

  void clearSearchData(){
    homeSearchController.clear();
    notifyListeners();
  }

  Future<void> homePageApi() async {
    CustomLoading.progressDialog(isLoading: true);

    ApiHttpResult response = await _homeRepo.homePageService();
    CustomLoading.progressDialog(isLoading: false);
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
    CustomLoading.progressDialog(isLoading: true);

    ApiHttpResult response = await _homeRepo.homePageSearchService(searchKeyword: homeSearchController.text);
    CustomLoading.progressDialog(isLoading: false);
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
