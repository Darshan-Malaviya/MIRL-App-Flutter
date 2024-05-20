import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:mirl/infrastructure/commons/constants/agora_constants.dart';
import 'package:permission_handler/permission_handler.dart';

late RtcEngine engine;

class AgoraService {
  // A static private instance to access _socketApi from inside class only
  static final AgoraService singleton = AgoraService._internal();

  // Factory constructor to return same static instance everytime you create any object.
  factory AgoraService() {
    return singleton;
  }

  // An internal private constructor to access it for only once for static instance of class.
  AgoraService._internal();

  Future<void> initAgora({
    required String channelId,
    required String token,
    required bool isFromAudio,
    required Function(RtcConnection connection, int elapsed) onJoinChannelSuccess,
    Function(RtcConnection connection, RtcStats stats)? onLeaveChannel,
    required Function(RtcConnection connection, int rUid, int elapsed) onUserJoined,
    required Function(RtcConnection connection, int rUid, UserOfflineReasonType reason) onUserOffline,
    required Function(ErrorCodeType err, String msg)? onError,
    required Function() audioVideoCallFunction,
    Function(RtcConnection connection, LocalAudioStreamState state,
        LocalAudioStreamReason reason)? onLocalAudioStateChanged,
    Function(RtcConnection connection, int remoteUid, RemoteVideoState state, RemoteVideoStateReason reason, int elapsed)? onRemoteVideoStateChanged,
    Function(RtcConnection connection, String token)? onTokenPrivilegeWillExpire,
    Function(RtcConnection, int, RemoteAudioState, RemoteAudioStateReason, int)? onRemoteAudioStateChanged,
    Function(VideoSourceType source, LocalVideoStreamState state,
        LocalVideoStreamReason reason)? onLocalVideoStateChanged
  }) async {
    if (isFromAudio) {
      await [Permission.microphone].request();
    } else {
      await [Permission.microphone, Permission.camera].request();
    }

    engine = createAgoraRtcEngine();
    await engine.initialize(const RtcEngineContext(
      appId: agoraAppId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    engine.registerEventHandler(RtcEngineEventHandler(
        onError: onError,
        onJoinChannelSuccess: onJoinChannelSuccess,
        onLeaveChannel: onLeaveChannel,
        onUserJoined: onUserJoined,
        onUserOffline: onUserOffline,
        onTokenPrivilegeWillExpire: onTokenPrivilegeWillExpire,
        onLocalAudioStateChanged: onLocalAudioStateChanged,
        onRemoteVideoStateChanged:onRemoteVideoStateChanged,
        onRemoteAudioStateChanged:onRemoteAudioStateChanged ,
        onLocalVideoStateChanged: onLocalVideoStateChanged

    ));

    audioVideoCallFunction();

    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await engine.joinChannel(
      token: token,
      channelId: channelId,
      options: isFromAudio ? options : const ChannelMediaOptions(),
      uid: 0,
    );
  }


  Future<String> getVoipToken() async {
    return await FlutterCallkitIncoming.getDevicePushTokenVoIP();
  }
}
