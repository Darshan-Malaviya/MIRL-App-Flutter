import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/update_expert_Profile_request_model.dart';
import 'package:mirl/infrastructure/models/response/city_response_model.dart';
import 'package:mirl/infrastructure/models/response/country_response_model.dart';
import 'package:mirl/infrastructure/models/response/gender_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/repository/update_expert_profile_repo.dart';
import 'package:mirl/infrastructure/commons/extensions/week_days_extension.dart';
import 'package:mirl/infrastructure/models/common/week_schedule_model.dart';
import 'package:mirl/infrastructure/models/request/certificate_request_model.dart';
import 'package:mirl/infrastructure/models/request/expert_availability_request_model.dart';
import 'package:mirl/infrastructure/repository/expert_profile_repo.dart';

class EditExpertProvider extends ChangeNotifier {
  final _updateUserDetailsRepository = UpdateUserDetailsRepository();
  TextEditingController expertNameController = TextEditingController();
  TextEditingController mirlIdController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController yesNoController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankHolderNameController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController countController = TextEditingController(text: "0");

  final _expertProfileRepo = ExpertProfileRepo();

  List<CertificateAndExperienceModel> _certiAndExpModel = [];

  List<CertificateAndExperienceModel> get certiAndExpModel => _certiAndExpModel;

  // UserData? get userData => _userData;
  UserData? _userData;

  String? _selectedGender;

  String? get selectedGender => _selectedGender;

  bool _isCallSelect = false;

  bool _isLocationSelect = false;

  int? isSelectGender = 1;

  // String? _selectedYesNo;
  // String? get selectedYesNo => _selectedYesNo;

  List<String> _locations = ["Yes", "No"];

  List<String> get locations => _locations;

  // ignore: prefer_final_fields
  List<GenderModel> _genderList = [
    GenderModel(title: "Male", isSelected: false, selectType: 1),
    GenderModel(title: "Female", isSelected: false, selectType: 2),
    GenderModel(title: "Other", isSelected: false, selectType: 3)
  ];

  List<GenderModel> get genderList => _genderList;

  // String? get selectedGenderTitle => _selectedGenderTitle;
  // String? _selectedGenderTitle;

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

  CountryModel? _selectedCountryModel;

  // CountryModel? get selectedCountryModel => _selectedCountryModel;

  CityModel? _selectedCityModel;

  // CityModel? get selectedCityModel => _selectedCityModel;

  int get pageNo => _pageNo;
  int _pageNo = 1;

  late DateTime plusDay;
  late DateTime hourOnly;

  void generateExperienceList() {
    _certiAndExpModel.add(
      CertificateAndExperienceModel(
          titleController: TextEditingController(),
          urlController: TextEditingController(),
          descriptionController: TextEditingController(),
          titleFocus: FocusNode(),
          urlFocus: FocusNode(),
          descriptionFocus: FocusNode()),
    );
    notifyListeners();
  }

  void generateWeekDaysTime() {
    var _time = DateTime.now();
    hourOnly = DateTime(_time.year, _time.month, _time.day, 12);
    plusDay = hourOnly.add(Duration(days: 1));
    DateTime lowerValue = hourOnly.add(Duration(hours: 2));
    DateTime upperValue = lowerValue.add(Duration(hours: 2, minutes: 30));

    _weekScheduleModel.addAll([
      WeekScheduleModel(
          dayName: 'MON',
          startTime: lowerValue.millisecondsSinceEpoch.toDouble(),
          endTime: upperValue.millisecondsSinceEpoch.toDouble(),
          isAvailable: true),
      WeekScheduleModel(
          dayName: 'TUE',
          startTime: lowerValue.millisecondsSinceEpoch.toDouble(),
          endTime: upperValue.millisecondsSinceEpoch.toDouble(),
          isAvailable: true),
      WeekScheduleModel(
          dayName: 'WED',
          startTime: lowerValue.millisecondsSinceEpoch.toDouble(),
          endTime: upperValue.millisecondsSinceEpoch.toDouble(),
          isAvailable: true),
      WeekScheduleModel(
          dayName: 'THU',
          startTime: lowerValue.millisecondsSinceEpoch.toDouble(),
          endTime: upperValue.millisecondsSinceEpoch.toDouble(),
          isAvailable: false),
      WeekScheduleModel(
          dayName: 'FRI',
          startTime: lowerValue.millisecondsSinceEpoch.toDouble(),
          endTime: upperValue.millisecondsSinceEpoch.toDouble(),
          isAvailable: true),
      WeekScheduleModel(
          dayName: 'SAT',
          startTime: lowerValue.millisecondsSinceEpoch.toDouble(),
          endTime: upperValue.millisecondsSinceEpoch.toDouble(),
          isAvailable: true),
      WeekScheduleModel(
          dayName: 'SUN',
          startTime: lowerValue.millisecondsSinceEpoch.toDouble(),
          endTime: upperValue.millisecondsSinceEpoch.toDouble(),
          isAvailable: false),
    ]);
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
      certificationList.add(CertificationData(
          title: element.titleController.text.trim(),
          url: element.urlController.text.trim(),
          description: element.descriptionController.text.trim()));
    });
    notifyListeners();
  }

  void setSelectedCountry({required CountryModel value}) {
    _selectedCountryModel = value;
    notifyListeners();
  }

  // void setSelectedCity({required CityModel value}) {
  //   _selectedCityModel = value;
  //   notifyListeners();
  // }

  void displayCountry({required CountryModel value}) {
    countryNameController.text = _selectedCountryModel?.country ?? '';
    //_selectedCountryModel = value;
    notifyListeners();
  }

  void displayCity({required CityModel value}) {
    cityNameController.text = _selectedCityModel?.city ?? '';
    _selectedCityModel = value;
    notifyListeners();
  }

  Future<void> expertAvailabilityApi(BuildContext context, String scheduleType) async {
    getSelectedWeekDays();
    CustomLoading.progressDialog(isLoading: true);

    ExpertAvailabilityRequestModel requestModel =
        ExpertAvailabilityRequestModel(scheduleType: scheduleType, workDays: workDaysList);

    ApiHttpResult response = await _expertProfileRepo.editExpertAvailabilityApi(request: requestModel.toJson());
    CustomLoading.progressDialog(isLoading: false);
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CommonModel) {
          CommonModel commonModel = response.data;
          context.toPop();
          FlutterToast().showToast(msg: commonModel.message ?? '');
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on expert availability Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> expertCertificateApi(BuildContext context) async {
    getCertificateList();
    CustomLoading.progressDialog(isLoading: true);

    CertificateRequestModel requestModel = CertificateRequestModel(certificationData: certificationList);

    ApiHttpResult response = await _expertProfileRepo.editExpertCertificateApi(request: requestModel.toJson());
    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CommonModel) {
          CommonModel commonModel = response.data;
          context.toPop();
          FlutterToast().showToast(msg: commonModel.message ?? '');
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on expert certificate Api ${response.data}");
        break;
    }
  }

  Future<void> expertCertificateDeleteApi({required BuildContext context, required String certiId, required int index}) async {
    CustomLoading.progressDialog(isLoading: true);

    ApiHttpResult response = await _expertProfileRepo.expertCertificateDeleteApi(certiId: certiId);

    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CommonModel) {
          _certiAndExpModel.removeAt(index);
          certificationList.removeAt(index);
          notifyListeners();
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on expert certificate delete Api ${response.data}");
        break;
    }
  }

  // void increaseFees() {
  //   int.parse(countController.text.trim());
  //   _count++;
  //   notifyListeners();
  // }
  //
  // void decreaseFees() {
  //   int.parse(countController.text.trim());
  //   _count--;
  //   notifyListeners();
  // }

  void callSelect(String value) {
    _isCallSelect = (value == 'Yes') ? true : false;
    notifyListeners();
  }

  void locationSelect(String value) {
    _isLocationSelect = (value == 'Yes') ? true : false;
    notifyListeners();
  }

  void setGender(String value) {
    GenderModel data = _genderList.firstWhere((element) => element.title == value);
    isSelectGender = data.selectType;
    notifyListeners();
  }

  void getData() async {
    String value = SharedPrefHelper.getUserData;
    _userData = UserData.fromJson(jsonDecode(value));
    expertNameController.text = _userData?.expertName ?? '';
    mirlIdController.text = _userData?.mirlId ?? '';
    aboutMeController.text = _userData?.about ?? '';

    //phoneNumberController.text = _userData?.phoneNo.toString() ?? '';
    notifyListeners();
  }

  void updateGenderApi() {
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel =
        UpdateExpertProfileRequestModel(genderFlag: true, gender: isSelectGender);
    UpdateUserDetailsApiCall(requestModel: updateExpertProfileRequestModel.toJsonGender());
  }

  void updateFeesApi() {
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(
      feeFlag: true,
      fee: '',
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
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel =
        UpdateExpertProfileRequestModel(instantCallAvailable: _isCallSelect);
    UpdateUserDetailsApiCall(requestModel: updateExpertProfileRequestModel.toJsonInstantCall());
  }

  void updateProfileApi() {
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(expertProfileFlag: true);
    UpdateUserDetailsApiCall(requestModel: updateExpertProfileRequestModel.toJsonProfile());
  }

  Future<void> UpdateUserDetailsApiCall({required FormData requestModel}) async {
    CustomLoading.progressDialog(isLoading: true);

    ApiHttpResult response = await _updateUserDetailsRepository.UpdateUserDetails(requestModel);

    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is LoginResponseModel) {
          LoginResponseModel loginResponseModel = response.data;
          Logger().d("Successfully login");
          NavigationService.context.toPop();
          SharedPrefHelper.saveUserData(jsonEncode(loginResponseModel.data));
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on update user detail call Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> CountryListApiCall() async {
    CustomLoading.progressDialog(isLoading: true);

    ApiHttpResult response = await _updateUserDetailsRepository.countryApiCall(
      limit: 10,
      page: _pageNo,
    );
    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CountryResponseModel) {
          CountryResponseModel countryResponseModel = response.data;
          Logger().d("Successfully");
          _country.addAll(countryResponseModel.data ?? []);
          if (_pageNo == countryResponseModel.pagination?.itemCount) {
            _reachedLastPage = true;
          } else {
            _pageNo = _pageNo + 1;
            _reachedLastPage = false;
          }
          SharedPrefHelper.saveUserData(jsonEncode(countryResponseModel.data));
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on area category call Api ${response.data}");
        break;
    }
    notifyListeners();
  }

  Future<void> cityListApiCall() async {
    CustomLoading.progressDialog(isLoading: true);
    ApiHttpResult response = await _updateUserDetailsRepository.cityApiCall(
        limit: 10, page: _pageNo, countryId: _selectedCountryModel?.id.toString() ?? '');
    CustomLoading.progressDialog(isLoading: false);
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is CityResponseModel) {
          CityResponseModel cityResponseModel = response.data;
          Logger().d("Successfully");
          _city.addAll(cityResponseModel.data ?? []);
          if (_pageNo == cityResponseModel.pagination?.itemCount) {
            _reachedLastPage = true;
          } else {
            _pageNo = _pageNo + 1;
            _reachedLastPage = false;
          }
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on area category call Api ${response.data}");
        break;
    }
    notifyListeners();
  }
}
