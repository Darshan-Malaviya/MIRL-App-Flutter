class SelectedCategoryArgument {
  final String categoryId;
  final String? topicId;
  final String categoryName;
  final bool isFromExploreExpert;

  SelectedCategoryArgument(
      {required this.categoryId, this.topicId, required this.isFromExploreExpert, required this.categoryName});
}
