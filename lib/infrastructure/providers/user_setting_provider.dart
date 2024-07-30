import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/handler/media_picker_handler/media_picker.dart';
import 'package:mirl/infrastructure/models/request/update_expert_Profile_request_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/repository/update_expert_profile_repo.dart';

class UserSettingProvider extends ChangeNotifier {
  final _updateUserDetailsRepository = UpdateUserDetailsRepository();

  TextEditingController reasonController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String _enteredText = '0';

  String get enteredText => _enteredText;

  String _pickedImage = '';

  String get pickedImage => _pickedImage;

  UserData? _userData;

  Country? _country;
  Country? get country => _country;

  // String get code => _code;
  // String _code = '+91';
  //
  // String get countryName => _countryName;
  // String _countryName = 'IN';
  //
  // void setCountryCode(String value) {
  //   _code = value;
  // }
  //
  // void setCountryName(String value) {
  //   _countryName = value;
  // }

  Future<void> getCountryData(BuildContext context, TickerProvider tickerProvider) async {
    final country = await showCountryPickerSheet(
      context,
      focusSearchBox: true,
      vsync: tickerProvider,
    );
    if (country != null) {
      _country = country;
    }
    notifyListeners();
  }
  Future<void> getDefaultCountryCode(context) async {
    final country = await getDefaultCountry(context);
    _country = country;
    notifyListeners();
  }

  void changeAboutCounterValue(String value) {
    _enteredText = value.length.toString();
    notifyListeners();
  }

  Future<void> pickGalleryImage(BuildContext context) async {
    String? image = await ImagePickerHandler.singleton.pickImageFromGallery(context: context);

    if (image != null && image.isNotEmpty) {
      _pickedImage = image;
      updateProfileApi();
      notifyListeners();
    }
  }

  Future<void> captureCameraImage(BuildContext context) async {
    String? image = await ImagePickerHandler.singleton.capturePhoto(context: context);

    if (image != null && image.isNotEmpty) {
      _pickedImage = image;
      updateProfileApi();
      notifyListeners();
    }
  }

  void getUserSettingData() {
    String value = SharedPrefHelper.getUserData;
    if (value.isNotEmpty) {
      _userData = UserData.fromJson(jsonDecode(value));
      userNameController.text = _userData?.userName?.trim() ?? '';
      emailIdController.text = _userData?.email ?? '';
      phoneNumberController.text = _userData?.phone ?? '';
      _pickedImage = _userData?.userProfile ?? '';
      notifyListeners();
    }
  }

  void updateUserNameApi() {
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(
      userName: userNameController.text.trim(),
    );
    UpdateUserSettingApiCall(requestModel: updateExpertProfileRequestModel.toJsonUserName());
  }

  void updatePhoneNumberApi() {
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(
      // phone: phoneNumberController.text.trim(),
      phone: '${_country?.callingCode.toString()}${phoneNumberController.text.toString().trim()}',
    );
    UpdateUserSettingApiCall(requestModel: updateExpertProfileRequestModel.toJsonPhoneNumber());
  }

  Future<void> updateProfileApi() async {
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(
      userProfile: _pickedImage,
    );
    UpdateUserSettingApiCall(requestModel: await updateExpertProfileRequestModel.toJsonUserProfile(), fromImageUpload: true);
  }

  Future<void> UpdateUserSettingApiCall({required FormData requestModel, bool fromImageUpload = false}) async {
    CustomLoading.progressDialog(isLoading: true);

    ApiHttpResult response = await _updateUserDetailsRepository.updateUserDetails(requestModel);

    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is LoginResponseModel) {
          LoginResponseModel loginResponseModel = response.data;
          SharedPrefHelper.saveUserData(jsonEncode(loginResponseModel.data));
          Logger().d("user data=====${loginResponseModel.toJson()}");
          FlutterToast().showToast(msg: LocaleKeys.profileUpdatedSuccessfully.tr());
          resetVariable();
          getUserSettingData();
          if (!fromImageUpload) {
            NavigationService.context.toPop();
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on update user detail call Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> UserLogoutApiCall({required BuildContext context}) async {
    CustomLoading.progressDialog(isLoading: true);

    ApiHttpResult response = await _updateUserDetailsRepository.userLogout();

    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is LoginResponseModel) {
          await SharedPrefHelper.clearPrefs();
          context.toPushNamedAndRemoveUntil(RoutesConstants.loginScreen);
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on user log out call Api ${response.data}");
        break;
    }
  }

  void resetVariable() {
    emailIdController.clear();
    userNameController.clear();
    phoneNumberController.clear();
  }
}
