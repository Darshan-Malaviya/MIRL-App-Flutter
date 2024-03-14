import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';

class ExtraResponseModel {
  String? userId;
  String? userName;
  String? userProfile;
  String? expertId;
  String? expertName;
  String? expertProfile;
  String? channelCode;
  String? agoraToken;
  String? callHistoryId;
  String? key;
  String? isVideo;
  String? requestedDuration;
  String? isJointRemote;
  String? requestType;
  CallRoleEnum? callRoleEnum;


  ExtraResponseModel({
    this.userId,
    this.expertId,
    this.expertName,
    this.expertProfile,
    this.userName,
    this.userProfile,
    this.channelCode,
    this.agoraToken,
    this.callHistoryId,
    this.isVideo,
    this.requestedDuration,
    this.key,
    this.callRoleEnum,
    this.requestType,
    this.isJointRemote = "false",
  });

  ExtraResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    expertId = json['expertId'];
    userName = json['userName'];
    userProfile = json['userProfile'];
    expertName = json['expertName'];
    expertProfile = json['expertProfile'];
    channelCode = json['channelCode'];
    agoraToken = json['agoraToken'];
    callHistoryId = json['callHistoryId'];
    isVideo = json['isVideo'];
    requestType = json['requestType'];
    ///TODO change call duration from here
   // requestedDuration = "120";
    requestedDuration = json['requestedDuration'];
    callRoleEnum = json['callRoleEnum'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['expertId'] = expertId;
    data['userName'] = userName;
    data['userProfile'] = userProfile;
    data['expertProfile'] = expertProfile;
    data['expertName'] = expertName;
    data['channelCode'] = channelCode;
    data['agoraToken'] = agoraToken;
    data['callHistoryId'] = callHistoryId;
    data['requestType'] = requestType;
    data['isVideo'] = isVideo;
    data['requestedDuration'] = requestedDuration;
    data['key'] = key;
    return data;
  }
}
