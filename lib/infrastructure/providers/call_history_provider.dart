import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/call_history_response_model.dart';
import 'package:mirl/infrastructure/repository/schedule_call_repository.dart';

class CallHistoryProvider extends ChangeNotifier {
  final _scheduleCallRepository = ScheduleCallRepository();

  int get pageNo => pageNo;
  int _pageNo = 1;

  bool get reachedLastPage => _reachedLastPage;
  bool _reachedLastPage = false;

  List<CallHistoryData> get callHistoryData => _callHistoryData;
  List<CallHistoryData> _callHistoryData = [];

  bool? get isLoading => _isLoading;
  bool? _isLoading = false;

  bool? get isPaginationLoading => _isPaginationLoading;
  bool? _isPaginationLoading = false;

  void clearPaginationData(){
    _pageNo = 1;
    _reachedLastPage = false;
    _callHistoryData.clear();
  }

  Future<void> callHistoryApiCall({required int role, required bool showLoader, bool isFromPagination = false}) async {
    if (showLoader) {
      _isLoading = true;
      notifyListeners();
    } else {
      if(isFromPagination){
        _isPaginationLoading = true;
        notifyListeners();
      }
    }

    ApiHttpResult response = await _scheduleCallRepository.callHistory(role: role, page: _pageNo, limit: 10);
    if (showLoader) {
      _isLoading = false;
      notifyListeners();
    } else {
      if(isFromPagination){
        _isPaginationLoading = false;
        notifyListeners();
      }
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CallHistoryResponseModel) {
          CallHistoryResponseModel responseModel = response.data;
          if(_pageNo == 1){
            _callHistoryData = responseModel.data ?? [];
          } else {
            _callHistoryData.addAll(responseModel.data ?? []);
          }
          if (_pageNo == responseModel.pagination?.pageCount) {
            _reachedLastPage = true;
          } else {
            _pageNo = _pageNo + 1;
            _reachedLastPage = false;
          }
          Logger().d("Successfully call history details");
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on  call history Api ${response.data}");
        break;
    }
    notifyListeners();
  }
}
