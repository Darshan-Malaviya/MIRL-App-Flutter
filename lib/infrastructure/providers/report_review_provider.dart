import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/rate_and_review_response_model.dart';
import 'package:mirl/infrastructure/repository/report_repo.dart';

class ReportReviewProvider extends ChangeNotifier {
  final _reportRepository = ReportListRepository();

  TextEditingController reviewController = TextEditingController();

  String sortByReview = 'HIGHEST REVIEW SCORE';
  String sortByReport = 'WEEKLY';

  List<String> sortByReviewItem = ['HIGHEST REVIEW SCORE', 'LOWEST REVIEW SCORE', 'NEWEST REVIEWS', 'OLDEST REVIEWS'];

  List<String> sortByEarningItem = ['WEEKLY', 'MONTHLY', 'ALL TIME'];

  List<CommonSelectionModel> get feedbackTypeList => _feedbackTypeList;
  List<CommonSelectionModel> _feedbackTypeList = [
    CommonSelectionModel(selectType: 1, title: LocaleKeys.lame.tr(), value: ImageConstants.lame,isSelected: false),
    CommonSelectionModel(selectType: 2, title: LocaleKeys.mah.tr(), value: ImageConstants.mah),
    CommonSelectionModel(selectType: 3, title: LocaleKeys.soSo.tr(), value: ImageConstants.soSo),
    CommonSelectionModel(selectType: 4, title: LocaleKeys.nice.tr(), value: ImageConstants.nice),
    CommonSelectionModel(selectType: 5, title: LocaleKeys.great.tr(), value: ImageConstants.great),
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

  void setSortByReview(String? value, int id) {
    sortByReview = value!;
    getRatingAndReviewApiCall(isLoading: false, id: id, isListLoading: true);
    notifyListeners();
  }

  void setSortByReport(String? value) {
    sortByReport = value!;
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
}
