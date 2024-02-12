import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

ValueNotifier<bool> socketListen = ValueNotifier(false);

class CallProvider extends ChangeNotifier {
  bool get voiceOn => _voiceOn;
  bool _voiceOn = true;

  bool get cameraOn => _cameraOn;
  bool _cameraOn = true;

  bool get videoOn => _videoOn;
  bool _videoOn = true;

  bool get visible => _visible;
  bool _visible = true;

  void listenAllMethods(BuildContext context) {
    if (socketListen.value) {
      return;
    }
    updateSocketIdListener();
    callRequestListener();
    socketListen.value = true;
  }

  void updateSocketIdListener() {
    try {
      socket?.on(AppConstants.updateSocketIdResponse, (data) {
        Logger().d('updateSocketIdListener=====${data.toString()}');
      });
    } catch (e) {
      Logger().d('updateSocketIdListener====$e');
    }
  }

  void callRequestEmit() {
    try {
      socket?.emit(AppConstants.requestCallEmit, {
        AppConstants.expertId: SharedPrefHelper.getUserId,
        AppConstants.userId: 104,
        AppConstants.requestType: 1,
        AppConstants.time: DateTime.now().toUtc().toString()
      });
    } catch (e) {
      Logger().d('callRequestEmit====$e');
    }
  }

  void callRequestListener() {
    try {
      socket?.on(AppConstants.requestCallSend, (data) {
        Logger().d('callRequestListener=====${data.toString()}');
      });
    } catch (e) {
      Logger().d('callRequestListener====$e');
    }
  }

  void changeCameraColor() {
    _cameraOn = !_cameraOn;
    notifyListeners();
  }

  void changeVideoColor() {
    _videoOn = !_videoOn;
    notifyListeners();
  }

  void changeVoiceColor() {
    _voiceOn = !_voiceOn;
    notifyListeners();
  }

  void visibleBottomSheet() {
    _visible = !_visible;
    notifyListeners();
  }
}
