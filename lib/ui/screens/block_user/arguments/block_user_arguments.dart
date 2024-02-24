import 'package:flutter/cupertino.dart';

class BlockUserArgs {
  final String? userName;
  final String? imageURL;
  final int? userId;
  final int? userRole;
  final String? reportName;
  final bool isFromInstantCall;
  final String? expertId;
  final ScrollController? controller;

  BlockUserArgs(
      {this.userName,
      this.imageURL,
      this.controller,
      this.userId,
      required this.userRole,
      required this.reportName,
      this.isFromInstantCall = false,
      this.expertId});
}
