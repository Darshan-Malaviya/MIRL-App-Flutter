import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/category_id_name_common_model.dart';
import 'package:mirl/infrastructure/models/request/child_update_request.dart';
import 'package:mirl/infrastructure/models/request/expert_data_request_model.dart';
import 'package:mirl/infrastructure/models/request/search_pagination_common_request_model.dart';
import 'package:mirl/infrastructure/models/response/all_category_response_model.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/infrastructure/models/response/explore_expert_category_and_user_response.dart';
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

  bool get reachedAllExpertLastPage => _reachedAllExpertLastPage;
  bool _reachedAllExpertLastPage = false;

  int get allExpertPageNo => _allExpertPageNo;
  int _allExpertPageNo = 1;

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
    requestModel?.page = _allExpertPageNo.toString();
    requestModel?.limit = '10';

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
          if (_allExpertPageNo == 1) {
            _singleCategoryData = responseModel.data;
          } else {
            if (!isPaginating) {
              _singleCategoryData?.expertData?.clear();
            } else {
              _singleCategoryData?.expertData?.addAll(responseModel.data?.expertData ?? []);
            }
          }
          if (_allExpertPageNo == responseModel.pagination?.pageCount) {
            _reachedAllExpertLastPage = true;
          } else {
            _allExpertPageNo = _allExpertPageNo + 1;
            _reachedAllExpertLastPage = false;
          }
          if (isFromFilter) {
            Navigator.pop(context);
          }
          notifyListeners();
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail get category call Api ${response.data}");
        break;
    }
  }

  Future<void> exploreExpertUserAndCategoryApiCall(
      {ExpertDataRequestModel? requestModel, required BuildContext context, bool isFromFilter = false, bool isPaginating = false}) async {
    if (isFromFilter) {
      CustomLoading.progressDialog(isLoading: true);
    } else {
      if (!isPaginating) {
        _isLoading = true;
        notifyListeners();
      }
    }
    ExpertDataRequestModel data = ExpertDataRequestModel(
      page: _allExpertPageNo.toString(),
      limit: '10',
      multiConnectRequest: 'true',
      city: requestModel?.city,
      country: requestModel?.country,
      experienceOder: requestModel?.experienceOder,
      feeOrder: requestModel?.feeOrder,
      gender: requestModel?.gender,
      instantCallAvailable: requestModel?.instantCallAvailable,
      maxFee: double.parse(requestModel?.maxFee ?? '0').toStringAsFixed(2),
      minFee: double.parse(requestModel?.minFee ?? '0').toStringAsFixed(2),
      reviewOrder: requestModel?.reviewOrder,
      topicIds: requestModel?.topicIds,
      categoryId: requestModel?.categoryId,
      userId: SharedPrefHelper.getUserId,
    );

    ApiHttpResult response = await _expertCategoryRepo.exploreExpertUserAndCategoryApi(request: data.toNullFreeJson());

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
        if (response.data != null && response.data is ExploreExpertCategoryAndUserResponseModel) {
          ExploreExpertCategoryAndUserResponseModel responseModel = response.data;
          Logger().d("explore expert data  API call successfully${response.data}");

          _singleCategoryData?.expertData?.addAll(responseModel.data?.expertData ?? []);

          if (_allExpertPageNo == responseModel.pagination?.pageCount) {
            _reachedAllExpertLastPage = true;
          } else {
            _allExpertPageNo = _allExpertPageNo + 1;
            _reachedAllExpertLastPage = false;
          }
          if (isFromFilter) {
            Navigator.pop(context);
          }
          notifyListeners();
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail exploreExpertUserAndCategory call Api ${response.data}");
        break;
    }
  }

  void clearVariable() {
    _singleCategoryData = null;
  }
}
