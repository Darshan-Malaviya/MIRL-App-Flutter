import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/category_id_name_common_model.dart';

class AllCategoryListBottomView extends ConsumerStatefulWidget {
  final Function(CategoryIdNameCommonModel item) onTapItem;
  final TextEditingController searchController;
  final VoidCallback clearSearchTap;

  const AllCategoryListBottomView(
      {super.key, required this.onTapItem, required this.searchController, required this.clearSearchTap});

  @override
  ConsumerState<AllCategoryListBottomView> createState() => _AllCategoryListBottomViewState();
}

class _AllCategoryListBottomViewState extends ConsumerState<AllCategoryListBottomView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.clearSearchTap();
      ref.read(commonAppProvider).allCategoryListApi(
            isFullScreenLoader: true,
          );
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(commonAppProvider).reachedCategoryLastPage;
        if (!isLoading) {
          ref.read(commonAppProvider).allCategoryListApi();
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
              Center(child: TitleMediumText(title: "Select Category", titleColor: ColorConstants.sheetTitleColor)),
              Positioned(
                right: 0,
                bottom: 2,
                top: 2,
                child: InkWell(
                  onTap: () {
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
            suffixIcon: widget.searchController.text.isNotEmpty
                ? InkWell(
                    onTap: () {
                      commonRead.clearCategoryPaginationData();
                      widget.clearSearchTap();
                      commonRead.allCategoryListApi();
                    },
                    child: Icon(Icons.close))
                : SizedBox.shrink(),
            onFieldSubmitted: (value) {
              context.unFocusKeyboard();
              commonRead.clearCategoryPaginationData();
              commonRead.allCategoryListApi(
                searchName: value,
              );
            },
            height: 40,
            controller: widget.searchController,
            textInputAction: TextInputAction.done,
          ).addAllMargin(12),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: commonWatch.allCategory.isNotEmpty
                ? ListView.builder(
                    controller: scrollController,
                    itemCount: commonWatch.allCategory.length + (commonWatch.reachedCategoryLastPage ? 0 : 1),
                    itemBuilder: (context, index) {
                      if (index == commonWatch.allCategory.length && commonWatch.allCategory.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          widget.onTapItem(commonWatch.allCategory[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: (commonWatch.allCategory[index].isCategorySelected ?? false)
                                ? ColorConstants.bottomTextColor.withOpacity(0.1)
                                : ColorConstants.scaffoldColor,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: BodyMediumText(
                              title: commonWatch.allCategory[index].name ?? '',
                              maxLine: 3,
                              titleTextAlign: TextAlign.center,
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
