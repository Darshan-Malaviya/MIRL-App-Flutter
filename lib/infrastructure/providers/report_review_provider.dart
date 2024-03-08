import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/rate_expert_request_model.dart';
import 'package:mirl/infrastructure/models/request/report_call_request_model.dart';
import 'package:mirl/infrastructure/models/response/rate_and_review_response_model.dart';
import 'package:mirl/infrastructure/models/response/report_call_title_response_model.dart';
import 'package:mirl/infrastructure/models/response/un_block_user_response_model.dart';
import 'package:mirl/infrastructure/repository/report_repo.dart';
import 'package:mirl/ui/screens/call_feedback_screen/componnet/call_feedback_model.dart';

class ReportReviewProvider extends ChangeNotifier {
  final _reportRepository = ReportListRepository();

  TextEditingController reviewController = TextEditingController();
  TextEditingController appropriateIssueController = TextEditingController();
  TextEditingController callIssueController = TextEditingController();

  String sortByReview = 'HIGHEST REVIEW SCORE';
  String sortByReport = 'WEEKLY';

  List<String> sortByReviewItem = ['HIGHEST REVIEW SCORE', 'LOWEST REVIEW SCORE', 'NEWEST REVIEWS', 'OLDEST REVIEWS'];

  List<String> sortByEarningItem = ['WEEKLY', 'MONTHLY', 'ALL TIME'];
  int? selectedId = 0;
  ReportCallTitleList? selectedReportCall;

  List<ReportCallTitleList> get reportCallTitleList => _reportCallTitleList;
  List<ReportCallTitleList> _reportCallTitleList = [];

  List<CommonSelectionModel> get feedbackTypeList => _feedbackTypeList;
  List<CommonSelectionModel> _feedbackTypeList = [
    CommonSelectionModel(selectType: 1, title: LocaleKeys.lame.tr(), value: ImageConstants.lame, isSelected: false),
    CommonSelectionModel(selectType: 2, title: LocaleKeys.mah.tr(), value: ImageConstants.mah, isSelected: false),
    CommonSelectionModel(selectType: 3, title: LocaleKeys.soSo.tr(), value: ImageConstants.soSo, isSelected: false),
    CommonSelectionModel(selectType: 4, title: LocaleKeys.nice.tr(), value: ImageConstants.nice, isSelected: false),
    CommonSelectionModel(selectType: 5, title: LocaleKeys.great.tr(), value: ImageConstants.great, isSelected: false),
  ];

  List<CommonSelectionModel> get criteriaList => _criteriaList;
  List<CommonSelectionModel> _criteriaList = [
    CommonSelectionModel(title: LocaleKeys.expertise.tr(), value: LocaleKeys.rateTheExpertKnowledge.tr(), ratingCategory: 1),
    CommonSelectionModel(title: LocaleKeys.communication.tr(), value: LocaleKeys.wereTheyCourteous.tr(), ratingCategory: 2),
    CommonSelectionModel(title: LocaleKeys.helpfulness.tr(), value: LocaleKeys.wereTheyAbleToHelp.tr(), ratingCategory: 3),
    CommonSelectionModel(title: LocaleKeys.empathy.tr(), value: LocaleKeys.wereTheyComfortable.tr(), ratingCategory: 4),
    CommonSelectionModel(title: LocaleKeys.professionalism.tr(), value: LocaleKeys.respectFullToThem.tr(), ratingCategory: 5),
  ];

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  bool get isListLoading => _isListLoading;
  bool _isListLoading = false;

  ReviewAndRatingData? get reviewAndRatingData => _reviewAndRatingData;
  ReviewAndRatingData? _reviewAndRatingData;

  int get pageNo => _pageNo;
  int _pageNo = 1;

  bool get reachedLastPage => _reachedLastPage;
  bool _reachedLastPage = false;

  int? selectedIndex = 0;

  String _enteredText = '0';

  String get enteredText => _enteredText;

  List formKeyList = List.generate(11, (index) => GlobalKey<FormState>());

  List<Offset> currentPosition = [];
  double localPosition = 0.0;
  bool isLoaded = false;

  List<CallFeedBackModel> callFeedbackList = [
    CallFeedBackModel(callFeedbackDataList: List.generate(11, (index) => CallFeedbackData(formKey: GlobalKey<FormState>()))),
    CallFeedBackModel(callFeedbackDataList: List.generate(11, (index) => CallFeedbackData(formKey: GlobalKey<FormState>()))),
    CallFeedBackModel(callFeedbackDataList: List.generate(11, (index) => CallFeedbackData(formKey: GlobalKey<FormState>()))),
    CallFeedBackModel(callFeedbackDataList: List.generate(11, (index) => CallFeedbackData(formKey: GlobalKey<FormState>()))),
    CallFeedBackModel(callFeedbackDataList: List.generate(11, (index) => CallFeedbackData(formKey: GlobalKey<FormState>()))),
  ];

  void changeCriteriaSelectedIndex({required int index, required int position}) {
    RenderBox box =
        callFeedbackList[index].callFeedbackDataList[position].formKey.currentContext?.findRenderObject() as RenderBox;
    Offset positionOffset = box.localToGlobal(Offset.zero);
    callFeedbackList[index].localPosition = positionOffset.dx - 20;
   // selectedIndex = position;
    notifyListeners();
  }

  void onHorizontalDragUpdate(details, {required int index}) {
    if (details.globalPosition.dx <= callFeedbackList[index].callFeedbackDataList.first.currentDxPosition) {
      return;
    }
    if (callFeedbackList[index].callFeedbackDataList.last.currentDxPosition + 16 >= details.globalPosition.dx) {
      callFeedbackList[index].localPosition = details.globalPosition.dx;
      notifyListeners();
    }
  }

  void afterLayout(index) {
    for (var element in callFeedbackList[index].callFeedbackDataList) {
      RenderBox box = element.formKey.currentContext?.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      element.currentDxPosition = position.dx - 40;
    }
    isLoaded = true;
    notifyListeners();
  }

  void changeRatingColor({required int index, required int selectedValue}) {
    _criteriaList[index].rating = selectedValue;
    notifyListeners();
  }

  void newTopicCounterValue(String value) {
    _enteredText = value.length.toString();
    notifyListeners();
  }

  void setSortByReview(String? value, int id) {
    sortByReview = value!;
    getRatingAndReviewApiCall(isLoading: false, id: id, isListLoading: true);
    notifyListeners();
  }

  void setSortByReport(String? value) {
    sortByReport = value ?? '';
    notifyListeners();
  }

  void onSelectedCategory({required int index}) {
    for (var element in _feedbackTypeList) {
      element.isSelected = false;
    }
    _feedbackTypeList[index].isSelected = true;
    selectedIndex = _feedbackTypeList[index].selectType;
    notifyListeners();
  }

  void setReportCallTitle(ReportCallTitleList? value) {
    selectedReportCall = value;
    notifyListeners();
  }

  void clearController() {
    callIssueController.clear();
    selectedReportCall = null;
    _reportCallTitleList = [];
    notifyListeners();
  }

  Future<void> getRatingAndReviewApiCall({required bool isLoading, required int id, required bool isListLoading}) async {
    if (isLoading) {
      _isLoading = true;
      notifyListeners();
    }

    if (isListLoading) {
      _pageNo = 1;
      _reachedLastPage = false;
      _isListLoading = true;
      notifyListeners();
    }

    ApiHttpResult response = await _reportRepository.reviewAndRateListApi(
      paras: {
        "firstCreatedOrder": sortByReview == sortByReviewItem[2]
            ? 'DESC'
            : sortByReview == sortByReviewItem[3]
                ? 'ASC'
                : 'DESC',
        "ratingOrder": sortByReview == sortByReviewItem[0]
            ? 'DESC'
            : sortByReview == sortByReviewItem[1]
                ? 'ASC'
                : 'DESC',
        'page': _pageNo.toString(),
        "limit": '10'
      },
      id: id,
    );

    if (isLoading) {
      _isLoading = false;
      notifyListeners();
    }

    if (isListLoading) {
      _isListLoading = false;
      notifyListeners();
    }

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is RatingAndReviewResponseModel) {
          RatingAndReviewResponseModel responseModel = response.data;

          if (_pageNo == 1) {
            _reviewAndRatingData = responseModel.data;
          } else {
            _reviewAndRatingData?.expertReviews?.addAll(responseModel.data?.expertReviews ?? []);
          }
          if (_pageNo == responseModel.pagination?.itemCount) {
            _reachedLastPage = true;
          } else {
            _pageNo = _pageNo + 1;
            _reachedLastPage = false;
          }
          notifyListeners();
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail get all review api call ${response.data}");
        break;
    }
  }

  void rateExpertRequestCall({required int callHistoryId}) {
    List<RatingCriteria> ratingCriteria = [];

    int index = 0;
    for (var element in _criteriaList) {
      ratingCriteria
          .add(RatingCriteria(rating: callFeedbackList[index].criteriaSelectedIndex ?? null, ratingCategory: element.ratingCategory));
      index++;
    }
    RateExpertRequestModel rateExpertRequestModel = RateExpertRequestModel(
      review: reviewController.text.trim(),
      ratingCriteria: ratingCriteria,
      rating: selectedIndex,
      callHistoryId: callHistoryId,
    );
    rateExpertApiCall(requestModel: rateExpertRequestModel.prepareRequest());
  }

  Future<void> rateExpertApiCall({required Object requestModel}) async {
    CustomLoading.progressDialog(isLoading: true);
    ApiHttpResult response = await _reportRepository.rateExpertApi(requestModel: requestModel);
    CustomLoading.progressDialog(isLoading: false);
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is UnBlockUserResponseModel) {
          UnBlockUserResponseModel responseModel = response.data;

          Logger().d("Successfully user rate expert API");
          // FlutterToast().showToast(msg: responseModel.message ?? '');
          NavigationService.context.toPushNamed(RoutesConstants.feedbackSubmittingScreen);
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail rate expert api call ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> getReportCallTitleApiCall() async {
    ApiHttpResult response = await _reportRepository.reportCallTitleApi();

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is ReportCallTitleResponseModel) {
          ReportCallTitleResponseModel responseModel = response.data;

          _reportCallTitleList = responseModel.data ?? [];

          //_reportCallTitleList.addAll(responseModel.data ?? []);
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail get all report call title api call ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> reportCallApiCall({required int callHistoryId}) async {
    ReportCallRequestModel reportCallRequestModel = ReportCallRequestModel(
        callHistoryId: callHistoryId, message: callIssueController.text.trim(), reportCallTitleId: selectedReportCall?.id);
    ApiHttpResult response = await _reportRepository.reportCallApi(requestModel: reportCallRequestModel.prepareRequest());

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is UnBlockUserResponseModel) {
          UnBlockUserResponseModel responseModel = response.data;
          Logger().d("Successfully report call API");
          //FlutterToast().showToast(msg: responseModel.message ?? '');
          NavigationService.context.toPushNamed(RoutesConstants.reportedSubmittingScreen);
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail report call api call ${response.data}");
        break;
    }
    // notifyListeners();
  }
}
