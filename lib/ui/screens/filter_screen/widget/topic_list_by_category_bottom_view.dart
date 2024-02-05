import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/category_id_name_common_model.dart';

class TopicListByCategoryBottomView extends ConsumerStatefulWidget {
  final Function(CategoryIdNameCommonModel item) onTapItem;
  final TextEditingController searchController;
  final VoidCallback clearSearchTap;
  final String categoryId;
  final void Function()? doneOnTap;

  const TopicListByCategoryBottomView(
      {super.key,
      required this.onTapItem,
      required this.searchController,
      required this.clearSearchTap,
        this.doneOnTap,
      required this.categoryId});

  @override
  ConsumerState<TopicListByCategoryBottomView> createState() => _TopicListByCategoryBottomViewState();
}

class _TopicListByCategoryBottomViewState extends ConsumerState<TopicListByCategoryBottomView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.clearSearchTap();
      ref.read(commonAppProvider).clearTopicPaginationData();
      ref.read(commonAppProvider).topicListByCategory(
            isFullScreenLoader: true,
            categoryId: widget.categoryId,
          );
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(commonAppProvider).reachedTopicLastPage;
        if (!isLoading) {
          ref.read(commonAppProvider).topicListByCategory(
                categoryId: widget.categoryId,
              );
        } else {
          log('reach last page on all category list api');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final commonWatch = ref.watch(commonAppProvider);
    final commonRead = ref.read(commonAppProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Stack(
            children: [
              Center(child: TitleMediumText(title: "Select Topic", titleColor: ColorConstants.sheetTitleColor)),
              Positioned(
                right: 0,
                bottom: 2,
                top: 2,
                child: InkWell(
                  onTap: widget.doneOnTap,
                  child: BodySmallText(
                    titleTextAlign: TextAlign.center,
                    title: StringConstants.done,
                    titleColor: ColorConstants.blackColor,
                  ),
                ),
              ),
            ],
          ),
          16.0.spaceY,
          TextFormFieldWidget(
            isReadOnly: false,
            hintText: "Search here",
            suffixIcon: widget.searchController.text.isNotEmpty
                ? InkWell(
                    onTap: () {
                      commonRead.clearTopicPaginationData();
                      widget.clearSearchTap();
                      commonRead.topicListByCategory(
                        categoryId: widget.categoryId,
                      );
                    },
                    child: Icon(Icons.close))
                : SizedBox.shrink(),
            onFieldSubmitted: (value) {
              context.unFocusKeyboard();
              commonRead.clearTopicPaginationData();
              commonRead.topicListByCategory(
                searchName: value,
                categoryId: widget.categoryId,
              );
            },
            height: 40,
            controller: widget.searchController,
            textInputAction: TextInputAction.done,
          ).addAllMargin(12),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: commonWatch.allTopic.isNotEmpty
                ? ListView.builder(
                    controller: scrollController,
                    itemCount: commonWatch.allTopic.length + (commonWatch.reachedTopicLastPage ? 0 : 1),
                    itemBuilder: (context, index) {
                      if (index == commonWatch.allTopic.length && commonWatch.allTopic.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          widget.onTapItem(commonWatch.allTopic[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: (commonWatch.allTopic[index].isCategorySelected ?? false)
                                ? ColorConstants.bottomTextColor.withOpacity(0.1)
                                : ColorConstants.scaffoldColor,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: BodyMediumText(
                            maxLine: 3,
                              titleTextAlign: TextAlign.center,
                              title: commonWatch.allTopic[index].name ?? '',
                              titleColor: ColorConstants.bottomTextColor),
                        ),
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                  ),
          ),
          16.0.spaceY,
        ],
      ),
    );
  }
}
