import 'package:flutter/cupertino.dart';
import 'package:mirl/infrastructure/handler/media_picker_handler/media_picker.dart';

class UserSettingProvider extends ChangeNotifier {
  TextEditingController reasonController = TextEditingController();

  String _enteredText = '0';
  String get enteredText => _enteredText;

  String _pickedImage = '';
  String get pickedImage => _pickedImage;

  void changeAboutCounterValue(String value) {
    _enteredText = value.length.toString();
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
}
