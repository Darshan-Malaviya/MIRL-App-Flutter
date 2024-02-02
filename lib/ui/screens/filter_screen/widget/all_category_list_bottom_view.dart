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
          TitleMediumText(title: "Select Category", titleColor: ColorConstants.sheetTitleColor),
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
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: BodyMediumText(
                              title: commonWatch.allCategory[index].name ?? '',
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
