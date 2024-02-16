import 'package:mirl/infrastructure/models/response/appointment_response_model.dart';
import 'package:mirl/infrastructure/models/response/cancel_appointment_response_model.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';

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
  final AppointmentData? appointmentData;
  final String? role;
  final CancelAppointmentData? cancelData;
  final bool? fromUser;

  CancelArgs({this.appointmentData, this.role, this.cancelData, this.fromUser = false});
}
