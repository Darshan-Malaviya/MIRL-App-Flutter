///define appointment service type code
abstract class AppointmentServiceType {
  static const created = '0';
  static const accepted = '1';
  static const declined = '2';
  static const completed = '3';
  static const started = '4';
  static const running = '5';
  static const timeout = '6';
}

abstract class AppointmentSessionType {
  static const chat = '0';
  static const audioCall = '1';
  static const videoCall = '2';
}

abstract class UserRole {
  static const therapist = '0';
  static const patient = '1';
}

abstract class ConnectStatus {
  static const callAccepted = '1';
  static const timeoutAndDecline = '2';
}
