class InstanceCallEmitsResponseModel {
  int? statusCode;
  String? message;
  InstanceCallEmitsData? data;

  InstanceCallEmitsResponseModel({this.statusCode, this.message, this.data});

  InstanceCallEmitsResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? InstanceCallEmitsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class InstanceCallEmitsData {
  UserDetails? userDetails;
  ExpertDetails? expertDetails;
  int? userId;
  int? expertId;
  int? callRequestId;
  String? time;
  int? status;
  int? role;
  String? timerType;
  int? callHistoryId;
  int? requestType;
  int? instantCallSeconds;

  InstanceCallEmitsData(
      {this.userDetails,
      this.expertDetails,
      this.userId,
      this.expertId,
      this.callRequestId,
      this.time,
      this.status,
      this.role,
      this.timerType,
      this.callHistoryId,
      this.requestType,
        this.instantCallSeconds});

  InstanceCallEmitsData.fromJson(Map<String, dynamic> json) {
    userDetails = json['userDetails'] != null ? UserDetails.fromJson(json['userDetails']) : null;
    expertDetails = json['expertDetails'] != null ? ExpertDetails.fromJson(json['expertDetails']) : null;
    if (json['userId'] != null) {
      if (json['userId'] is String) {
        userId = int.parse(json['userId']);
      } else {
        userId = json['userId'];
      }
    }
    if (json['expertId'] != null) {
      if (json['expertId'] is String) {
        expertId = int.parse(json['expertId']);
      } else {
        expertId = json['expertId'];
      }
    }
    if (json['callRequestId'] != null) {
      if (json['callRequestId'] is String) {
        callRequestId = int.parse(json['callRequestId']);
      } else {
        callRequestId = json['callRequestId'];
      }
    }
    if (json['time'] != null) {
      if (json['time'] is int) {
        time = json['time'].toString();
      } else {
        time = json['time'];
      }
    }
    if (json['status'] != null) {
      if (json['status'] is String) {
        status = int.parse(json['status']);
      } else {
        status = json['status'];
      }
    }

    if (json['role'] != null) {
      if (json['role'] is String) {
        role = int.parse(json['role']);
      } else {
        role = json['role'];
      }
    }
      if (json['timerType'] != null) {
        if (json['timerType'] is String) {
          timerType = json['timerType'];
        } else {
          timerType = json['timerType'];
        }
      }
      if (json['callHistoryId'] != null) {
        if (json['callHistoryId'] is String) {
          callHistoryId = int.parse(json['callHistoryId']);
        } else {
          callHistoryId = json['callHistoryId'];
        }
      }
      if (json['requestType'] != null) {
        if (json['requestType'] is String) {
          requestType = int.parse(json['requestType']);
        } else {
          requestType = json['requestType'];
        }
      }
      if(json['instantCallSeconds'] != null){
        if (json['instantCallSeconds'] is String) {
          instantCallSeconds = int.parse(json['instantCallSeconds']);
        } else {
          instantCallSeconds = json['instantCallSeconds'];
        }
      }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    if (this.expertDetails != null) {
      data['expertDetails'] = this.expertDetails!.toJson();
    }
    if (data['userId'] != null) {
      data['userId'] = this.userId;
    }
    if (data['expertId'] != null) {
      data['expertId'] = this.expertId;
    }
    if (data['callRequestId'] != null) {
      data['callRequestId'] = this.callRequestId;
    }
    if (data['time'] != null) {
      data['time'] = this.time;
    }
    if (data['status'] != null) {
      data['status'] = this.status;
    }
    if (data['role'] != null) {
      data['role'] = this.role;
    }
    if (data['timerType'] != null) {
      data['timerType'] = this.timerType;
    }
    if (data['callHistoryId'] != null) {
      data['callHistoryId'] = this.callHistoryId;
    }
    if (data['requestType'] != null) {
      data['requestType'] = this.requestType;
    }
    if(data['instantCallSeconds'] != null){
      data['instantCallSeconds'] = this.instantCallSeconds;
    }
    return data;
  }
}

class UserDetails {
  int? id;
  String? userProfile;
  String? userName;

  UserDetails({this.id, this.userProfile, this.userName});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userProfile = json['userProfile'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['userProfile'] = this.userProfile;
    data['userName'] = this.userName;
    return data;
  }
}

class ExpertDetails {
  int? id;
  String? expertProfile;
  String? expertName;
  int? fee;
  int? overAllRating;


  ExpertDetails({this.id, this.expertProfile, this.expertName,this.fee,this.overAllRating});

  ExpertDetails.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      if (json['id'] is String) {
        id = int.parse(json['id']);
      } else {
        id = json['id'];
      }
    }
    if(json['expertProfile'] != null){
      expertProfile = json['expertProfile'].toString();
    }
    if(json['expertName'] != null){
      expertName = json['expertName'].toString();
    }


   if(json['overAllRating'] != null){
     if (json['overAllRating'] is String) {
       overAllRating = int.parse(json['overAllRating']);
     } else {
       overAllRating = json['overAllRating'];
     }
   }

   if (json['fee'] != null) {
      if (json['fee'] is String) {
        fee = int.parse(json['fee']);
      } else {
        fee = json['fee'];
      }
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if(this.id != null){
      data['id'] = this.id;
    }
    if(this.expertProfile != null){
      data['expertProfile'] = this.expertProfile;
    }
    if(this.expertName != null){
      data['expertName'] = this.expertName;
    }
    if(this.fee != null){
      data['fee'] = this.fee;
    }
    if(this.overAllRating != null){
      data['overAllRating'] = this.overAllRating;
    }
    return data;
  }
}

class InstanceCallErrorModel {
  int? statusCode;
  List<String>? message;
  String? error;

  InstanceCallErrorModel({this.statusCode, this.message, this.error});

  InstanceCallErrorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'].cast<String>();
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}
