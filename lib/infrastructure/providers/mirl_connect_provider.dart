import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/get_your_own_referral_code_model.dart';

import '../commons/constants/storage_constants.dart';
import '../models/response/referral_list_response_model.dart';
import '../models/response/submit_referral_code_response_model.dart';
import '../repository/mirl_connect_repo.dart';

class MIRLConnectProvider extends ChangeNotifier {
  final _mirlConnectRepository = MIRLConnectRepository();
  TextEditingController friendReferralCodeController = TextEditingController();

  ReferralListResponseModel responseModel = ReferralListResponseModel();

  bool? get isSubmitLoading => _isSubmitLoading;
  bool? _isSubmitLoading = false;

  bool? get isListLoading => _isListLoading;
  bool? _isListLoading = false;

  Future<bool> getOwnReferralCodeApiCall({required BuildContext context}) async {
    ApiHttpResult response = await _mirlConnectRepository.getOwnReferralCodeApi();
    bool isStatus = false;

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is GetYourOwnReferralCodeModel) {
          GetYourOwnReferralCodeModel responseModel = response.data;
          isStatus = responseModel.isStatus ?? false;
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on getOwnReferralCodeApiCall Api ${response.data}");
        break;
    }
    return isStatus;
  }

  Future<void> submitReferralCodeApiCall({required BuildContext context, required String friendReferralCode}) async {
    _isSubmitLoading = true;
    notifyListeners();
    ApiHttpResult response = await _mirlConnectRepository.submitReferralCodeApi(friendReferralCode: friendReferralCode);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is SubmitReferralCodeModel) {
          SubmitReferralCodeModel responseModel = response.data;
          if (responseModel.isStatus == false) {
            FlutterToast().showToast(msg: responseModel.message ?? '');
          } else {
            mirlConnectView.value = 2;
            if (responseModel.data?.refCode != null) {
              await SharedPrefHelper.saveString(StorageConstants.myReferralCode, responseModel.data?.refCode ?? "");
            }
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on submitReferralCodeApiCall Api ${response.data}");
        break;
    }
    _isSubmitLoading = false;
    notifyListeners();
  }

  int currentPage = 1;
  int totalPage = 1;

  Future<void> referralListApiCall({required BuildContext context, bool isFirstTime = true}) async {
    if (currentPage <= totalPage) {
      _isListLoading = true;
      notifyListeners();
      ApiHttpResult response = await _mirlConnectRepository.getReferralListApi(currentPage: currentPage);
      _isListLoading = false;
      switch (response.status) {
        case APIStatus.success:
          if (response.data != null && response.data is ReferralListResponseModel) {
            if (isFirstTime) {
              responseModel = response.data;
            } else {
              ReferralListResponseModel data = response.data;
              responseModel.data?.refUserlist?.addAll(data.data?.refUserlist ?? []);
            }
            currentPage++;
            totalPage = responseModel.pagination?.pageCount ?? 1;
          }
          break;
        case APIStatus.failure:
          FlutterToast().showToast(msg: response.failure?.message ?? '');
          Logger().d("API fail on referralListApiCall Api ${response.data}");
          break;
      }
      notifyListeners();
    } else {
      FlutterToast().showToast(msg: "No more data");
    }
  }
}
