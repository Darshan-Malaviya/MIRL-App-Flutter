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

  void setFavoriteList(){
    favoriteListNotifier.value.clear();
    favoriteListNotifier.value = _homeData?.userFavorites ?? [];
    notifyListeners();
  }

  void manageFavoriteUserList(
      {required int expertId, required String expertName, required String expertProfile, required bool isFavorite}) {
    if (isFavorite == false) {
      int index = favoriteListNotifier.value.indexWhere((element) => element.id.toString() == expertId.toString());
      if (index != -1) {
        favoriteListNotifier.value.removeAt(index);
        notifyListeners();
      }
    } else {
      if (favoriteListNotifier.value.isEmpty) {
        favoriteListNotifier.value
            .add(UserFavorites(id: expertId, expertName: expertName, expertProfile: expertProfile));
        notifyListeners();
      } else {
        int index = favoriteListNotifier.value.indexWhere((element) => element.id.toString() != expertId.toString());
        if (index != -1) {
          favoriteListNotifier.value
              .add(UserFavorites(id: expertId, expertName: expertName, expertProfile: expertProfile));
          notifyListeners();
        }
      }
    }
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
            if(_homeData?.userFavorites?.isNotEmpty ?? false ){
              _homeData?.userFavorites?.forEach((element) {
                element.isFavorite = true;
              });
            }
            setFavoriteList();
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
