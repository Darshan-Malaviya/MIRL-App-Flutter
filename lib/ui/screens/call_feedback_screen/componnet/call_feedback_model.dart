
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class CallFeedBackModel {
  List<CallFeedbackData> callFeedbackDataList;
  double localPosition;
  int? criteriaSelectedIndex;

  CallFeedBackModel({
    required this.callFeedbackDataList,
    this.criteriaSelectedIndex,
    this.localPosition = 0.0,
  });
}

class CallFeedbackData {
  GlobalKey<FormState> formKey;
  double currentDxPosition;

  CallFeedbackData({
    required this.formKey,
    this.currentDxPosition = 0.0,
  });
}
