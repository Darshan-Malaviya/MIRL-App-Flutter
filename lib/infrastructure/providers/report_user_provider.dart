import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/report_list_response_model.dart';
import 'package:mirl/infrastructure/repository/report_repo.dart';
import 'package:mirl/ui/screens/block_user/widget/report_user_widget.dart';
import 'package:mirl/ui/screens/block_user/widget/thanks_widget.dart';

class ReportUserProvider extends ChangeNotifier {
  final _reportRepository = ReportListRepository();

  int get currentView => _currentView;
  int _currentView = 0;

  List<Widget> get pages => _pages;
  List<Widget> _pages = [];

  bool get reachedCategoryLastPage => _reachedCategoryLastPage;
  bool _reachedCategoryLastPage = false;

  int get reportUserListPageNo => _reportUserListPageNo;
  int _reportUserListPageNo = 1;

  List<ReportList> _reportListDetails = [];

  List<ReportList> get reportListDetails => _reportListDetails;

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
      ReportUserWidget(roleId: 1, reportName: ''),
      ThanksWidget(reportName: 'BACK TO PROFILE'),
    ];
  }

  Future<void> getAllBlockListApiCall({required int role}) async {
    CustomLoading.progressDialog(isLoading: true);
    ApiHttpResult response = await _reportRepository.reportListApi(limit: 10, page: _reportUserListPageNo, role: role);
    CustomLoading.progressDialog(isLoading: false);
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is ReportListResponseModel) {
          ReportListResponseModel responseModel = response.data;
          _reportListDetails.addAll(responseModel.data ?? []);
          if (_reportUserListPageNo == responseModel.pagination?.itemCount) {
            _reachedCategoryLastPage = true;
          } else {
            _reportUserListPageNo = _reportUserListPageNo + 1;
            _reachedCategoryLastPage = false;
          }

          Logger().d("Successfully get all block details");
          FlutterToast().showToast(msg: responseModel.message ?? '');
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail get all block detail api call ${response.data}");
        break;
    }
    notifyListeners();
  }
}
