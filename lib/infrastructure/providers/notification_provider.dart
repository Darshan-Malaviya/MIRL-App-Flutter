import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/notification_list_response_model.dart';
import 'package:mirl/infrastructure/repository/notification_repo.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/expert_notification_widget.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/general_notification_widget.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/user_notification_widget.dart';

class NotificationProvider extends ChangeNotifier {
  final _notificationRepository = NotificationRepository();

  int get currentView => _currentView;
  int _currentView = 0;

  bool get isVisible => _isVisible;
  bool _isVisible = false;

  List<Widget> get pages => _pages;
  List<Widget> _pages = [];

  int get secondsRemaining => _secondsRemaining;
  int _secondsRemaining = 120;

  Timer? timer;

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  bool get isPageLoading => _isPageLoading;
  bool _isPageLoading = false;

  bool get reachedLastPage => _reachedLastPage;
  bool _reachedLastPage = false;

  int get pageNo => _pageNo;
  int _pageNo = 1;

  List<NotificationDetails> get notificationList => _notificationList;
  List<NotificationDetails> _notificationList = [];

  void expertNotification() {
    _currentView = 0;
    notifyListeners();
  }

  void userNotification() {
    _currentView = 1;
    notifyListeners();
  }

  void generalNotification() {
    _currentView = 2;
    notifyListeners();
  }

  void changeReportAndThanksScreen() {
    _pages = [
      ExpertNotificationWidget(),
      UserNotificationWidget(),
      GeneralNotificationWidget(),
    ];
  }

  Future<void> getNotificationListApiCall({required int type, bool isFullScreenLoader = false, bool pageLoading = false}) async {
    if (isFullScreenLoader) {
      _pageNo = 1;
      _reachedLastPage = false;
      _isLoading = true;
      notifyListeners();
    }

    if (pageLoading) {
      _isPageLoading = true;
      notifyListeners();
    }

    ApiHttpResult response = await _notificationRepository.notificationListApi(limit: 30, page: _pageNo, type: type);

    if (isFullScreenLoader) {
      _isLoading = false;
      notifyListeners();
    }

    if (pageLoading) {
      _isPageLoading = false;
      notifyListeners();
    }

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is NotificationListResponseModel) {
          NotificationListResponseModel responseModel = response.data;

          if(pageLoading) {
            _notificationList.clear();
          }

          _notificationList.addAll(responseModel.data?.notification ?? []);

          if (_pageNo == responseModel.pagination?.pageCount) {
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
        Logger().d("API fail get all notification api call ${response.data}");
        break;
    }
  }

  startTimer() {
    _secondsRemaining = 120;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        _secondsRemaining--;
        notifyListeners();
      }
    });
  }

// @override
// void dispose() {
//   super.dispose();
//   timer?.cancel();
// }
}
