import 'dart:async';
import 'dart:developer';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/login_request_model.dart';
import 'package:mirl/infrastructure/models/request/otp_verify_request_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/repository/auth_repo.dart';
import 'package:mirl/infrastructure/services/agora_service.dart';
import 'package:mirl/mirl_app.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final _authRepository = AuthRepository();

  int get secondsRemaining => _secondsRemaining;
  int _secondsRemaining = 120;

  bool get enableResend => _enableResend;
  bool _enableResend = false;
  Timer? timer;

  String _socialId = '';

  LoginResponseModel? loginResponseModel;

  bool isResend = false;
  int start = 60;

  GoogleSignInAccount? _currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: Platform.isIOS ? flavorConfig?.iosClientId : "",
    // scopes: <String>['email', 'profile'],
  );

  startTimer() {
    _secondsRemaining = 120;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _enableResend = true;
        notifyListeners();
      }
    });
  }

  Future<void> loginRequestCall({required int loginType}) async {
    debugPrint('Token=================${SharedPrefHelper.getFirebaseToken}');
    LoginRequestModel loginRequestModel = LoginRequestModel(
      deviceType: Platform.isAndroid ? DeviceType.A.name : DeviceType.I.name,
      email: emailController.text.trim().toString(),
      socialId: _socialId,
      deviceToken: SharedPrefHelper.getFirebaseToken,
      timezone: await CommonMethods.getCurrentTimeZone(),
      loginType: loginType.toString(),
      voIpToken: await AgoraService.singleton.getVoipToken()
    );
    loginApiCall(requestModel: loginRequestModel.prepareRequest(), loginType: loginType);
  }

  Future<void> loginApiCall({required Object requestModel, required int loginType}) async {
    CustomLoading.progressDialog(isLoading: true);
    ApiHttpResult response = await _authRepository.loginCallApi(requestModel: requestModel);
    CustomLoading.progressDialog(isLoading: false);
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is LoginResponseModel) {
          LoginResponseModel loginResponseModel = response.data;
          Logger().d("Successfully login");
          Logger().d("Login data======${loginResponseModel.toJson()}");
          if (loginType == 0) {
            FlutterToast().showToast(msg: loginResponseModel.message ?? '');
            NavigationService.context.toPushNamedAndRemoveUntil(RoutesConstants.otpScreen);
          } else {
            SharedPrefHelper.saveUserData(jsonEncode(loginResponseModel.data));
            SharedPrefHelper.saveUserId(jsonEncode(loginResponseModel.data?.id));
            SharedPrefHelper.saveAuthToken(loginResponseModel.token);
            FlutterToast().showToast(msg: loginResponseModel.message ?? '');
            NavigationService.context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen);
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
      _currentUser = await _googleSignIn.signIn();
      if (_currentUser?.id != null) {
        _socialId = _currentUser?.id ?? '';
        // userName = _currentUser?.displayName ?? '';
        emailController.text = _currentUser?.email ?? '';
        // profilePic = _currentUser?.photoUrl;
        // isNetwork = false;
        loginRequestCall(loginType: LoginType.google);
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
        //  userName = (credential.givenName ?? '') + " " + (credential.familyName ?? '');
        if (credential.email != null) {
          emailController.text = credential.email ?? '';
          if (emailController.text.split('@').last == 'privatelay.appleid.com') {
            emailController.text = '';
          }
        }
        loginRequestCall(loginType: LoginType.apple);
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
        emailController.text = _fbData['email'];
        loginRequestCall(loginType: LoginType.facebook);
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
          Logger().d("Successfully login");
          timer?.cancel();
          SharedPrefHelper.saveUserData(jsonEncode(loginResponseModel.data));
          SharedPrefHelper.saveUserId(jsonEncode(loginResponseModel.data?.id));
          SharedPrefHelper.saveAuthToken(loginResponseModel.token);
          NavigationService.context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen);
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
}
