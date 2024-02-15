import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/expert_notification_widget.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/general_notification_widget.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/user_notification_widget.dart';

class NotificationProvider extends ChangeNotifier {
  int get currentView => _currentView;
  int _currentView = 0;

  List<Widget> get pages => _pages;
  List<Widget> _pages = [];

  int get secondsRemaining => _secondsRemaining;
  int _secondsRemaining = 120;

  Timer? timer;

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
}
