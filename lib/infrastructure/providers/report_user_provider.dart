import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/user_report_request_model.dart';
import 'package:mirl/infrastructure/models/response/report_list_response_model.dart';
import 'package:mirl/infrastructure/models/response/user_report_response_model.dart';
import 'package:mirl/infrastructure/repository/report_repo.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';
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

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  // void changeLoading(bool value) {
  //   _isLoading = value;
  //   notifyListeners();
  // }

  List<ReportList> _reportListDetails = [];

  List<ReportList> get reportListDetails => _reportListDetails;

  reportUser() {
    _currentView = 1;
    notifyListeners();
  }

  void thanks(BuildContext context) {
    _currentView = 0;
    context.toPop();
    context.toPop();
    notifyListeners();
  }

  void changeReportAndThanksScreen({required int roleId, required String reportName, required String expertId}) {
    _pages = [
      ReportUserWidget(args: BlockUserArgs(userRole: roleId, reportName: reportName, expertId: expertId)),
      ThanksWidget(reportName: 'BACK TO PROFILE'),
    ];
  }

  Future<void> getAllReportListApiCall({required int role, bool isFullScreenLoader = false}) async {
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: true);
      _isLoading = true;
      notifyListeners();
    } else {
      _isLoading = true;
    }

    ApiHttpResult response = await _reportRepository.reportListApi(limit: 10, page: _reportUserListPageNo, role: role);
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: false);
      _isLoading = false;
      notifyListeners();
    } else {
      _isLoading = false;
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is ReportListResponseModel) {
          ReportListResponseModel responseModel = response.data;
          _reportListDetails.addAll(responseModel.data ?? []);
          if (_reportUserListPageNo == responseModel.pagination?.pageCount) {
            _reachedCategoryLastPage = true;
          } else {
            _reportUserListPageNo = _reportUserListPageNo + 1;
            _reachedCategoryLastPage = false;
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail get all block detail api call ${response.data}");
        break;
    }
    notifyListeners();
  }

  void userReportRequestCall({required int reportListId, required int reportToId}) {
    UserReportRequestModel userReportRequestModel = UserReportRequestModel(reportListId: reportListId, reportToId: reportToId);
    userReportApiCall(requestModel: userReportRequestModel.prepareRequest());
  }

  Future<void> userReportApiCall({required Object requestModel}) async {
    CustomLoading.progressDialog(isLoading: true);
    ApiHttpResult response = await _reportRepository.userReportApi(requestModel: requestModel);
    CustomLoading.progressDialog(isLoading: false);
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is UserReportResponseModel) {
          UserReportResponseModel responseModel = response.data;

          Logger().d("Successfully user report API");
          // FlutterToast().showToast(msg: responseModel.message ?? '');
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail user re[ort api call ${response.data}");
        break;
    }
    notifyListeners();
  }
}
