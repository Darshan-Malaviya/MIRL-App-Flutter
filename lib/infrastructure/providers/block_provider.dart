import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/utils/value_notifier_utils.dart';
import 'package:mirl/infrastructure/models/request/user_block_request_model.dart';
import 'package:mirl/infrastructure/models/response/block_details_response_model.dart';
import 'package:mirl/infrastructure/models/response/un_block_user_response_model.dart';
import 'package:mirl/infrastructure/models/response/user_block_response_model.dart';
import 'package:mirl/infrastructure/repository/auth_repo.dart';

class BlockProvider extends ChangeNotifier {
  final _authRepository = AuthRepository();

  List<BlockDetail> _blockUserDetails = [];

  List<BlockDetail> get blockUserDetails => _blockUserDetails;

  bool get reachedCategoryLastPage => _reachedCategoryLastPage;
  bool _reachedCategoryLastPage = false;

  int get blockUserListPageNo => _blockUserListPageNo;
  int _blockUserListPageNo = 1;

  DateTime? selectedDate;

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  String? userStatus(int index) {
    if (_blockUserDetails[index].status == 1) {
      return LocaleKeys.temporary.tr();
    } else if (_blockUserDetails[index].status == 2) {
      return LocaleKeys.permanent.tr();
    }
    return null;
  }

  Future<void> checkTimeOut({required BuildContext context, required bool isFromInstantCall}) async {
    if (isFromInstantCall && (instanceCallEnumNotifier.value == CallRequestTypeEnum.requestTimeout)) {
      context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 0);
    } else {
      context.toPop();
    }
  }

  Future<void> userBlockRequestCall({
    required int Status,
    required int UserBlockId,
    required BuildContext context,
    bool isFromInstatCall = false,
  }) async {
    UserBlockRequestModel userBlockRequestModel = UserBlockRequestModel(status: Status, userBlockId: UserBlockId);
    await userBlockApiCall(
        requestModel: userBlockRequestModel.prepareRequest(), context: context, isFromInstatCall: isFromInstatCall);
  }

  Future<void> userBlockApiCall({
    required Object requestModel,
    required BuildContext context,
    bool isFromInstatCall = false,
  }) async {
    CustomLoading.progressDialog(isLoading: true);
    ApiHttpResult response = await _authRepository.userBlockApi(requestModel: requestModel);
    // context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen,args: 0);
    CustomLoading.progressDialog(isLoading: false);
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is BlockDetailsResponseModel) {
          BlockDetailsResponseModel userBlockResponseModel = response.data;
          Logger().d("Successfully user block");
          FlutterToast().showToast(msg: userBlockResponseModel.message ?? '');

          if (isFromInstatCall) {
            context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 0);
          } else {
            context.toPop();
          }
          //  context.toPushNamedAndRemoveUntil(RoutesConstants.homeScreen, args: 0);
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on user block api call ${response.data}");
        break;
    }
    //  notifyListeners();
  }

  Future<void> unBlockUserApiCall({required int userBlockId, required int index}) async {
    CustomLoading.progressDialog(isLoading: true);
    ApiHttpResult response = await _authRepository.unBlockUserApi(userBlockId: userBlockId);
    CustomLoading.progressDialog(isLoading: false);
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is UnBlockUserResponseModel) {
          UnBlockUserResponseModel unBlockUserResponseModel = response.data;
          blockUserDetails.removeAt(index);
          Logger().d("Successfully user block");
          FlutterToast().showToast(msg: unBlockUserResponseModel.message ?? '');
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on user block api call ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> getAllBlockListApiCall({bool isFullScreenLoader = false}) async {
    if (isFullScreenLoader) {
      _isLoading = true;
      notifyListeners();
    }
    ApiHttpResult response = await _authRepository.getAllBlockListApi(limit: 10, page: _blockUserListPageNo);
    if (isFullScreenLoader) {
      _isLoading = false;
      notifyListeners();
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is UserBlockResponseModel) {
          UserBlockResponseModel userBlockResponseModel = response.data;
          _blockUserDetails.addAll(userBlockResponseModel.data ?? []);
          if (_blockUserListPageNo == userBlockResponseModel.pagination?.pageCount) {
            _reachedCategoryLastPage = true;
          } else {
            _blockUserListPageNo = _blockUserListPageNo + 1;
            _reachedCategoryLastPage = false;
          }

          Logger().d("Successfully get all block details");
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
