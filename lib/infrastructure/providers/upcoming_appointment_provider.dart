import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/upcoming_appointment_response_model.dart';
import 'package:mirl/infrastructure/repository/schedule_call_repository.dart';

class UpcomingAppointmentProvider extends ChangeNotifier {
  final _scheduleCallRepository = ScheduleCallRepository();

  bool? get isLoading => _isLoading;
  bool? _isLoading = false;

  bool? get isListLoading => _isListLoading;
  bool? _isListLoading = false;

  int get pageNo => pageNo;
  int _pageNo = 1;

  bool get reachedLastPage => _reachedLastPage;
  bool _reachedLastPage = false;

  DateTime? selectedDate;

  List<GetUpcomingAppointment> get upcomingAppointment => _upcomingAppointment;
  List<GetUpcomingAppointment> _upcomingAppointment = [];

  List<String> get dateList => _dateList;
  List<String> _dateList = [];

  bool get visibleCallNowBtn => _visibleCallNowBtn;
  bool _visibleCallNowBtn = false;

  void getSelectedDate(DateTime dateTime, int role) {
    selectedDate = dateTime;
    upcomingAppointmentApiCall(showLoader: false, showListLoader: true, role: role);
    notifyListeners();
  }

  void callNowBtnVisibility(String startTime) {
    DateTime startTimeValue = DateTime.parse(startTime);
    DateTime now = DateTime.now();
    if (startTimeValue.isAtSameMomentAs(now)) {
      // TODO start the call
    } else {
      FlutterToast().showToast(msg: LocaleKeys.startCallToast.tr());
    }
  }

  Future<void> upcomingAppointmentApiCall({required bool showLoader, required bool showListLoader, required int role}) async {
    if (showLoader) {
      _isLoading = true;
      notifyListeners();
    }

    if (showListLoader) {
      _pageNo = 1;
      _reachedLastPage = false;
      _isListLoading = true;
      notifyListeners();
    }

    ApiHttpResult response = await _scheduleCallRepository.viewUpcomingAppointment(
        queryParameters: selectedDate != null
            ? {'page': _pageNo.toString(), 'limit': '10', 'role': role.toString(), 'userId': SharedPrefHelper.getUserId, 'date': selectedDate?.toUtc().toString().split(' ').first}
            : {'page': _pageNo.toString(), 'limit': '10', 'role': role.toString(), 'userId': SharedPrefHelper.getUserId});

    if (showLoader) {
      _isLoading = false;
      notifyListeners();
    }

    if (showListLoader) {
      _isListLoading = false;
      notifyListeners();
    }

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is UpcomingAppointmentResponseModel) {
          UpcomingAppointmentResponseModel responseModel = response.data;
          if (_pageNo == 1) {
            _upcomingAppointment.clear();
          }
          _upcomingAppointment.addAll(responseModel.data?.getUpcomingAppointment ?? []);
          if (responseModel.data?.dateLists?.isNotEmpty ?? false) {
            _dateList.clear();
            responseModel.data?.dateLists?.forEach((element) {
              _dateList.add(element.date?.toLocalDate() ?? '');
            });
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
        Logger().d("API fail on upcomingAppointmentApiCall Api ${response.data}");
        break;
    }
  }
}
