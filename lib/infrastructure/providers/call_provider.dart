import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/enums/call_connect_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_status_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/utils/value_notifier_utils.dart';
import 'package:mirl/infrastructure/services/agora_service.dart';



class CallProvider extends ChangeNotifier {

  ChangeNotifierProviderRef<CallProvider> ref;
  CallProvider(this.ref);

  bool get isLocalMicOn => _isLocalMicOn;
  bool _isLocalMicOn = true;

  bool get isLocalVideoOn => _isLocalVideoOn;
  bool _isLocalVideoOn = true;

  bool get isRemoteMicOn => _isRemoteMicOn;
  bool _isRemoteMicOn = true;

  bool get isRemoteVideoOn => _isRemoteVideoOn;
  bool _isRemoteVideoOn = true;

  bool get isFrontCameraOn => _isFrontCameraOn;
  bool _isFrontCameraOn = true;

  bool get visible => _visible;
  bool _visible = true;

  bool get isSwipeUser => _isSwipeUser;
  bool _isSwipeUser = false;

  int? get remoteUid => _remoteUid;
  int? _remoteUid;

  bool get localUserJoined => _localUserJoined;
  bool _localUserJoined = false;

  Timer? callDurationTimer;

  int? _callDuration;
  int? get callDuration => _callDuration;

  void setRemoteId({required int? remoteId}) {
    _remoteUid = remoteId;
    instanceCallDurationNotifier.value = 0;
    notifyListeners();
  }

  void joinLocalUser(bool value) {
    _localUserJoined = value;
    instanceCallDurationNotifier.value = 0;
  //  _isSpeaker = isCallSpeaker;
    //engine.setEnableSpeakerphone(_isSpeaker);
    notifyListeners();
  }

  void swipeUser() {
    _isSwipeUser = !_isSwipeUser;
    changeVideoCallView.value = !changeVideoCallView.value;
    notifyListeners();
  }

  void changeLocalVideo() {
    _isLocalVideoOn = !_isLocalVideoOn;
     engine.enableLocalVideo(_isLocalVideoOn);
   // changeVideoCallView.value = !changeVideoCallView.value;
    notifyListeners();
  }

  Future<void> changeLocalMic() async {
    _isLocalMicOn = !_isLocalMicOn;
    await engine.enableLocalAudio(_isLocalMicOn);
   // engine.muteLocalAudioStream(_isLocalMicOn);
  //  changeVideoCallView.value = !changeVideoCallView.value;
    notifyListeners();
  }

  void onCameraSwitch() {
    _isFrontCameraOn = !_isFrontCameraOn;
    engine.switchCamera();
    changeVideoCallView.value = !changeVideoCallView.value;
   // notifyListeners();
  }


  void visibleBottomSheet() {
    _visible = !_visible;
    notifyListeners();
  }

  void getCallDuration() {
    /// Change when duration of instance call is changed , right now it's 10 min = 600 sec.
    _callDuration = int.parse(ref.watch(socketProvider).extraResponseModel?.requestedDuration ?? '600');
    notifyListeners();
  }


/*  void startTimer() {
    callDurationTimer?.cancel();
    const oneSec = const Duration(seconds: 1);
    callDurationTimer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (instanceCallDurationNotifier.value == _callDuration) {
          timer.cancel();
          callDurationTimer?.cancel();
        } else {
          instanceCallDurationNotifier.value++;
        }
      },
    );
  }*/

  void clearAllValue() {
    _isLocalMicOn = true;
    _isLocalVideoOn = true;
    _isRemoteMicOn = true;
    _isRemoteVideoOn = true;
    _isFrontCameraOn = true;
    _visible = false;
    _isSwipeUser = false;
    _remoteUid = null;
    _localUserJoined = false;
    _callDuration = null;
    notifyListeners();
  }

  void disposeCallDuration() {
    callDurationTimer?.cancel();
  }

  Future<void> initVideoCallAgora({required String channelId, required String token}) async {
    await AgoraService.singleton.initAgora(
          isFromAudio: false,
          token: token,
          channelId: channelId,
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) async {
            log("local user ${connection.localUid} joined");
            joinLocalUser(true);

          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) async {
            log("remote user $remoteUid joined");
            setRemoteId(remoteId: remoteUid);

          },
          onUserOffline: (RtcConnection connection, int offlineRemoteUid, UserOfflineReasonType reason) async {
          if (callConnectNotifier.value != CallConnectStatusEnum.completed) {
            if (_remoteUid == offlineRemoteUid &&
                (ref.read(socketProvider).extraResponseModel?.userId.toString() ==
                    SharedPrefHelper.getUserId.toString())) {
              /// expert kill app so completed call emit trigger from user side
              ref.read(socketProvider).updateCallStatusEmit(status: CallStatusEnum.completedCall,
                  callRoleEnum: CallRoleEnum.user,
                  callHistoryId: ref.read(socketProvider).extraResponseModel?.callHistoryId.toString() ?? '');
            } else {
              if ((_remoteUid == offlineRemoteUid &&
                  (ref.read(socketProvider).extraResponseModel?.expertId.toString() ==
                      SharedPrefHelper.getUserId.toString()))) {
                /// user kill app so completed call emit trigger from expert side
                ref.read(socketProvider).updateCallStatusEmit(status: CallStatusEnum.completedCall,
                    callRoleEnum: CallRoleEnum.expert,
                    callHistoryId: ref.read(socketProvider).extraResponseModel?.callHistoryId.toString() ?? '');
              }
            }
          }
          setRemoteId(remoteId: null);
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
            await engine.enableAudio();
            await engine.startPreview();
          },
           onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid, RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
             log("onRemoteVideoStateChanged");
             log(state.name);
             log(state.index.toString());
             if(state == RemoteVideoState.remoteVideoStateDecoding) {
               _isRemoteVideoOn = true;
             } else {
               _isRemoteVideoOn = false;
             }
             changeVideoCallView.value = !changeVideoCallView.value;
             notifyListeners();
          },
        onRemoteAudioStateChanged: (RtcConnection connection, int remoteUid, RemoteAudioState state, RemoteAudioStateReason reason, int elapsed) {
          log("onRemoteAudioStateChanged");
          log(state.name);
          log(state.index.toString());
          if(state == RemoteAudioState.remoteAudioStateStopped) {
            _isRemoteMicOn = false;
          } else {
            _isRemoteMicOn = true;
          }
          changeVideoCallView.value = !changeVideoCallView.value;
          notifyListeners();
          log(_isRemoteMicOn.toString());
          },
        onLocalVideoStateChanged: (VideoSourceType source, LocalVideoStreamState state, error) async {
          log("onLocalVideoStateChanged");
          log(state.name);
          log(state.index.toString());
          notifyListeners();
         // changeVideoCallView.value = !changeVideoCallView.value;
          },
        onLocalAudioStateChanged: (RtcConnection connection, LocalAudioStreamState state, error) async {
          log("onLocalAudioStateChanged");
            log(state.name);
            log(state.index.toString());
            notifyListeners();
         //   changeVideoCallView.value = !changeVideoCallView.value;
          }
          );
  }

}
