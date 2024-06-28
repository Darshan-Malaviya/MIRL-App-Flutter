import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class AllCategoryListBottomView extends ConsumerStatefulWidget {
  const AllCategoryListBottomView({super.key});

  @override
  ConsumerState<AllCategoryListBottomView> createState() => _AllCategoryListBottomViewState();
}

class _AllCategoryListBottomViewState extends ConsumerState<AllCategoryListBottomView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.read(filterProvider).allCategory.isEmpty) {
        ref.read(filterProvider).clearSearchCategoryController();
        ref.read(filterProvider).clearCategoryPaginationData();
        ref.read(filterProvider).allCategoryListApi(isFullScreenLoader: true);
      }
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(filterProvider).reachedCategoryLastPage;
        if (!isLoading) {
          ref.read(filterProvider).allCategoryListApi();
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
            TitleMediumText(title: LocaleKeys.selectCategory.tr().toUpperCase(), titleColor: ColorConstants.sheetTitleColor),
            16.0.spaceY,
            TextFormFieldWidget(
              isReadOnly: false,
              hintText: LocaleKeys.searchHere.tr(),
              suffixIcon: filterProviderWatch.searchCategoryController.text.isNotEmpty
                  ? InkWell(
                      onTap: () {
                        filterProviderRead.clearCategoryPaginationData();
                        filterProviderRead.clearSearchCategoryController();
                        filterProviderRead.allCategoryListApi();
                      },
                      child: Icon(Icons.close))
                  : SizedBox.shrink(),
              onFieldSubmitted: (value) =>context.unFocusKeyboard(),
              onChanged: (value) {
                filterProviderRead.clearCategoryPaginationData();
                filterProviderRead.allCategoryListApi(searchName: value);
              },
              height: 40,
              controller: filterProviderWatch.searchCategoryController,
              textInputAction: TextInputAction.done,
            ).addAllMargin(12),
            Expanded(
              child: filterProviderRead.isSearchCategoryBottomSheetLoading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                    )
                  : filterProviderWatch.allCategory.isNotEmpty
                      ? ListView.builder(
                          controller: scrollController,
                          itemCount: filterProviderWatch.allCategory.length + (filterProviderWatch.reachedCategoryLastPage ? 0 : 1),
                          itemBuilder: (context, index) {
                            if (index == filterProviderWatch.allCategory.length && filterProviderWatch.allCategory.isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                              );
                            }
                            return InkWell(
                              onTap: () {
                                filterProviderWatch.setCategory(selectionIndex: index);
                                context.toPop();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: (index == filterProviderWatch.categorySelectionIndex) ? ColorConstants.bottomTextColor.withOpacity(0.1) : ColorConstants.scaffoldColor,
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: BodyMediumText(
                                    title: filterProviderWatch.allCategory[index].name ?? '',
                                    maxLine: 3,
                                    titleTextAlign: TextAlign.center,
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
