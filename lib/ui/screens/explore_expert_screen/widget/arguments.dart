import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ExploreExpertDetailsArgs {
  final bool isFromHomePage;
  final ScrollController scrollController;

  ExploreExpertDetailsArgs({
    required this.isFromHomePage,
    required this.scrollController,
  });
}
