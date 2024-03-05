import 'package:mirl/infrastructure/commons/enums/call_type_enum.dart';

class VideoCallArguments {
  final String agoraChannelId;
  final String agoraToken;
  final int? callType;

  VideoCallArguments({
    required this.agoraChannelId,
    required this.agoraToken,
    required this.callType
  });
}
