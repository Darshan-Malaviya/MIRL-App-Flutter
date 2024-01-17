import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/update_expert_Profile_request_model.dart';
import 'package:mirl/infrastructure/models/response/country_response_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/repository/update_expert_profile_repo.dart';

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
  TextEditingController countController = TextEditingController(text: "0");

  List<CertificateAndExperienceModel> _certiAndExpModel = [];

  List<CertificateAndExperienceModel> get certiAndExpModel => _certiAndExpModel;

  UserData? get userData => _userData;
  UserData? _userData;

  @override
  // TODO: implement hashCode
  // int _count = 0;
  //
  // int get count => _count;

  String? _selectedGender;

  String? get selectedGender => _selectedGender;
  String? _selectedYesNo;

  bool _isSelect = false;

  bool get isSelect => _isSelect;
  int _isSelectGender = 1;

  int get isSelectGender => _isSelectGender;

  String? get selectedYesNo => _selectedYesNo;

  List<String> _locations = ["Yes", "No"];

  List<String> get locations => _locations;

  // ignore: prefer_final_fields
  List<String> _genderList = [
    'Male', 'Female', 'Other'
    // Gender(title: "Male", isSelected: false, selectType: 1),
    // Gender(title: "Female", isSelected: false, selectType: 2),
    // Gender(title: "Other", isSelected: false, selectType: 3)
  ];

  List<String> get genderList => _genderList;

  String? get selectedGenderTitle => _selectedGenderTitle;
  String? _selectedGenderTitle;
  int _count = 0;



  //int get count => model.count;

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

  void deleteExperience(int index) {
    _certiAndExpModel.removeAt(index);
    notifyListeners();
  }

  void counter() {
    int.parse(countController.text.trim());
    _count++;
    notifyListeners();
  }

  void removeCount() {
    int.parse(countController.text.trim());
    _count--;
    notifyListeners();
  }

  // void setGender(String value) {
  //   _genderList;
  //   notifyListeners();
  // }
  List<countryList> get getByIdList => _getByIdList;
  final List<countryList> _getByIdList = [];

  void setYesNo(String value) {
    _isSelect = (value == 'Yes') ? true : false;
    notifyListeners();
  }

  // void setGender(String value) {
  //   _isSelectGender = value;
  //   _isSelectGender = value;
  //   notifyListeners();
  // }

  // void onGenderTap(int index) {
  //   for (var element in _genderList) {
  //     element.isSelected = false;
  //   }
  //   _genderList[index].isSelected = !(_genderList[index].isSelected ?? false);
  //   int newIndex = _genderList.indexWhere((element) => element.isSelected == true);
  //   _selectedGenderTitle = _genderList[newIndex].title;
  //   notifyListeners();
  // }

  getData() async {
    String value = SharedPrefHelper.getUserData;
    _userData = UserData.fromJson(jsonDecode(value));
    expertNameController.text = _userData?.expertName ?? '';
    mirlIdController.text = _userData?.mirlId ?? '';
    aboutMeController.text = _userData?.about ?? '';

    //phoneNumberController.text = _userData?.phoneNo.toString() ?? '';
    notifyListeners();
  }

  Future<void> UpdateUserDetailsApiCall() async {
    CustomLoading.progressDialog(isLoading: true);

    ApiHttpResult response;
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(
        expertName: expertNameController.text.trim(),
        expertProfileFlag: true,
        mirlId: mirlIdController.text.trim(),
        about: aboutMeController.text.trim(),
        aboutFlag: true,
        bankName: bankNameController.text.trim(),
        bankAccountHolderName: bankHolderNameController.text.trim(),
        bankDetailsFlag: true,
        accountNumber: accountNumberController.text.trim(),
        genderFlag: true,
        gender: _isSelectGender,
        feeFlag: true,
        fee: counter.toString(),
        isLocationVisible: _isSelect,
        instantCallAvailable: _isSelect);
    response = await _updateUserDetailsRepository.UpdateUserDetails(await updateExpertProfileRequestModel.toJson());
    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is LoginResponseModel) {
          LoginResponseModel updateUserDetailsResponseModel = response.data;
          Logger().d("Successfully login");
          SharedPrefHelper.saveUserData(jsonEncode(updateUserDetailsResponseModel.data));
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

