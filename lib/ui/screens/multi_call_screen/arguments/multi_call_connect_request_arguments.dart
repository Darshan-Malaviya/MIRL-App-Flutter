import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class MultiConnectDialogArguments {
  final String? image, name;
  final String userID;
  final List<int> expertIds;
  final VoidCallback? onFirstBtnTap;
  final VoidCallback? onSecondBtnTap;
  final Color? secondBtnColor;

  const MultiConnectDialogArguments(
      {this.name,
      this.image,
      required this.expertIds,
      required this.userID,
      this.onFirstBtnTap,
      this.onSecondBtnTap,
      this.secondBtnColor});
}
