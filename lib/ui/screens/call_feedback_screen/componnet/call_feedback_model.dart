import 'dart:ui';

import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class CallFeedBackModel {
  List<CallFeedbackData> callFeedbackDataList;
  double localPosition;

  CallFeedBackModel({
    required this.callFeedbackDataList,
    this.localPosition = 0.0,
  });
}

class CallFeedbackData {
  GlobalKey<FormState> formKey;
  int criteriaSelectedIndex;
  double currentDxPosition;

  CallFeedbackData({
    required this.formKey,
    this.criteriaSelectedIndex = 0,
    this.currentDxPosition = 0.0,
  });
}
