
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/child_update_request.dart';
import 'package:mirl/infrastructure/models/response/child_update_response.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/infrastructure/repository/add_your_area_expertise_repo.dart';

class AddYourAreaExpertiseProvider extends ChangeNotifier {
  final _addYourAreaExpertiseRepository = AddYourAreaExpertiseRepository();

  List<CategoryListData>? get categoryList => _categoryList;
  final List<CategoryListData> _categoryList = [];

  List<CategoryIds> _childCategoryIds = [];
  List<CategoryIds> get childCategoryIds => _childCategoryIds;

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
    ChildUpdateRequestModel requestModel = ChildUpdateRequestModel(categoryIds: _childCategoryIds);
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

  void setSelectionBoolValueOfChild({required int position , required bool value,
    required CategoryListData? childCategoryList}){
    childCategoryList?.child?[position].isSelected = value;
    notifyListeners();
  }

  void selectAllChildCategory({ /*required List<Child>? childList ,*/ required bool isSelectAll,required int parentId}){
    int parentListIndex = _categoryList.indexWhere((element) => element.id == parentId);
    if(parentListIndex != -1){
      if(_categoryList[parentListIndex].child?.isNotEmpty ?? false) {
        for(Child data in _categoryList[parentListIndex].child ?? []){
          if(isSelectAll){
            data.isSelected = true;
          } else {
            data.isSelected = false;
          }
          notifyListeners();
        }
      }
    }

  }

  void addSelectedChildIds({ required int parentId}) {
    int parentListIndex = _categoryList.indexWhere((element) => element.id == parentId);
    if (parentListIndex != -1) {
      for( Child? _child in _categoryList[parentListIndex].child ?? []){
        //Child? _child = _categoryList[parentListIndex].child?[childIndex];
        if (_child != null) {
          if(_categoryList[parentListIndex].child?.every((element) => element.isSelected == true) ?? false){
            _categoryList[parentListIndex].selectAllCategory = true;
          } else {
            _categoryList[parentListIndex].selectAllCategory = false;
          }
          notifyListeners();
          if (_childCategoryIds.isEmpty) { /// local childIdLis is empty then add select data in list
            if (_child.isSelected ?? false) {
              _childCategoryIds.addAll([
                CategoryIds(childIds: [_child.id ?? 0], parentId: parentId)
              ]);
            }
          } else {
            /// local childIdLis is not empty
            int index = _childCategoryIds.indexWhere((element) => element.parentId == parentId); /// if parent id same then add only child ids in local childIdLis
            if (index != -1) {
              if (_child.isSelected ?? false) {
                _childCategoryIds[index].childIds?.add(_child.id ?? 0);
              } else {
                /// after select child user dis-select it then remove child ids from parent.
                _childCategoryIds[index].childIds?.remove(_child.id ?? 0);
              }
            } else {
              /// if parent not available then add new full object in childIdLis
              if (_child.isSelected ?? false) {
                _childCategoryIds.addAll([
                  CategoryIds(childIds: [_child.id ?? 0], parentId: parentId)
                ]);
              }
            }
          }
          notifyListeners();
        }
      }

    }
  }

  void clearSelectChildId() {
    _childCategoryIds.clear();
    notifyListeners();
  }

  void setCategoryChildDefaultData() {
    for (CategoryListData parent in _categoryList) {
      if (parent.child?.isNotEmpty ?? false) {
        for (Child child in parent.child ?? []) {
          if(parent.child?.every((element) => element.isSelected == true) ?? false){
            parent.selectAllCategory = true;
          } else {
            parent.selectAllCategory = false;
          }
          notifyListeners();
          if (child.isSelected ?? false) {
            if (_childCategoryIds.isEmpty) {
              _childCategoryIds.addAll([
                CategoryIds(childIds: [child.id ?? 0], parentId: parent.id)
              ]);
            } else {
              int localListIndex = _childCategoryIds.indexWhere((element) => element.parentId == parent.id);
              if (localListIndex != -1) {
                _childCategoryIds[localListIndex].childIds?.add(child.id ?? 0);
              } else {
                _childCategoryIds.addAll([
                  CategoryIds(childIds: [child.id ?? 0], parentId: parent.id)
                ]);
              }
            }
          }
        }
      }
    }
    notifyListeners();
  }
}
