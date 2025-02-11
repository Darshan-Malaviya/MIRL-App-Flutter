import 'dart:async';
import 'dart:developer';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/app_start_up_request_model.dart';
import 'package:mirl/infrastructure/models/request/login_request_model.dart';
import 'package:mirl/infrastructure/models/request/otp_verify_request_model.dart';
import 'package:mirl/infrastructure/models/response/cms_response_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/models/response/un_block_user_response_model.dart';
import 'package:mirl/infrastructure/repository/auth_repo.dart';
import 'package:mirl/infrastructure/services/agora_service.dart';
import 'package:mirl/mirl_app.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../commons/constants/storage_constants.dart';

GoogleSignIn? googleSignIn = GoogleSignIn(
  clientId: Platform.isIOS ? flavorConfig?.iosClientId : "",
  // scopes: <String>['email', 'profile'],
);

class AuthProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final _authRepository = AuthRepository();

  int get secondsRemaining => _secondsRemaining;
  int _secondsRemaining = 120;

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  Timer? timer;

  String _socialId = '';

  LoginResponseModel? loginResponseModel;

  bool isResend = false;
  int start = 60;

  CmsData? _cmsData;

  CmsData? get cmsData => _cmsData;

  void changeIsLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  GoogleSignInAccount? _currentUser;

  void startTimer() {
    // Save the current time as the start time
    SharedPrefHelper.saveString('timer', DateTime.now().toIso8601String());

    _secondsRemaining = 120;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // Calculate the difference between now and the saved start time
      DateTime earlier = DateTime.parse(SharedPrefHelper.getString('timer'));
      Duration difference = DateTime.now().difference(earlier);
      _secondsRemaining = 120 - difference.inSeconds;

      if (_secondsRemaining <= 0) {
        timer?.cancel();
        _secondsRemaining = 0;
      }

      notifyListeners();
    });
  }
  Future<void> loginRequestCall({BuildContext? context, required int loginType, required String email, bool? fromResend = false}) async {
    debugPrint('Token=================${SharedPrefHelper.getFirebaseToken}');
    debugPrint('getVoipToken=================${await AgoraService.singleton.getVoipToken()}');
    LoginRequestModel loginRequestModel = LoginRequestModel(
        deviceType: Platform.isAndroid ? DeviceType.A.name : DeviceType.I.name,
        email: email,
        socialId: _socialId,
        deviceToken: SharedPrefHelper.getFirebaseToken,
        timezone: await CommonMethods.getCurrentTimeZone(),
        loginType: loginType,
        voIpToken: await AgoraService.singleton.getVoipToken(),
        deviceId: await CommonMethods.getDeviceIdentifier(),
    );
    loginApiCall(
      context: context,
      requestModel: email.isNotEmpty ? loginRequestModel.prepareRequest() : loginRequestModel.prepareRequestForAppleWhenEmailEmpty(),
      loginType: loginType,
      fromResend: fromResend,
    );
  }

  Future<void> loginApiCall({BuildContext? context, required Object requestModel, required int loginType, bool? fromResend = false}) async {

    if (loginType == 0) {
      changeIsLoading(true);
    } else {
      CustomLoading.progressDialog(isLoading: true);
    }

    ApiHttpResult response = await _authRepository.loginCallApi(requestModel: requestModel);

    if (loginType == 0) {
      changeIsLoading(false);
    } else {
      CustomLoading.progressDialog(isLoading: false);
    }

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is LoginResponseModel) {
          LoginResponseModel loginResponseModel = response.data;
          if (loginType == 0) {
            FlutterToast().showToast(msg: loginResponseModel.message ?? '');
            if (fromResend == false) {
              context?.toPushNamed(RoutesConstants.otpScreen);
            } else {
              startTimer();
            }
          } else {
            SharedPrefHelper.saveUserData(jsonEncode(loginResponseModel.data));
            SharedPrefHelper.saveAreaOfExpertise((loginResponseModel.data?.areaOfExpertise?.isNotEmpty ?? false) ? true : false);
            SharedPrefHelper.saveUserId(jsonEncode(loginResponseModel.data?.id));
            SharedPrefHelper.saveAuthToken(loginResponseModel.token);
            await SharedPrefHelper.saveString(
                StorageConstants.myReferralCode, loginResponseModel.data?.refCode??"");
            FlutterToast().showToast(msg: loginResponseModel.message ?? '');
            NavigationService.context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 0);
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: loginResponseModel?.err?.message ?? '');
        Logger().d("API fail on login callApi ${response.data}");
        break;
    }
    notifyListeners();
  }

  /// google login
  void signInGoogle() async {
    try {
      _currentUser = await googleSignIn?.signIn();
      if (_currentUser?.id != null) {
        _socialId = _currentUser?.id ?? '';
        // userName = _currentUser?.displayName ?? '';
        // emailController.text = _currentUser?.email ?? '';
        // profilePic = _currentUser?.photoUrl;
        // isNetwork = false;
        loginRequestCall(loginType: LoginType.google, email: _currentUser?.email ?? '');
        log(_currentUser.toString());
      }
    } catch (error) {
      log(error.toString());
    }
  }

  void signInApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      if (credential.userIdentifier != null) {
        _socialId = credential.userIdentifier ?? '';
        if (credential.email != null) {
          // emailController.text = credential.email ?? '';
          if (emailController.text.split('@').last == 'privatelay.appleid.com') {
            emailController.text = '';
          }
        }
        loginRequestCall(loginType: LoginType.apple, email: credential.email ?? '');
      }
    } catch (error) {
      // CustomLoading.loadingDialog(false, NavigationService.context);
      log(error.toString());
    }
  }

  ///  FB login
  void fbLogin() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        Map<String, dynamic>? _fbData = userData;
        _socialId = _fbData['id'];
        //userName = _fbData['name'];
        // emailController.text = _fbData['email'];
        loginRequestCall(loginType: LoginType.facebook, email: _fbData['email']);
      } else {
        // CustomLoading.loadingDialog(false, NavigationService.context);
      }
    } catch (error) {
      log(error.toString());
    }
  }

  /// OTP verify

  void otpVerifyRequestCall() {
    OTPVerifyRequestModel otpVerifyRequestModel = OTPVerifyRequestModel(
      email: emailController.text.trim().toString(),
      otp: otpController.text.trim().toString(),
    );
    otpVerifyApiCall(requestModel: otpVerifyRequestModel.prepareRequest());
  }

  Future<void> otpVerifyApiCall({required Object requestModel}) async {
    CustomLoading.progressDialog(isLoading: true);
    ApiHttpResult response = await _authRepository.otpVerifyCallApi(requestModel: requestModel);
    CustomLoading.progressDialog(isLoading: false);
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is LoginResponseModel) {
          LoginResponseModel loginResponseModel = response.data;
          Logger().d("Login data======${loginResponseModel.toJson()}");
          timer?.cancel();
          SharedPrefHelper.saveUserData(jsonEncode(loginResponseModel.data));
          SharedPrefHelper.saveAreaOfExpertise((loginResponseModel.data?.areaOfExpertise?.isNotEmpty ?? false) ? true : false);
          SharedPrefHelper.saveUserId(jsonEncode(loginResponseModel.data?.id));
          SharedPrefHelper.saveAuthToken(loginResponseModel.token);
          await SharedPrefHelper.saveString(
              StorageConstants.myReferralCode, loginResponseModel.data?.refCode??"");
          NavigationService.context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 0);
          FlutterToast().showToast(msg: loginResponseModel.message ?? '');
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on otp verify call Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  /// cms API call

  Future<void> cmsApiCall(String name) async {
    changeIsLoading(true);
    ApiHttpResult response = await _authRepository.cmsApi(cmsKey: name);
    changeIsLoading(false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CMSResponseModel) {
          CMSResponseModel responseModel = response.data;
          Logger().d("Cms API call successfully${response.data}");
          if (response.data != null && response.data is CMSResponseModel) {
            _cmsData = responseModel.data;
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on cms Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  ///App Start Up API call

  Future<void> appStartUpAPI({required String fcmToken}) async {
    appStartUpRequestModel requestModel = appStartUpRequestModel(
        userId: int.parse(SharedPrefHelper.getUserId), deviceId: await CommonMethods.getDeviceIdentifier(), fcm: fcmToken);
    ApiHttpResult response = await _authRepository.appStartUpAPICall(requestModel: requestModel.prepareRequest());
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is UnBlockUserResponseModel) {
          UnBlockUserResponseModel appStartUpResponseModel = response.data;
          SharedPrefHelper.saveFirebaseToken(fcmToken);
          FlutterToast().showToast(msg: appStartUpResponseModel.message ?? '');
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on App Start Up API call Api ${response.data}");
        break;
    }
  }
// Future<void> getAboutUsHtmlContent(String url) async {
//   _aboutUs = await _authRepository.getHtmlContent(url);
//   changeIsLoading(false);
// }
}
