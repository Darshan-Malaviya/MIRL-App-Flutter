import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/category_model.dart';
import 'package:mirl/infrastructure/models/response/category_list_response_model.dart';
import 'package:mirl/infrastructure/repository/category_list_repo.dart';
import 'package:mirl/ui/screens/conponnet/area_model.dart';

class CategoryListProvider extends ChangeNotifier {
  final _categoryListRepository = CategoryListRepository();

  List<CategoryModel>? get categoryList => _categoryList;
  final List<CategoryModel> _categoryList = [];
  final List<AreaListModel> areaListModel = [];

  // void AddAreaCategoryListRequestCall() {
  //   CategoryListResponseModel categoryListResponseModel = CategoryListResponseModel(
  //   );
  //   AddAreaCategoryListApiCall(requestModel: categoryListResponseModel.toJson());
  // }

  Future<void> ListAreaCategoryListApiCall({required String isChildId}) async {
    CustomLoading.progressDialog(isLoading: true);

    ApiHttpResult response = await _categoryListRepository.categoryListApiCall(limit: 5, page: 1, isChild: isChildId);
    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CategoryListResponseModel) {
          CategoryListResponseModel categoryListResponseModel = response.data;
          Logger().d("Successfully login");
          _categoryList.addAll(categoryListResponseModel.data ?? []);
          //
          // List<CategoryModel> categoryList = [];
          // for (int i = 0; i < (categoryListResponseModel.data?.length ?? 0); i++) {
          //   categoryList.add(categoryListResponseModel.data?[i] ?? CategoryModel());
          // }
          // areaListModel.add(AreaListModel(categoryList: categoryList, isSelected: false));
         //  SharedPrefHelper.saveUserData(jsonEncode(categoryListResponseModel.data));
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on area category call Api ${response.data}");
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
