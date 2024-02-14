import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/repository/schedule_call_repository.dart';

class ViewUpcomingAppointmentProvider extends ChangeNotifier {
  final _scheduleCallRepository = ScheduleCallRepository();

  bool? get isLoading => _isLoading;
  bool? _isLoading = false;

  int get pageNo => pageNo;
  int _pageNo = 1;

  bool get reachedLastPage => _reachedLastPage;
  bool _reachedLastPage = false;

  Future<void> upcomingAppointmentApiCall({required BuildContext context, required bool showLoader}) async {
    if (showLoader) {
      _isLoading = true;
      notifyListeners();
    }

    ApiHttpResult response = await _scheduleCallRepository.viewUpcomingAppointment(queryParameters: {'page': _pageNo.toString(), 'limit': '10', 'expertId': '1', 'userId': '4'});

    if (showLoader) {
      _isLoading = false;
      notifyListeners();
    }

    switch (response.status) {
      case APIStatus.success:
        /*      if (response.data != null && response.data is CancelAppointmentResponseModel) {
          CancelAppointmentResponseModel responseModel = response.data;
        }*/
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on upcomingAppointmentApiCall Api ${response.data}");
        break;
    }
  }
}
