import 'package:flutter/cupertino.dart';

class VideoCallProvider extends ChangeNotifier {
  bool get voiceOn => _voiceOn;
  bool _voiceOn = true;

  bool get cameraOn => _cameraOn;
  bool _cameraOn = true;

  bool get videoOn => _videoOn;
  bool _videoOn = true;

  bool get visible => _visible;
  bool _visible = true;

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
