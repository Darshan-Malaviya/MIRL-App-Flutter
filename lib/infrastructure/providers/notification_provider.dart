import 'dart:async';
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/enums/notification_color_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/notification_list_response_model.dart';
import 'package:mirl/infrastructure/repository/notification_repo.dart';

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

  int? userCount = 0;
  int? expertCount = 0;
  int? generalCount = 0;

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

          userCount = responseModel.data?.userCount;
          expertCount = responseModel.data?.expertCount;
          generalCount = responseModel.data?.generalCount;

          if (_pageNo == 1) {
            _notificationList.clear();
            _notificationList.add(NotificationDetails(id: -1));
          }

          List<NotificationDetails> newNotificationList = [];
          List<NotificationDetails> oldNotificationList = [];
          responseModel.data?.notification?.forEach((element) {
            if(element.notification?.firstCreated.toString().toDisplayDay() == DateTime.now().day.toString()){
              newNotificationList.add(element);
            } else{
              oldNotificationList.add(element);
            }
          });

          _notificationList.addAll(newNotificationList);
          if(_pageNo == 1){
            _notificationList.add(NotificationDetails(id: 0,notification: NotificationListData(key: NotificationTypeEnum.noList.name)));
          }
          _notificationList.addAll(oldNotificationList);

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

  void startTimer(String time) {
    // _secondsRemaining = 120;
    // multiConnectTimer = ValueNotifier(120);
     _secondsRemaining = time.getRemainingTime() ?? 120;
    timer?.cancel();
    if(_secondsRemaining <= 120) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (_secondsRemaining != 0) {
          _secondsRemaining--;
          multiConnectTimer.value = multiConnectTimer.value - 1;
          // notifyListeners();
        } else if (_secondsRemaining == 0) {
          timer?.cancel();
          CommonAlertDialog.dialog(
              context: NavigationService.context,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BodyLargeText(
                    title: 'Notification Timed Out!',
                    fontFamily: FontWeightEnum.w600.toInter,
                    titleColor: ColorConstants.bottomTextColor,
                    fontSize: 17,
                    titleTextAlign: TextAlign.center,
                  ),
                  20.0.spaceY,
                  BodyLargeText(
                    title:
                    'Boo!\nThis notification is now a ghost.\nSpooky how time flies!',
                    maxLine: 4,
                    fontFamily: FontWeightEnum.w400.toInter,
                    titleColor: ColorConstants.blackColor,
                    titleTextAlign: TextAlign.center,
                  ),
                  30.0.spaceY,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BodyMediumText(
                        title: 'Learn more',
                        fontFamily: FontWeightEnum.w500.toInter,
                        titleColor: ColorConstants.bottomTextColor,
                        titleTextAlign: TextAlign.center,
                      ),
                      InkWell(
                        onTap: () => NavigationService.context.toPop(),
                        child: BodyMediumText(
                          title: 'Back',
                          fontFamily: FontWeightEnum.w500.toInter,
                          titleColor: ColorConstants.bottomTextColor,
                          titleTextAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ).addPaddingX(10)
                ],
              ));
        }
      });
    }
  }

  void notifyState() {
    notifyListeners();
  }

// @override
// void dispose() {
//   super.dispose();
//   timer?.cancel();
// }
}