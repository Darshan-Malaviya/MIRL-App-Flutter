import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/category_list_response_model.dart';
import 'package:mirl/infrastructure/repository/category_list_repo.dart';
import 'package:mirl/ui/screens/conponnet/area_model.dart';

class CategoryListProvider extends ChangeNotifier {
  final _categoryListRepository = CategoryListRepository();

  List<CategoryList>? get categoryList => _categoryList;
  final List<CategoryList> _categoryList = [];
  final List<AreaListModel> areaListModel = [];

  // void AddAreaCategoryListRequestCall() {
  //   CategoryListResponseModel categoryListResponseModel = CategoryListResponseModel(
  //   );
  //   AddAreaCategoryListApiCall(requestModel: categoryListResponseModel.toJson());
  // }




  Future<void> AddAreaCategoryListApiCall({required String isChildId}) async {
    CustomLoading.progressDialog(isLoading: true);
    ApiHttpResult response = await _categoryListRepository.categoryListApiCall(limit: 3, page: 1, isChild: "1");
    CustomLoading.progressDialog(isLoading: false);
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CategoryListResponseModel) {
          CategoryListResponseModel categoryListResponseModel = response.data;
          Logger().d("Successfully login");
          // _categoryList.addAll(categoryListResponseModel.data ?? []);

            List<CategoryList> categoryList = [];
            for (int i = 0; i < (categoryListResponseModel.data?.length ?? 0); i++) {
              categoryList.add(categoryListResponseModel.data?[i] ?? CategoryList());
            }
            areaListModel.add(AreaListModel(categoryList: categoryList, isSelected: false));


          SharedPrefHelper.saveUserData(jsonEncode(categoryListResponseModel.data));
          //   NavigationService.context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen);
          FlutterToast().showToast(msg: categoryListResponseModel.message ?? '');
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on otp verify call Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  void onSelected(int index) {
    for (var element in areaListModel) {
      element.isSelected = false;
    }
    areaListModel[index].isSelected = true;
    notifyListeners();
  }
}
