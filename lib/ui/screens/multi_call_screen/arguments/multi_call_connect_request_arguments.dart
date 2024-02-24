import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/instance_call_emits_response_model.dart';

class MultiConnectDialogArguments {
  final List<ExpertDetails>? expertList;
  final UserDetails? userDetail;
  final VoidCallback? onFirstBtnTap;
  final VoidCallback? onSecondBtnTap;


  const MultiConnectDialogArguments(
      {this.expertList, this.userDetail, this.onFirstBtnTap, this.onSecondBtnTap});
}
