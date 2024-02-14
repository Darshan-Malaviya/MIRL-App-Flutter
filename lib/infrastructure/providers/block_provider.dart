import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/user_block_request_model.dart';
import 'package:mirl/infrastructure/models/response/user_block_response_model.dart';
import 'package:mirl/infrastructure/repository/auth_repo.dart';

class BlockProvider extends ChangeNotifier {
  final _authRepository = AuthRepository();

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
}
