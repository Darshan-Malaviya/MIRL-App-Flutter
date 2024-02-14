import 'package:mirl/infrastructure/models/response/cancel_appointment_response_model.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';

class FilterArgs {
  final bool? fromExploreExpert;
  final List<Topic>? list;
  final String? categoryId;

  FilterArgs({this.fromExploreExpert, this.list,this.categoryId});
}

class CallArgs {
  final UserData? expertData;

  CallArgs({this.expertData});
}

class AppointmentArgs {
  final CancelAppointmentData? cancelData;
  final bool fromUser;

  AppointmentArgs({required this.cancelData, required this.fromUser});
}
