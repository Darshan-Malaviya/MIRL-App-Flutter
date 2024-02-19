import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/rate_and_review_response_model.dart';
import 'package:mirl/infrastructure/repository/report_repo.dart';

class ReportReviewProvider extends ChangeNotifier {
  final _reportRepository = ReportListRepository();

  String sortByReview = 'HIGHEST REVIEW SCORE';
  String sortByReport = 'WEEKLY';

  List<String> sortByReviewItem = ['HIGHEST REVIEW SCORE', 'LOWEST REVIEW SCORE', 'NEWEST REVIEWS', 'OLDEST REVIEWS'];

  List<String> sortByEarningItem = ['WEEKLY', 'MONTHLY', 'ALL TIME'];

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  ReviewAndRatingData? get reviewAndRatingData => _reviewAndRatingData;
  ReviewAndRatingData? _reviewAndRatingData;

  int get pageNo => _pageNo;
  int _pageNo = 1;

  bool get reachedLastPage => _reachedLastPage;
  bool _reachedLastPage = false;

  void setSortByReview(String? value) {
    sortByReview = value!;
    notifyListeners();
  }

  void setSortByReport(String? value) {
    sortByReport = value!;
    notifyListeners();
  }

  Future<void> getRatingAndReviewApiCall({required bool isLoading}) async {
    if (isLoading) {
      _isLoading = true;
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
    );

    if (isLoading) {
      _isLoading = false;
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
