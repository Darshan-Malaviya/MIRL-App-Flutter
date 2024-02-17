import 'package:logger/logger.dart';
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

  void getSelectedDate(DateTime dateTime) {
    selectedDate = dateTime;
    upcomingAppointmentApiCall(showLoader: false, showListLoader: true);
    notifyListeners();
  }

  Future<void> upcomingAppointmentApiCall({required bool showLoader, required bool showListLoader}) async {
    if (showLoader) {
      _isLoading = true;
      notifyListeners();
    }

    if (showListLoader) {
      _isListLoading = true;
      notifyListeners();
    }

    ApiHttpResult response = await _scheduleCallRepository.viewUpcomingAppointment(queryParameters: {
      'page': _pageNo.toString(),
      'limit': '10',
      'role': '2',
      'userId': SharedPrefHelper.getUserId,
      'date': selectedDate?.toUtc().toString().split(' ').first,
    });

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
          _upcomingAppointment.clear();
          _upcomingAppointment.addAll(responseModel.data?.getUpcomingAppointment ?? []);
          if (responseModel.data?.dateLists?.isNotEmpty ?? false) {
            _dateList.clear();
            responseModel.data?.dateLists?.forEach((element) {
              _dateList.add(element.date?.toLocalDate() ?? '');
            });
          }
          print(_dateList);

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
