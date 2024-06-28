class SelectedTopicArgs {
  final int? topicId;
  final int? categoryId;
  final String? topicName;
  final String? categoryName;
  final bool? fromMultiConnect;

  SelectedTopicArgs({
    this.topicId,
    this.categoryId,
    this.topicName,
    this.categoryName,
    this.fromMultiConnect,
  });
}
