import 'package:flutter/cupertino.dart';
import 'package:mirl/ui/screens/block_user/widget/report_user_widget.dart';
import 'package:mirl/ui/screens/block_user/widget/thanks_widget.dart';

class ReportUserProvider extends ChangeNotifier {
  int get currentView => _currentView;
  int _currentView = 0;

  List<Widget> get pages => _pages;
  List<Widget> _pages = [];

  void reportUser() {
    _currentView = 1;
    notifyListeners();
  }

  void thanks() {
    _currentView = 0;
    notifyListeners();
  }

  void changeReportAndThanksScreen() {
    _pages = [
      ReportUserWidget(),
      ThanksWidget(reportName: 'BACK TO PROFILE'),
    ];
  }
}
