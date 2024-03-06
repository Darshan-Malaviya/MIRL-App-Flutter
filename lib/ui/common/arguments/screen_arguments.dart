import 'package:mirl/infrastructure/models/response/appointment_response_model.dart';
import 'package:mirl/infrastructure/models/response/cancel_appointment_response_model.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/models/response/upcoming_appointment_response_model.dart';

class FilterArgs {
  final bool? fromExploreExpert;
  final bool? fromMultiConnectFilterBack;
  final List<Topic>? list;
  final String? categoryId;

  FilterArgs({this.fromExploreExpert, this.list, this.categoryId, this.fromMultiConnectFilterBack = false});
}

class CallArgs {
  final UserData? expertData;

  CallArgs({this.expertData});
}

class CancelArgs {
  final GetUpcomingAppointment? appointmentData;
  final int? role;
  final CancelAppointmentData? cancelData;
  final String? cancelDate;
  final bool? fromScheduled;

  CancelArgs({this.appointmentData, this.role, this.cancelData, this.fromScheduled = false,this.cancelDate});
}

class AppointmentArgs {
  final int role;
  final bool? fromNotification;
  final String? selectedDate;

  AppointmentArgs({required this.role, this.fromNotification = false, this.selectedDate});
}
