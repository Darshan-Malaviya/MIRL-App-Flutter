import 'package:flutter/cupertino.dart';

class ReportReviewProvider extends ChangeNotifier {
  String sortByReview = 'HIGHEST REVIEW SCORE';
  String sortByReport = 'WEEKLY';

  List<String> sortByReviewItem = ['HIGHEST REVIEW SCORE', 'LOWEST REVIEW SCORE', 'NEWEST REVIEWS', 'OLDEST REVIEWS'];

  List<String> sortByEarningItem = ['WEEKLY', 'MONTHLY', 'ALL TIME'];

  void setSortByReview(String? value) {
    sortByReview = value!;
    notifyListeners();
  }

  void setSortByReport(String? value) {
    sortByReport = value!;
    notifyListeners();
  }
}
