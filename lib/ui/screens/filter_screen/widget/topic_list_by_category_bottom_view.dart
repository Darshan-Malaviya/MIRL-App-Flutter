import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/category_id_name_common_model.dart';
import 'package:mirl/ui/common/container_widgets/category_common_view.dart';

class TopicListByCategoryBottomView extends ConsumerStatefulWidget {
  final CategoryIdNameCommonModel category;
  final bool isFromExploreExpert;

  const TopicListByCategoryBottomView({super.key, required this.category, this.isFromExploreExpert = true});

  @override
  ConsumerState<TopicListByCategoryBottomView> createState() => _TopicListByCategoryBottomViewState();
}

class _TopicListByCategoryBottomViewState extends ConsumerState<TopicListByCategoryBottomView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
     // if (widget.isFromExploreExpert) {
        // if(ref.watch(filterProvider).allTopic.isEmpty){
        ref.read(filterProvider).clearSearchTopicController();
        ref.read(filterProvider).clearTopicPaginationData();
       await ref.read(filterProvider).topicListByCategory(
              isFullScreenLoader: true,
              categoryId: widget.category.id.toString(), categoryName: widget.category.name.toString(),
            );
        // }
    //  }
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(filterProvider).reachedTopicLastPage;
        if (!isLoading) {
          ref.read(filterProvider).topicListByCategory(
                categoryId: widget.category.id.toString(),
              categoryName: widget.category.name.toString()
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

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
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
            CategoryCommonView(
              onTap: () {},
              categoryName: widget.category.name ?? '',
              imageUrl: widget.category.image ?? '',
              isSelectedShadow: false,
              blurRadius: 8,
              spreadRadius: 1,
            ),
            14.0.spaceY,
            Center(child: TitleMediumText(title: "Select Topic".toUpperCase(), titleColor: ColorConstants.sheetTitleColor)),
            TextFormFieldWidget(
              isReadOnly: false,
              hintText: "Search here",
              suffixIcon: filterProviderWatch.searchTopicController.text.isNotEmpty
                  ? InkWell(
                      onTap: () {
                        filterProviderRead.clearTopicPaginationData();
                        filterProviderRead.clearSearchTopicController();
                        filterProviderRead.topicListByCategory(
                          categoryId: widget.category.id.toString(),
                            categoryName: widget.category.name.toString()
                        );
                      },
                      child: Icon(Icons.close))
                  : SizedBox.shrink(),
              onFieldSubmitted: (value) => context.unFocusKeyboard(),
              onChanged: (value) {
                filterProviderRead.clearTopicPaginationData();
                filterProviderRead.topicListByCategory(
                  searchName: value,
                  categoryId: widget.category.id.toString(),
                    categoryName: widget.category.name.toString()
                );
              },
              height: 40,
              controller: filterProviderWatch.searchTopicController,
              textInputAction: TextInputAction.done,
            ).addAllMargin(14),
            Expanded(
              // height: MediaQuery.of(context).size.height * 0.45,
              child: filterProviderRead.isSearchTopicBottomSheetLoading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                    )
                  : filterProviderWatch.allTopic.isNotEmpty
                      ? ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
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
                                filterProviderRead.checkAllTopicSelect(topic: filterProviderWatch.allTopic[index]);
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
                          child: Center(
                            child: BodyLargeText(
                              title: StringConstants.noDataFound,
                              fontFamily: FontWeightEnum.w600.toInter,
                            ),
                          ),
                        ),
            ),
            16.0.spaceY,
          ],
        ),
      ),
    );
  }
}
