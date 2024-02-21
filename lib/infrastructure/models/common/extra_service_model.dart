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
  String? instantCallSeconds;
  String? isJointRemote;
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
    this.instantCallSeconds = "60",
    this.key,
    this.callRoleEnum,
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
    instantCallSeconds = "60";
   // instantCallSeconds = json['instantCallSeconds'];
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
    data['isVideo'] = isVideo;
  //  data['instantCallSeconds'] = instantCallSeconds;
    data['key'] = key;
    return data;
  }
}
