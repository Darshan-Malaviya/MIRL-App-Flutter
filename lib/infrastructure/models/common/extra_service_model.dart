class ExtraResponseModel {
  String? userId;
  String? expertId;
  String? userName;
  String? userProfile;
  String? channelCode;
  String? agoraToken;
  int? callHistoryId;
  String? key;
  bool? isVideo;
  bool? isJointRemote;

  ExtraResponseModel({
    this.userId,
    this.expertId,
    this.userName,
    this.userProfile,
    this.channelCode,
    this.agoraToken,
    this.callHistoryId,
    this.isVideo,
    this.key,
    this.isJointRemote = false,
  });

  ExtraResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    expertId = json['expertId'];
    userName = json['userName'];
    userProfile = json['userProfile'];
    channelCode = json['channelCode'];
    agoraToken = json['agoraToken'];
    callHistoryId = json['callHistoryId'];
    isVideo = json['isVideo'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['expertId'] = expertId;
    data['userName'] = userName;
    data['userProfile'] = userProfile;
    data['channelCode'] = channelCode;
    data['agoraToken'] = agoraToken;
    data['callHistoryId'] = callHistoryId;
    data['isVideo'] = isVideo;
    data['key'] = key;
    return data;
  }
}
