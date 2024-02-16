import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/user_block_request_model.dart';
import 'package:mirl/infrastructure/models/response/un_block_user_response_model.dart';
import 'package:mirl/infrastructure/models/response/user_block_response_model.dart';
import 'package:mirl/infrastructure/repository/auth_repo.dart';

class BlockProvider extends ChangeNotifier {
  final _authRepository = AuthRepository();

  List<BlockDetail> _blockUserDetails = [];

  List<BlockDetail> get blockUserDetails => _blockUserDetails;

  // BlockDetail? _blockDetail;
  // BlockDetail? get blockDetail => _blockDetail;

  String? userStatus(int index) {
    if (_blockUserDetails[index].status == 1) {
      return 'PERMANENT';
    } else if (_blockUserDetails[index].status == 2) {
      return 'TEMPORARY';
    }
    return null;
  }

  void userBlockRequestCall({required int Status}) {
    UserBlockRequestModel userBlockRequestModel = UserBlockRequestModel(status: Status, userBlockId: 1);
    userBlockApiCall(requestModel: userBlockRequestModel.prepareRequest());
  }

  Future<void> userBlockApiCall({required Object requestModel}) async {
    CustomLoading.progressDialog(isLoading: true);
    ApiHttpResult response = await _authRepository.userBlockApi(requestModel: requestModel);
    CustomLoading.progressDialog(isLoading: false);
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is UserBlockResponseModel) {
          UserBlockResponseModel userBlockResponseModel = response.data;
          Logger().d("Successfully user block");
          FlutterToast().showToast(msg: userBlockResponseModel.message ?? '');
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on user block api call ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> unBlockUserApiCall({required int userBlockId,required int index}) async {
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

  Future<void> getAllBlockListApiCall() async {
    CustomLoading.progressDialog(isLoading: true);
    ApiHttpResult response = await _authRepository.getAllBlockListApi(limit: 10, page: 1);
    CustomLoading.progressDialog(isLoading: false);
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is UserBlockResponseModel) {
          UserBlockResponseModel userBlockResponseModel = response.data;
          _blockUserDetails.addAll(userBlockResponseModel.data ?? []);
          Logger().d("Successfully get all block details");
          FlutterToast().showToast(msg: userBlockResponseModel.message ?? '');
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
