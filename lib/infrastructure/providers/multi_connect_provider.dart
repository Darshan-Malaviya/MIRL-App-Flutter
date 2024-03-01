import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/category_id_name_common_model.dart';
import 'package:mirl/infrastructure/models/common/expert_data_model.dart';
import 'package:mirl/infrastructure/models/common/instance_call_emits_response_model.dart';
import 'package:mirl/infrastructure/models/request/child_update_request.dart';
import 'package:mirl/infrastructure/models/request/expert_data_request_model.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/infrastructure/models/response/get_single_category_response_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/repository/add_your_area_expertise_repo.dart';
import 'package:mirl/infrastructure/repository/expert_category_repo.dart';

class MultiConnectProvider extends ChangeNotifier {
  final _addYourAreaExpertiseRepository = AddYourAreaExpertiseRepository();
  final _expertCategoryRepo = ExpertCategoryRepo();

  List<CategoryListData>? get categoryList => _categoryList;
  final List<CategoryListData> _categoryList = [];

  List<CategoryIds> get childCategoryIds => _childCategoryIds;
  List<CategoryIds> _childCategoryIds = [];

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  SingleCategoryData? get singleCategoryData => _singleCategoryData;
  SingleCategoryData? _singleCategoryData;

  List<ExpertData>? get expertData => _expertData;
  List<ExpertData> _expertData = [];


  List<CategoryIdNameCommonModel> get allCategory => _allCategory;
  List<CategoryIdNameCommonModel> _allCategory = [];

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

  UserDetails? loggedUserData;

  List<ExpertData> get selectedExperts => _selectedExperts;
  List<ExpertData> _selectedExperts = [];

  List<ExpertDetails> get selectedExpertDetails => _selectedExpertDetails;
  List<ExpertDetails> _selectedExpertDetails = [];

  ExpertDetails? selectedExpertForCall;


  void getLoggedUserData() {
    if (SharedPrefHelper.getUserData.isNotEmpty) {
      UserData loggedUserData = UserData.fromJson(jsonDecode(SharedPrefHelper.getUserData));
      this.loggedUserData = UserDetails(
        id: loggedUserData.id,
        userName: loggedUserData.userName,
        userProfile: loggedUserData.userProfile,
      );
    }
  }

  void setSelectedExpertForCall(ExpertDetails expertDetails) {
    selectedExpertForCall = expertDetails;
    notifyListeners();
  }

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
        clearVariable();
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
            _expertData.addAll(responseModel.data?.expertData ?? []);
          } else {
            _expertData.addAll(responseModel.data?.expertData ?? []);
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

  void clearVariable() {
    _allExpertPageNo = 1;
    _reachedAllExpertLastPage = false;
    _singleCategoryData = null;
    _expertData.clear();
    clearExpertIds();
  }

  void setSelectedExpert(int index) {
    _expertData[index].selectedForMultiConnect = !_expertData[index].selectedForMultiConnect!;
    if (_expertData[index].selectedForMultiConnect!) {
      _selectedExperts.add(_expertData[index]);
    } else {
      _selectedExperts.remove(_expertData[index]);
    }
    notifyListeners();
  }

  void setAllExpertStatusAsWaitingOnRequestCall(){
    _selectedExpertDetails.forEach((element) {
      element.status = 1;
    });
    notifyListeners();
  }

  Future<void> setExpertList() async {
    _selectedExpertDetails.clear();
    _selectedExperts.forEach((element) {
      _selectedExpertDetails.addAll([
        ExpertDetails(
          id: element.id,
          expertName: element.expertName,
          expertProfile: element.expertProfile,
          fee: element.fee,
          overAllRating: element.overAllRating,
        )
      ]);
    });
    notifyListeners();
  }

  Future<void> changeExpertListAfterEmit({required List<ExpertDetails> expertsList}) async {
    _selectedExpertDetails = expertsList;
    notifyListeners();
  }


  void clearExpertIds() {
    _selectedExperts.clear();
    _expertData.forEach((element) {
      element.selectedForMultiConnect = false;
    });
    notifyListeners();
  }
}
