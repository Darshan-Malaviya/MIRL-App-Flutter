import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/handler/media_picker_handler/media_picker.dart';
import 'package:mirl/infrastructure/models/request/update_expert_Profile_request_model.dart';
import 'package:mirl/infrastructure/models/response/certificate_response_model.dart';
import 'package:mirl/infrastructure/models/response/city_response_model.dart';
import 'package:mirl/infrastructure/models/response/country_response_model.dart';
import 'package:mirl/infrastructure/models/response/gender_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/models/response/week_availability_response_model.dart';
import 'package:mirl/infrastructure/repository/update_expert_profile_repo.dart';
import 'package:mirl/infrastructure/commons/extensions/week_days_extension.dart';
import 'package:mirl/infrastructure/models/common/week_schedule_model.dart';
import 'package:mirl/infrastructure/models/request/certificate_request_model.dart';
import 'package:mirl/infrastructure/models/request/expert_availability_request_model.dart';
import 'package:mirl/infrastructure/repository/expert_profile_repo.dart';

class EditExpertProvider extends ChangeNotifier {
  final _updateUserDetailsRepository = UpdateUserDetailsRepository();
  TextEditingController expertNameController = TextEditingController();
  TextEditingController searchCityController = TextEditingController();
  TextEditingController searchCountryController = TextEditingController();
  TextEditingController mirlIdController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController instantCallAvailabilityController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankHolderNameController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController countController = TextEditingController(text: '0');

  final _expertProfileRepo = ExpertProfileRepo();

  List<CertificateAndExperienceModel> _certiAndExpModel = [];

  List<CertificateAndExperienceModel> get certiAndExpModel => _certiAndExpModel;

  UserData? _userData;

  String? _selectedGender;

  String? get selectedGender => _selectedGender;

  bool _isCallSelect = false;

  bool _isLocationSelect = false;

  int? isSelectGender = 1;

  List<String> _locations = ["Yes", "No"];

  List<String> get locations => _locations;

  String _pickedImage = '';

  String get pickedImage => _pickedImage;

  String _setInstantCall = '';

  String get setInstantCall => _setInstantCall;

  List<CommonSelectionModel> _genderList = [
    CommonSelectionModel(title: "Male", isSelected: false, selectType: 1),
    CommonSelectionModel(title: "Female", isSelected: false, selectType: 2),
    CommonSelectionModel(title: "Other", isSelected: false, selectType: 3)
  ];

  List<CommonSelectionModel> get genderList => _genderList;

  List<CommonSelectionModel> _editButtonList = [
    CommonSelectionModel(title: StringConstants.setYourFee, isSelected: false, screenName: RoutesConstants.setYourFreeScreen),
    CommonSelectionModel(title: StringConstants.areasOfExpertise, isSelected: false, screenName: RoutesConstants.addYourAreasOfExpertiseScreen),
    CommonSelectionModel(title: StringConstants.weeklyAvailability, isSelected: false, screenName: RoutesConstants.setWeeklyAvailability),
    CommonSelectionModel(title: StringConstants.callsAvailability, isSelected: false, screenName: RoutesConstants.instantCallsAvailabilityScreen),
    CommonSelectionModel(title: StringConstants.setYourLocation, isSelected: false, screenName: RoutesConstants.setYourLocationScreen),
    CommonSelectionModel(title: StringConstants.setYourGender, isSelected: false, screenName: RoutesConstants.setYourGenderScreen),
    CommonSelectionModel(title: StringConstants.addCertifications, isSelected: false, screenName: RoutesConstants.certificationsAndExperienceScreen),
    CommonSelectionModel(title: StringConstants.bankAccountDetails, isSelected: false, screenName: RoutesConstants.yourBankAccountDetailsScreen)
  ];

  List<CommonSelectionModel> get editButtonList => _editButtonList;

  List<WeekScheduleModel> _weekScheduleModel = [];

  List<WeekScheduleModel> get weekScheduleModel => _weekScheduleModel;

  List<WorkDays> workDaysList = [];

  List<CertificationData> certificationList = [];

  List<CountryModel> get country => _country;
  List<CountryModel> _country = [];

  List<CityModel> get city => _city;
  List<CityModel> _city = [];

  bool get reachedLastPage => _reachedLastPage;
  bool _reachedLastPage = false;

  bool get reachedCityLastPage => _reachedCityLastPage;
  bool _reachedCityLastPage = false;

  CountryModel? _selectedCountryModel;

  CityModel? _selectedCityModel;

  int get pageNo => _pageNo;
  int _pageNo = 1;

  int get cityPageNo => _cityPageNo;
  int _cityPageNo = 1;

  late DateTime plusDay;
  late DateTime hourOnly;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  int _tabIndex = 0;

  int get tabIndex => _tabIndex;

  String _enteredText = '';

  String get enteredText => _enteredText;

  String expertName = '';
  String mirlId = '';
  String aboute = '';

  void generateExperienceList({required bool fromInit}) {
    if (fromInit && (_userData?.certification?.isNotEmpty ?? false)) {
      _certiAndExpModel.clear();
      _userData?.certification?.forEach((element) {
        _certiAndExpModel.add(CertificateAndExperienceModel(
            id: element.id,
            titleController: TextEditingController(text: element.title ?? ''),
            urlController: TextEditingController(text: element.url ?? ''),
            descriptionController: TextEditingController(text: element.description ?? ''),
            titleFocus: FocusNode(),
            urlFocus: FocusNode(),
            descriptionFocus: FocusNode()));
      });
    } else {
      _certiAndExpModel.add(
        CertificateAndExperienceModel(
            id: null,
            titleController: TextEditingController(),
            urlController: TextEditingController(),
            descriptionController: TextEditingController(),
            titleFocus: FocusNode(),
            urlFocus: FocusNode(),
            descriptionFocus: FocusNode()),
      );
    }
    notifyListeners();
  }

  void generateWeekDaysTime() {
    _weekScheduleModel.clear();
    _tabIndex = 0;
    var _time = DateTime.now();
    hourOnly = DateTime(_time.year, _time.month, _time.day, 0, 0, 0);
    plusDay = hourOnly.add(Duration(days: 1));
    DateTime lowerValue = hourOnly.add(Duration(hours: 10));
    DateTime upperValue = lowerValue.add(Duration(hours: 7));

    if (_userData?.expertAvailability?.isNotEmpty ?? false) {
      _userData?.expertAvailability?.forEach((element) {
        _weekScheduleModel.add(WeekScheduleModel(
          dayName: element.dayOfWeek?.substring(0, 3).toUpperCase(),
          startTime: double.parse(element.startTime?.toLocaleFromUtc()?.millisecondsSinceEpoch.toString() ?? lowerValue.millisecondsSinceEpoch.toString()),
          endTime: double.parse(element.endTime?.toLocaleFromUtc()?.millisecondsSinceEpoch.toString() ?? upperValue.millisecondsSinceEpoch.toString()),
          isAvailable: element.isAvailable ?? false,
        ));
      });
    } else {
      _weekScheduleModel.addAll([
        WeekScheduleModel(dayName: 'MON', startTime: lowerValue.millisecondsSinceEpoch.toDouble(), endTime: upperValue.millisecondsSinceEpoch.toDouble(), isAvailable: true),
        WeekScheduleModel(dayName: 'TUE', startTime: lowerValue.millisecondsSinceEpoch.toDouble(), endTime: upperValue.millisecondsSinceEpoch.toDouble(), isAvailable: true),
        WeekScheduleModel(dayName: 'WED', startTime: lowerValue.millisecondsSinceEpoch.toDouble(), endTime: upperValue.millisecondsSinceEpoch.toDouble(), isAvailable: true),
        WeekScheduleModel(dayName: 'THU', startTime: lowerValue.millisecondsSinceEpoch.toDouble(), endTime: upperValue.millisecondsSinceEpoch.toDouble(), isAvailable: false),
        WeekScheduleModel(dayName: 'FRI', startTime: lowerValue.millisecondsSinceEpoch.toDouble(), endTime: upperValue.millisecondsSinceEpoch.toDouble(), isAvailable: true),
        WeekScheduleModel(dayName: 'SAT', startTime: lowerValue.millisecondsSinceEpoch.toDouble(), endTime: upperValue.millisecondsSinceEpoch.toDouble(), isAvailable: true),
        WeekScheduleModel(dayName: 'SUN', startTime: lowerValue.millisecondsSinceEpoch.toDouble(), endTime: upperValue.millisecondsSinceEpoch.toDouble(), isAvailable: false),
      ]);
    }
    notifyListeners();
  }

  void changeSelectedScreenButtonColor(BuildContext context, int index) {
    _editButtonList.forEach((element) {
      element.isSelected = false;
    });
    _editButtonList[index].isSelected = !(_editButtonList[index].isSelected ?? false);
    context.toPushNamed(editButtonList[index].screenName ?? '');
    notifyListeners();
  }

  void changeWeekAvailability(int index) {
    _weekScheduleModel[index].isAvailable = !_weekScheduleModel[index].isAvailable;
    notifyListeners();
  }

  void changeTime(int index, double start, double end) {
    _weekScheduleModel[index].startTime = start;
    _weekScheduleModel[index].endTime = end;
    notifyListeners();
  }

  void getSelectedWeekDays() {
    workDaysList.clear();
    _weekScheduleModel.forEach((element) {
      workDaysList.add(WorkDays(
        dayOfWeek: element.dayName?.toLowerCase().weekDayString.toLowerCase(),
        startTime: element.startTime.toInt().toString().toUTCDateTimeFormat(),
        endTime: element.endTime.toInt().toString().toUTCDateTimeFormat(),
        isAvailable: element.isAvailable ? 1 : 0,
      ));
    });
    notifyListeners();
  }

  void getCertificateList() {
    certificationList.clear();
    _certiAndExpModel.forEach((element) {
      certificationList
          .add(CertificationData(title: element.titleController.text.trim(), url: element.urlController.text.trim(), description: element.descriptionController.text.trim()));
    });
    notifyListeners();
  }

  void setSelectedCountry({required CountryModel value}) {
    _selectedCountryModel = value;
    countryNameController.text = _selectedCountryModel?.country ?? '';
    notifyListeners();
  }

  void displayCity({required CityModel value}) {
    _selectedCityModel = value;
    cityNameController.text = _selectedCityModel?.city ?? '';
    notifyListeners();
  }

  void getTabIndex(int index) {
    _tabIndex = index;
    notifyListeners();
  }

  void changeAboutCounterValue(String value) {
    _enteredText = value.length.toString();
    notifyListeners();
  }

  void getUserData() {
    String value = SharedPrefHelper.getUserData;
    if (value.isNotEmpty) {
      _userData = UserData.fromJson(jsonDecode(value));
      expertNameController.text = _userData?.expertName ?? '';
      expertName = _userData?.expertName ?? '';
      _pickedImage = _userData?.expertProfile ?? '';
      mirlIdController.text = _userData?.mirlId ?? '';
      mirlId = _userData?.mirlId ?? '';
      aboutMeController.text = _userData?.about ?? '';
      aboute = _userData?.about ?? '';
      _enteredText = _userData?.about?.length.toString() ?? '';
      countryNameController.text = _userData?.country ?? '';
      cityNameController.text = _userData?.city ?? '';
      bankHolderNameController.text = _userData?.bankAccountHolderName ?? '';
      bankNameController.text = _userData?.bankName ?? '';
      accountNumberController.text = _userData?.accountNumber ?? '';
      countController.text = (int.parse(_userData?.fee ?? '0') / 100).toString();
      instantCallAvailabilityController.text = _locations.firstWhere((element) => element == (_userData?.instantCallAvailable == true ? 'Yes' : 'No'));
      locationController.text = _locations.firstWhere((element) => element == (_userData?.isLocationVisible == true ? 'Yes' : 'No'));
      CommonSelectionModel genderModel = _genderList.firstWhere((element) => element.selectType.toString() == _userData?.gender);
      genderController.text = genderModel.title ?? '';
      notifyListeners();
    }
  }

  Future<void> expertAvailabilityApi(BuildContext context, String scheduleType) async {
    getSelectedWeekDays();
    CustomLoading.progressDialog(isLoading: true);

    ExpertAvailabilityRequestModel requestModel = ExpertAvailabilityRequestModel(scheduleType: scheduleType, workDays: workDaysList);

    ApiHttpResult response = await _expertProfileRepo.editExpertAvailabilityApi(request: requestModel.toJson());
    CustomLoading.progressDialog(isLoading: false);
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is WeekAvailabilityResponseModel) {
          WeekAvailabilityResponseModel responseModel = response.data;
          _userData?.expertAvailability?.clear();
          _userData?.expertAvailability?.addAll(responseModel.data ?? []);
          SharedPrefHelper.saveUserData(jsonEncode(_userData));
          notifyListeners();
          context.toPop();
          FlutterToast().showToast(msg: responseModel.message ?? '');
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on expert availability Api ${response.data}");
        break;
    }
  }

  Future<void> expertCertificateApi(BuildContext context) async {
    getCertificateList();
    CustomLoading.progressDialog(isLoading: true);

    CertificateRequestModel requestModel = CertificateRequestModel(certificationData: certificationList);

    ApiHttpResult response = await _expertProfileRepo.editExpertCertificateApi(request: requestModel.toJson());
    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CertificateResponseModel) {
          CertificateResponseModel responseModel = response.data;
          _userData?.certification?.clear();
          _userData?.certification?.addAll(responseModel.data ?? []);
          SharedPrefHelper.saveUserData(jsonEncode(_userData));
          _certiAndExpModel.clear();
          certificationList.clear();
          notifyListeners();
          context.toPop();
          FlutterToast().showToast(msg: responseModel.message ?? '');
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on expert certificate Api ${response.data}");
        break;
    }
  }

  Future<void> expertCertificateDeleteApi({required BuildContext context, required int? certiId, required int index}) async {
    if (certiId == null) {
      _certiAndExpModel.removeAt(index);
      notifyListeners();
    } else {
      CustomLoading.progressDialog(isLoading: true);

      ApiHttpResult response = await _expertProfileRepo.expertCertificateDeleteApi(certiId: certiId);

      CustomLoading.progressDialog(isLoading: false);

      switch (response.status) {
        case APIStatus.success:
          if (response.data != null && response.data is CommonModel) {
            _certiAndExpModel.removeAt(index);
            notifyListeners();
          }
          break;
        case APIStatus.failure:
          FlutterToast().showToast(msg: response.failure?.message ?? '');
          Logger().d("API fail on expert certificate delete Api ${response.data}");
          break;
      }
    }
  }

  void increaseFees() {
    double plusValue = double.parse(countController.text.trim());
    countController.text = (plusValue + 1).toString();
    notifyListeners();
  }

  void decreaseFees() {
    double minusValue = double.parse(countController.text.trim());
    countController.text = (minusValue - 1).toString();
    notifyListeners();
  }

  void setValueOfCall(String value) {
    _isCallSelect = (value == 'Yes') ? true : false;
    notifyListeners();
  }

  void locationSelect(String value) {
    _isLocationSelect = (value == 'Yes') ? true : false;
    notifyListeners();
  }

  void setGender(String value) {
    CommonSelectionModel data = _genderList.firstWhere((element) => element.title == value);
    isSelectGender = data.selectType;
    notifyListeners();
  }

  Future<void> pickGalleryImage(BuildContext context) async {
    String? image = await ImagePickerHandler.singleton.pickImageFromGallery(context: context);

    if (image != null && image.isNotEmpty) {
      _pickedImage = image;
      notifyListeners();
    }
  }

  Future<void> captureCameraImage(BuildContext context) async {
    String? image = await ImagePickerHandler.singleton.capturePhoto(context: context);

    if (image != null && image.isNotEmpty) {
      _pickedImage = image;
      notifyListeners();
    }
  }

  void updateGenderApi() {
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(genderFlag: true, gender: isSelectGender);
    UpdateUserDetailsApiCall(requestModel: updateExpertProfileRequestModel.toJsonGender());
  }

  void updateFeesApi() {
    int feesValue = (double.parse(countController.text) * 100).toInt();
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(
      feeFlag: true,
      fee: feesValue.toString(),
    );
    UpdateUserDetailsApiCall(requestModel: updateExpertProfileRequestModel.toJsonFees());
  }

  void updateAboutApi() {
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(
      aboutFlag: true,
      about: aboutMeController.text.trim(),
    );
    UpdateUserDetailsApiCall(requestModel: updateExpertProfileRequestModel.toJsonAbout());
  }

  void updateBankApi() {
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(
      bankDetailsFlag: true,
      bankName: bankNameController.text.trim(),
      bankAccountHolderName: bankHolderNameController.text.trim(),
      accountNumber: accountNumberController.text.trim(),
    );
    UpdateUserDetailsApiCall(requestModel: updateExpertProfileRequestModel.toJsonBank());
  }

  void updateMirlIdApi() {
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(
      mirlId: mirlIdController.text.trim(),
    );
    UpdateUserDetailsApiCall(requestModel: updateExpertProfileRequestModel.toJsonMirlId());
  }

  void updateExpertNameApi() {
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(
      expertName: expertNameController.text.trim(),
    );
    UpdateUserDetailsApiCall(requestModel: updateExpertProfileRequestModel.toJsonName());
  }

  void updateYourLocationApi() {
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(
      city: cityNameController.text.trim(),
      country: countryNameController.text.trim(),
      locationFlag: true,
      isLocationVisible: _isLocationSelect,
    );
    UpdateUserDetailsApiCall(requestModel: updateExpertProfileRequestModel.toJsonYourLocation());
  }

  void updateInstantCallApi() {
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(instantCallAvailable: _isCallSelect);
    UpdateUserDetailsApiCall(requestModel: updateExpertProfileRequestModel.toJsonInstantCall());
  }

  Future<void> updateProfileApi() async {
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(expertProfile: _pickedImage);
    UpdateUserDetailsApiCall(requestModel: await updateExpertProfileRequestModel.toJsonProfile(),fromImageUpload: true);
  }

  Future<void> UpdateUserDetailsApiCall({required FormData requestModel, bool fromImageUpload = false}) async {
    CustomLoading.progressDialog(isLoading: true);

    ApiHttpResult response = await _updateUserDetailsRepository.updateUserDetails(requestModel);

    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is LoginResponseModel) {
          LoginResponseModel loginResponseModel = response.data;
          SharedPrefHelper.saveUserData(jsonEncode(loginResponseModel.data));
          Logger().d("Successfully updated");
          Logger().d("user data=====${loginResponseModel.toJson()}");
          resetVariable();
          getUserData();
          if(!fromImageUpload) {
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

  Future<void> CountryListApiCall({bool isFullScreenLoader = false, String? searchName}) async {
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: true);
    }

    ApiHttpResult response = await _updateUserDetailsRepository.countryApiCall(limit: 30, page: _pageNo, searchName: searchName);
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: false);
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CountryResponseModel) {
          CountryResponseModel countryResponseModel = response.data;
          Logger().d("Successfully call country list");
          _country.addAll(countryResponseModel.data ?? []);
          if (_pageNo == countryResponseModel.pagination?.itemCount) {
            _reachedLastPage = true;
          } else {
            _pageNo = _pageNo + 1;
            _reachedLastPage = false;
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on country list call Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> cityListApiCall({bool isFullScreenLoader = false, String? searchName}) async {
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: true);
    }
    ApiHttpResult response =
        await _updateUserDetailsRepository.cityApiCall(limit: 30, page: _cityPageNo, countryId: _selectedCountryModel?.id.toString() ?? '', searchName: searchName);
    if (isFullScreenLoader) {
      CustomLoading.progressDialog(isLoading: false);
    }
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CityResponseModel) {
          CityResponseModel cityResponseModel = response.data;
          Logger().d("Successfully call city list api");
          _city.addAll(cityResponseModel.data ?? []);
          if (_cityPageNo == cityResponseModel.pagination?.itemCount) {
            _reachedCityLastPage = true;
          } else {
            _cityPageNo = _cityPageNo + 1;
            _reachedCityLastPage = false;
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on city list call Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  void clearCityPaginationData() {
    _cityPageNo = 1;
    _reachedCityLastPage = false;
    _city = [];
    notifyListeners();
  }

  void clearSearchCityController() {
    searchCityController.clear();
    notifyListeners();
  }

  void clearCountryPaginationData() {
    _pageNo = 1;
    _reachedLastPage = false;
    _country = [];
    notifyListeners();
  }

  void clearSearchCountryController() {
    searchCountryController.clear();
    notifyListeners();
  }

  void resetVariable() {
    countController.text = '0';
    _enteredText = '';
    expertNameController.clear();
    mirlIdController.clear();
    aboutMeController.clear();
    genderController.clear();
    instantCallAvailabilityController.clear();
    locationController.clear();
    bankNameController.clear();
    accountNumberController.clear();
    bankHolderNameController.clear();
    countryNameController.clear();
  }
}
