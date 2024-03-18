// ignore_for_file: use_build_context_synchronously

import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/handler/permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

List<String> imageTypeList = ['jpeg', 'jpeg', 'heif'];
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

  /// pick IMAGE form library
  Future<String?> pickImageFromGallery({required BuildContext context}) async {
    //get Storage permission
    PermissionStatus storagePermissionStatus = await getStoragePermission(context: context, alertMessage: "Open Setting and\nallow Mirl app to select pictures form library.");

    //pick image from library
    if (storagePermissionStatus == PermissionStatus.granted || storagePermissionStatus == PermissionStatus.limited) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile?.path.isNotEmpty ?? false) {
        final croppedImage = await ImageCropper().cropImage(
          sourcePath: pickedFile?.path ?? '',
          maxWidth: 1080,
          maxHeight: 1080,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 60,
        );
        return croppedImage?.path;
      }
    }
    return null;
  }

  ///pick VIDEO from library
  Future<XFile?> pickVideoFromGallery({required BuildContext context}) async {
    //get Storage permission
    PermissionStatus storagePermissionStatus = await getStoragePermission(context: context, alertMessage: "Open Setting and\nallow Mirl app to select video form library.");

    //pick video from library
    if (storagePermissionStatus == PermissionStatus.granted || storagePermissionStatus == PermissionStatus.limited) {
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

      if (pickedFile != null) {
        final fileBytes = await File(pickedFile.path).readAsBytes();
        int fileSizedInBytes = fileBytes.lengthInBytes;
        final fileSizeInKB = fileSizedInBytes / 1000;
        final fileSizeInMB = fileSizeInKB / 1000;
        if (fileSizeInMB <= 100) {
          String? mediaType = pickedFile.path.split('.').last.toLowerCase();
          for (var element in videoTypeList) {
            if (element == mediaType) {
              return pickedFile;
            } else {
              FlutterToast().showToast(msg: "Please upload video in mp4, mkv, hevc, mov or webm format.");
              return null;
            }
          }
        } else {
          FlutterToast().showToast(msg: "Video size should be less than 100 MB.");
          return null;
        }
      } else {
        return null;
      }
    }
    return null;
  }

  /// CAPTURE PHOTO form camera
  Future<String?> capturePhoto({required BuildContext context}) async {
    //get permission status
    await permissionRequest(context: context, permission: Permission.camera, alertMessage: "Open Setting and\nallow Mirl app to access camera to take a picture. .");
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if(pickedFile?.path.isNotEmpty ?? false) {
      final croppedImage = await ImageCropper().cropImage(
        sourcePath: pickedFile?.path ?? '',
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 60,
      );
      return croppedImage?.path ?? '';
    }
    return null;
  }

  ///get storage permission based on android OS version
  Future<PermissionStatus> getStoragePermission({required BuildContext context, required String alertMessage}) async {
    Permission storagePermission;
    if (Platform.isAndroid) {
      // Require photos permission after Android 13
      // Require Storage permission before Android 12 version
      int? androidVersion = await getDeviceOSVersion();
      storagePermission = ((androidVersion ?? 0) > 12) ? Permission.photos : Permission.storage;
    } else {
      storagePermission = Permission.photos;
    }

    //get permission status
    PermissionStatus storagePermissionStatus = await permissionRequest(context: context, permission: storagePermission, alertMessage: alertMessage);
    return storagePermissionStatus;
  }

  ///get device information
  Future<int?> getDeviceOSVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return int.parse(androidInfo.version.release);
  }
}
