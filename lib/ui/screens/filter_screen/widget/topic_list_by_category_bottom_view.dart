import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class TopicListByCategoryBottomView extends ConsumerStatefulWidget {
  final String categoryId;

  const TopicListByCategoryBottomView({super.key, required this.categoryId});

  @override
  ConsumerState<TopicListByCategoryBottomView> createState() => _TopicListByCategoryBottomViewState();
}

class _TopicListByCategoryBottomViewState extends ConsumerState<TopicListByCategoryBottomView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(ref.watch(filterProvider).allTopic.isEmpty){
        ref.read(filterProvider).clearSearchTopicController();
        ref.read(filterProvider).clearTopicPaginationData();
        ref.read(filterProvider).topicListByCategory(
          isFullScreenLoader: true,
          categoryId: widget.categoryId,
        );
      }
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(filterProvider).reachedTopicLastPage;
        if (!isLoading) {
          ref.read(filterProvider).topicListByCategory(
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
    final filterProviderWatch = ref.watch(filterProvider);
    final filterProviderRead = ref.read(filterProvider);

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
                  onTap: () {
                    filterProviderRead.setTopicByCategory();
                    context.toPop();
                  },
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
            suffixIcon: filterProviderWatch.searchTopicController.text.isNotEmpty
                ? InkWell(
                    onTap: () {
                      filterProviderRead.clearTopicPaginationData();
                      filterProviderRead.clearSearchTopicController();
                      filterProviderRead.topicListByCategory(
                        categoryId: widget.categoryId,
                      );
                    },
                    child: Icon(Icons.close))
                : SizedBox.shrink(),
            onFieldSubmitted: (value) {
              context.unFocusKeyboard();
              filterProviderRead.clearTopicPaginationData();
              filterProviderRead.topicListByCategory(
                searchName: value,
                categoryId: widget.categoryId,
              );
            },
            height: 40,
            controller: filterProviderWatch.searchTopicController,
            textInputAction: TextInputAction.done,
          ).addAllMargin(12),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: filterProviderWatch.allTopic.isNotEmpty
                ? ListView.builder(
                    controller: scrollController,
                    itemCount: filterProviderWatch.allTopic.length + (filterProviderWatch.reachedTopicLastPage ? 0 : 1),
                    itemBuilder: (context, index) {
                      if (index == filterProviderWatch.allTopic.length && filterProviderWatch.allTopic.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          filterProviderRead.setTopicList(topic: filterProviderWatch.allTopic[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: (filterProviderWatch.allTopic[index].isCategorySelected ?? false)
                                ? ColorConstants.bottomTextColor.withOpacity(0.1)
                                : ColorConstants.scaffoldColor,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: BodyMediumText(
                              maxLine: 3,
                              titleTextAlign: TextAlign.center,
                              title: filterProviderWatch.allTopic[index].name ?? '',
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
