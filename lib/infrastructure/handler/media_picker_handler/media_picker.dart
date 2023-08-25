// ignore_for_file: use_build_context_synchronously

import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/handler/permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

List<String> imageTypeList = [
  'jpeg',
  'jpeg',
  'heif',
];
List<String> videoTypeList = ['mp4', 'mkv', 'hevc', 'mov', 'webm'];

class ImagePickerHandler extends PermissionHandler {
  // A static private instance to access _socketApi from inside class only
  static final ImagePickerHandler singleton = ImagePickerHandler._internal();

  // Factory constructor to return same static instance everytime you create any object.
  factory ImagePickerHandler() {
    return singleton;
  }

  ImagePickerHandler._internal();

  final ImagePicker picker = ImagePicker();

  Future<XFile?> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  Future<XFile?> pickVideoFromGallery({required BuildContext context}) async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      final fileBytes = await File(pickedFile.path ?? '').readAsBytes();
      int fileSizedInBytes = fileBytes.lengthInBytes;
      final fileSizeInKB = fileSizedInBytes / 1000;
      final fileSizeInMB = fileSizeInKB / 1000;
      if (fileSizeInMB <= 100) {
        String? mediaType = pickedFile.path.split('.').last.toLowerCase();
        for (var element in videoTypeList) {
          if (element == mediaType) {
            return pickedFile;
          }
        }
      } else {
        FlutterToast().showToast(context: context, msg: "Video size should be less than 100 MB.");
        return null;
      }
    } else {
      return null;
    }
    FlutterToast().showToast(context: context, msg: "Please upload video in mp4, mkv, hevc, mov or webm format.");
    return null;
  }

  Future<XFile?> capturePhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    return pickedFile;
  }
}
