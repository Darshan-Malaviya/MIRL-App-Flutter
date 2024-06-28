import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/models/request/expert_data_request_model.dart';
import 'package:mirl/infrastructure/models/response/explore_expert_category_and_user_response.dart';
import 'package:mirl/infrastructure/repository/expert_category_repo.dart';

import '../commons/exports/common_exports.dart';

class SelectedTopicProvider extends ChangeNotifier {
  final _expertCategoryRepo = ExpertCategoryRepo();

  int get selectedTopicPageNo => _selectedTopicPageNo;
  int _selectedTopicPageNo = 1;

  bool get reachedCategoryLastPage => _reachedCategoryLastPage;
  bool _reachedCategoryLastPage = false;

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  CategoryAndExpertUser? get categoryList => _categoryList;
  CategoryAndExpertUser? _categoryList;

  void clearData() {
    _categoryList = null;
    _reachedCategoryLastPage = false;
    _selectedTopicPageNo = 1;
    notifyListeners();
  }

  Future<void> selectedTopicApiCall({bool isFullScreenLoader = false,int? topicId,int? categoryId, bool? fromMultiConnect}) async {
    if (isFullScreenLoader) {
      _isLoading = true;
      notifyListeners();
    }
    ExpertDataRequestModel data = ExpertDataRequestModel(
      page: _selectedTopicPageNo.toString(),
      limit: '10',
      topicIds: topicId != null ? topicId.toString() : null,
      userId: SharedPrefHelper.getUserId,
      categoryId: categoryId!= null ?  categoryId.toString() : null,
      multiConnectRequest: fromMultiConnect != null ? fromMultiConnect.toString() : null
    );

    ApiHttpResult response = await _expertCategoryRepo.exploreExpertUserAndCategoryApi(request: data.toNullFreeJson());
    if (isFullScreenLoader) {
      _isLoading = false;
      notifyListeners();
    }

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is ExploreExpertCategoryAndUserResponseModel) {
          ExploreExpertCategoryAndUserResponseModel responseModel = response.data;
          Logger().d("selected topic API call successfully${response.data}");
          if (_selectedTopicPageNo == 1) {
            _categoryList = responseModel.data;
          } else {
            _categoryList?.expertData?.addAll(responseModel.data?.expertData ?? []);
          }
          if (_selectedTopicPageNo == responseModel.pagination?.pageCount) {
            _reachedCategoryLastPage = true;
          } else {
            _selectedTopicPageNo = _selectedTopicPageNo + 1;
            _reachedCategoryLastPage = false;
          }

          notifyListeners();
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail selected topic call Api ${response.data}");
        break;
    }
  }
}
