import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/week_days_extension.dart';
import 'package:mirl/infrastructure/models/common/week_schedule_model.dart';
import 'package:mirl/infrastructure/models/request/certificate_request_model.dart';
import 'package:mirl/infrastructure/models/request/expert_availability_request_model.dart';
import 'package:mirl/infrastructure/repository/expert_profile_repo.dart';

class EditExpertProvider extends ChangeNotifier {
  final _expertProfileRepo = ExpertProfileRepo();

  List<CertificateAndExperienceModel> _certiAndExpModel = [];

  List<CertificateAndExperienceModel> get certiAndExpModel => _certiAndExpModel;

  List<WeekScheduleModel> _weekScheduleModel = [];

  List<WeekScheduleModel> get weekScheduleModel => _weekScheduleModel;

  List<WorkDays> workDaysList = [];

  List<CertificationData> certificationList = [];

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
      WeekScheduleModel(dayName: 'MON', startTime: lowerValue.millisecondsSinceEpoch.toDouble(), endTime: upperValue.millisecondsSinceEpoch.toDouble(), isAvailable: true),
      WeekScheduleModel(dayName: 'TUE', startTime: lowerValue.millisecondsSinceEpoch.toDouble(), endTime: upperValue.millisecondsSinceEpoch.toDouble(), isAvailable: true),
      WeekScheduleModel(dayName: 'WED', startTime: lowerValue.millisecondsSinceEpoch.toDouble(), endTime: upperValue.millisecondsSinceEpoch.toDouble(), isAvailable: true),
      WeekScheduleModel(dayName: 'THU', startTime: lowerValue.millisecondsSinceEpoch.toDouble(), endTime: upperValue.millisecondsSinceEpoch.toDouble(), isAvailable: false),
      WeekScheduleModel(dayName: 'FRI', startTime: lowerValue.millisecondsSinceEpoch.toDouble(), endTime: upperValue.millisecondsSinceEpoch.toDouble(), isAvailable: true),
      WeekScheduleModel(dayName: 'SAT', startTime: lowerValue.millisecondsSinceEpoch.toDouble(), endTime: upperValue.millisecondsSinceEpoch.toDouble(), isAvailable: true),
      WeekScheduleModel(dayName: 'SUN', startTime: lowerValue.millisecondsSinceEpoch.toDouble(), endTime: upperValue.millisecondsSinceEpoch.toDouble(), isAvailable: false),
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
      certificationList
          .add(CertificationData(title: element.titleController.text.trim(), url: element.urlController.text.trim(), description: element.descriptionController.text.trim()));
    });
    notifyListeners();
  }

  Future<void> expertAvailabilityApi(BuildContext context, String scheduleType) async {
    getSelectedWeekDays();
    CustomLoading.progressDialog(isLoading: true);

    ExpertAvailabilityRequestModel requestModel = ExpertAvailabilityRequestModel(scheduleType: scheduleType, workDays: workDaysList);

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
}
