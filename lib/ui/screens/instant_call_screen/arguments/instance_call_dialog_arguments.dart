import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class InstanceCallDialogArguments {
  final String? image, name;
  final String userID;
  final String expertId;
  final VoidCallback? onFirstBtnTap;
  final VoidCallback? onSecondBtnTap;

  const InstanceCallDialogArguments(
      {this.name,
      this.image,
      required this.expertId,
      required this.userID,
      this.onFirstBtnTap,
      this.onSecondBtnTap});
}
