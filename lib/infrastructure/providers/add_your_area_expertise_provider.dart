
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/child_update_request.dart';
import 'package:mirl/infrastructure/models/response/child_update_response.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/infrastructure/repository/add_your_area_expertise_repo.dart';
import 'package:mirl/ui/screens/conponnet/area_model.dart';

class AddYourAreaExpertiseProvider extends ChangeNotifier {
  final _addYourAreaExpertiseRepository = AddYourAreaExpertiseRepository();

  List<CategoryListData>? get categoryList => _categoryList;
  final List<CategoryListData> _categoryList = [];

  List<int> _childCategoryIds = [];
  List<int> get childCategoryIds => _childCategoryIds;

  //final List<AreaOfListModel> areaOfListModel = [];

  List<int> updateChild = [];

  Future<void> areaCategoryListApiCall() async {
    CustomLoading.progressDialog(isLoading: true);
    ApiHttpResult response = await _addYourAreaExpertiseRepository.areaExpertiseApiCall(limit: 10, page: 1);
    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is ExpertCategoryResponseModel) {
          ExpertCategoryResponseModel expertCategoryResponseModel = response.data;
          Logger().d("Successfully expertImage");
          _categoryList.addAll(expertCategoryResponseModel.data ?? []);
          // List<Data> categoryList = [];
          // for (int i = 0; i < (expertCategoryResponseModel.data?.length ?? 0); i++) {
          //   categoryList.add(expertCategoryResponseModel.data?[i] ?? Data());
          // }
          // areaOfListModel.add(AreaOfListModel(areaOfList: categoryList, isSelected: false));
          // SharedPrefHelper.saveUserData(jsonEncode(expertCategoryResponseModel.data));
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on area category call Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> childUpdateApiCall({required BuildContext context}) async {
    CustomLoading.progressDialog(isLoading: true);
    ChildUpdateRequest requestModel = ChildUpdateRequest(categoryIds: _childCategoryIds);
    ApiHttpResult response = await _addYourAreaExpertiseRepository.expertiseChildUpdateApiCall(request: requestModel);
    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is ChildUpdateResponseModel) {
          ChildUpdateResponseModel childUpdateResponseModel = response.data;
          Logger().d("Successfully childUpdateApiCall");
          context.toPop();
          FlutterToast().showToast(msg: childUpdateResponseModel.message ?? '');
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on childUpdateApiCall Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  void onSelected(int index) {
    for (var element in _categoryList) {
      element.isVisible = false;
    }
    _categoryList[index].isVisible = true;
    notifyListeners();
  }

  void addSelectedChildIds({required int childCategoryId, required int childIndex}) {
    int index = _categoryList.indexWhere((element) => element.child?[childIndex].id == childCategoryId);
    if(index != -1){
      if(_categoryList[index].child?[childIndex].isSelected ?? false){
        _childCategoryIds.add(childCategoryId);
        notifyListeners();
      }
    }
  }

  void clearSelectChildId() {
    _childCategoryIds.clear();
    notifyListeners();
  }
}
