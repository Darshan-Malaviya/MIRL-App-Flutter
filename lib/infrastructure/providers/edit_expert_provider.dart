import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class EditExpertProvider extends ChangeNotifier {
  List<CertificateAndExperienceModel> _certiAndExpModel = [];

  List<CertificateAndExperienceModel> get certiAndExpModel => _certiAndExpModel;

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
}
