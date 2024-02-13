import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/services/agora_service.dart';



class CallProvider extends ChangeNotifier {

  final Connectivity connectivity = Connectivity();

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

  Future<void> initVideoCallAgora({required String channelId, required String token}) async {
    ConnectivityResult connection = await connectivity.checkConnectivity();
    if (connection == ConnectivityResult.mobile || connection == ConnectivityResult.wifi) {

      AgoraService.singleton.initAgora(
          isFromAudio: false,
          token: token,
          channelId: channelId,
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) async {
            log("local user ${connection.localUid} joined");

          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) async {
            log("remote user $remoteUid joined");
          },
          onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) async {
          },
          onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
            log('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
          },
          onError: (ErrorCodeType err, String msg) {
            log("on agora call error $err $msg");
            log(err.toString());
            log(msg);
          },
          audioVideoCallFunction: () async {
            await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
            await engine.enableVideo();
            await engine.startPreview();
          },
          /* onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid, RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
           ref.read(socketServiceProvider).notifySettingSocketEmit(
              courseId: ref.read(liveCourseDetailProvider).liveCourseDetail?.id.toString() ?? '',
              userId: SharedPrefHelper.getUserId.toString(),
              micStatus: ref.read(liveClassesProvider).studentSpeakerOn,
              cameraStatus: ref.read(liveClassesProvider).isStudentCameraOn,
              notifyUserId: _notifyUserId,
            );

          },*/
          onLocalAudioStateChanged: (RtcConnection connection, LocalAudioStreamState state, LocalAudioStreamError error) async {
            log("check state change ");
            log(state.name);
            log(state.index.toString());
          });

    } else {
     ///No internet
    }
  }

}
