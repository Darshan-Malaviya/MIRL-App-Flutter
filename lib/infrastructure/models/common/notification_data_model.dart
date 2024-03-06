class NotificationData {
  String? key;
  String? date;
  String? expertId;
  String? sendTo;
  String? role;
  String? appointmentId;
  String? userId;
  String? id;
  String? profile;
  String? name;
  String? duration;
  String? startTime;
  String? endTime;
  String? reason;

  NotificationData(
      {this.date,
      this.expertId,
      this.sendTo,
      this.role,
      this.appointmentId,
      this.userId,
      this.key,
      this.id,
      this.profile,
      this.name,
      this.duration,
      this.startTime,
      this.endTime,
      this.reason});

  NotificationData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    date = json['date'];
    expertId = json['expertId'];
    sendTo = json['sendTo'];
    role = json['role'];
    appointmentId = json['appointmentId'];
    userId = json['userId'];
  }

  NotificationData.fromJsonCanceled(Map<String, dynamic> json) {
    key = json['key'];
    date = json['date'];
    id = json['id'];
    profile = json['profile'];
    name = json['name'];
    duration = json['duration'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['date'] = this.date;
    data['expertId'] = this.expertId;
    data['sendTo'] = this.sendTo;
    data['role'] = this.role;
    data['appointmentId'] = this.appointmentId;
    data['userId'] = this.userId;
    return data;
  }
}
