import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/category_id_name_common_model.dart';
import 'package:mirl/infrastructure/models/request/child_update_request.dart';
import 'package:mirl/infrastructure/models/request/expert_data_request_model.dart';
import 'package:mirl/infrastructure/models/request/search_pagination_common_request_model.dart';
import 'package:mirl/infrastructure/models/response/all_category_response_model.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/infrastructure/models/response/get_single_category_response_model.dart';
import 'package:mirl/infrastructure/repository/add_your_area_expertise_repo.dart';
import 'package:mirl/infrastructure/repository/common_repo.dart';
import 'package:mirl/infrastructure/repository/expert_category_repo.dart';

class MultiConnectProvider extends ChangeNotifier {
  final _addYourAreaExpertiseRepository = AddYourAreaExpertiseRepository();
  final _expertCategoryRepo = ExpertCategoryRepo();
  final _commonRepository = CommonRepository();

  List<CategoryListData>? get categoryList => _categoryList;
  final List<CategoryListData> _categoryList = [];

  List<CategoryIds> get childCategoryIds => _childCategoryIds;
  List<CategoryIds> _childCategoryIds = [];

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  SingleCategoryData? get singleCategoryData => _singleCategoryData;
  SingleCategoryData? _singleCategoryData;

  List<CategoryIdNameCommonModel> get allCategory => _allCategory;
  List<CategoryIdNameCommonModel> _allCategory = [];

  List<CategoryIdNameCommonModel> get allTopic => _allTopic;
  List<CategoryIdNameCommonModel> _allTopic = [];

  int get categoryPageNo => _categoryPageNo;
  int _categoryPageNo = 1;

  bool get reachedCategoryLastPage => _reachedCategoryLastPage;
  bool _reachedCategoryLastPage = false;

  bool get reachedAllCategoryLastPage => _reachedAllCategoryLastPage;
  bool _reachedAllCategoryLastPage = false;

  int get allCategoryPageNo => _allCategoryPageNo;
  int _allCategoryPageNo = 1;

  bool get reachedTopicLastPage => _reachedTopicLastPage;
  bool _reachedTopicLastPage = false;

  int get topicPageNo => _topicPageNo;
  int _topicPageNo = 1;

  Future<void> categoryListApiCall({bool isLoaderVisible = false}) async {
    if (isLoaderVisible) {
      _isLoading = true;
      notifyListeners();
    }

    ApiHttpResult response = await _addYourAreaExpertiseRepository.areaExpertiseApiCall(limit: 30, page: _categoryPageNo);

    if (isLoaderVisible) {
      _isLoading = false;
      notifyListeners();
    }

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is ExpertCategoryResponseModel) {
          ExpertCategoryResponseModel expertCategoryResponseModel = response.data;
          _categoryList.addAll(expertCategoryResponseModel.data ?? []);
          if (_categoryPageNo == expertCategoryResponseModel.pagination?.itemCount) {
            _reachedCategoryLastPage = true;
          } else {
            _categoryPageNo = _categoryPageNo + 1;
            _reachedCategoryLastPage = false;
          }
          notifyListeners();
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on Category on call Api ${response.data}");
        break;
    }
  }

  Future<void> getSingleCategoryApiCall(
      {required String categoryId, bool isFromFilter = false, ExpertDataRequestModel? requestModel, bool isPaginating = false, required BuildContext context}) async {
    if (isFromFilter) {
      CustomLoading.progressDialog(isLoading: true);
    } else {
      if (!isPaginating) {
        _isLoading = true;
        notifyListeners();
      }
    }

/*    requestModel?.page = _oneCategoryScreenPageNo.toString();
    requestModel?.limit = '2';*/

    ApiHttpResult response = await _expertCategoryRepo.getSingleCategoryApi(categoryId: categoryId, requestModel: requestModel?.toNullFreeJson());

    if (isFromFilter) {
      CustomLoading.progressDialog(isLoading: false);
    } else {
      if (!isPaginating) {
        _isLoading = false;
        notifyListeners();
      }
    }

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is GetSingleCategoryResponseModel) {
          GetSingleCategoryResponseModel responseModel = response.data;
          _singleCategoryData = responseModel.data;
/*          if(_oneCategoryScreenPageNo == 1){
            _singleCategoryData = responseModel.data;
          } else{
            _singleCategoryData?.expertData?.addAll(responseModel.data?.expertData ?? []);
          }
          if (_oneCategoryScreenPageNo == responseModel.pagination?.pageCount) {
            _reachedOneCategoryScreenLastPage = true;
          } else {
            _oneCategoryScreenPageNo = _oneCategoryScreenPageNo + 1;
            _reachedOneCategoryScreenLastPage = false;
          }
          if(isFromFilter){
            Navigator.pop(context);
          }
          notifyListeners();*/
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail get category call Api ${response.data}");
        break;
    }
  }

  Future<void> allCategoryListApi({bool isFullScreenLoader = false, String? searchName}) async {
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: true);
    } else {
      // _isSearchCategoryBottomSheetLoading = true;
      notifyListeners();
    }
    SearchPaginationCommonRequestModel model = SearchPaginationCommonRequestModel(page: _allCategoryPageNo.toString(), limit: "40", search: searchName);

    ApiHttpResult response = await _commonRepository.allCategoryLIstService(requestModel: model.toNullFreeJson());
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: false);
    } else {
      // _isSearchCategoryBottomSheetLoading = false;
      notifyListeners();
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is AllCategoryListResponseModel) {
          AllCategoryListResponseModel categoryResponseModel = response.data;
          _allCategory.addAll(categoryResponseModel.data ?? []);
          if (_allCategoryPageNo == categoryResponseModel.pagination?.pageCount) {
            _reachedAllCategoryLastPage = true;
          } else {
            _allCategoryPageNo = _allCategoryPageNo + 1;
            _reachedAllCategoryLastPage = false;
          }
          notifyListeners();
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on category list call Api ${response.data}");
        break;
    }
  }

  Future<void> topicListByCategory({bool isFullScreenLoader = false, String? searchName, required String categoryId}) async {
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: true);
    } else {
      // _isSearchTopicBottomSheetLoading = true;
      notifyListeners();
    }
    SearchPaginationCommonRequestModel model = SearchPaginationCommonRequestModel(page: _topicPageNo.toString(), limit: '40', search: searchName, categoryId: categoryId);

    ApiHttpResult response = await _commonRepository.allTopicListByCategoryService(requestModel: model.toNullFreeJson());
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: false);
    } else {
      // _isSearchTopicBottomSheetLoading = false;
      notifyListeners();
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is AllCategoryListResponseModel) {
          AllCategoryListResponseModel categoryResponseModel = response.data;
          _allTopic.addAll(categoryResponseModel.data ?? []);
          if (_topicPageNo == categoryResponseModel.pagination?.pageCount) {
            _reachedTopicLastPage = true;
          } else {
            _topicPageNo = _topicPageNo + 1;
            _reachedTopicLastPage = false;
          }
          notifyListeners();
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on topic list call Api ${response.data}");
        break;
    }
  }
}
