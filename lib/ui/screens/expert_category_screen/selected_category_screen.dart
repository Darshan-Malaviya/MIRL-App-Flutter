import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/expert_data_request_model.dart';
import 'package:mirl/ui/common/container_widgets/category_common_view.dart';
import 'package:mirl/ui/screens/expert_category_screen/arguments/selected_category_arguments.dart';
import 'package:mirl/ui/screens/expert_category_screen/widget/expert_details_widget.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';

class SelectedCategoryScreen extends ConsumerStatefulWidget {
  final SelectedCategoryArgument args;

  const SelectedCategoryScreen({super.key, required this.args});

  @override
  ConsumerState createState() => _SelectedCategoryScreenState();
}

class _SelectedCategoryScreenState extends ConsumerState<SelectedCategoryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(filterProvider).clearSingleCategoryData();
      await ref
          .read(filterProvider)
          .getSingleCategoryApiCall(categoryId: widget.args.categoryId, requestModel: ExpertDataRequestModel(userId: SharedPrefHelper.getUserId), context: context);
      ref.read(filterProvider).getSelectedCategory();
      if (ref.watch(filterProvider).allTopic.isEmpty) {
        ref.read(filterProvider).clearSearchTopicController();
        ref.read(filterProvider).clearTopicPaginationData();
        ref.read(filterProvider).topicListByCategory(
              isFullScreenLoader: false,
              categoryId: widget.args.categoryId,
            );
      }
    });

    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(filterProvider).reachedOneCategoryScreenLastPage;
        if (!isLoading) {
          await ref.read(filterProvider).getSingleCategoryApiCall(
              isPaginating: true, categoryId: widget.args.categoryId, requestModel: ExpertDataRequestModel(userId: SharedPrefHelper.getUserId), context: context);
        } else {
          log('reach last page on selected category export data list api');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filterProviderWatch = ref.watch(filterProvider);
    final filterProviderRead = ref.read(filterProvider);

    return PopScope(
      canPop: true,
      onPopInvoked: (value) {
        filterProviderRead.clearAllFilter();
        if (widget.args.isFromExploreExpert) {
          ref.read(filterProvider).clearExploreExpertSearchData();
          ref.read(filterProvider).clearExploreController();
          ref.read(filterProvider).exploreExpertUserAndCategoryApiCall(context: context, isFromFilter: false, isPaginating: false);
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.scaffoldBg,
        appBar: AppBarWidget(
          appBarColor: ColorConstants.scaffoldBg,
          leading: InkWell(
              child: Image.asset(ImageConstants.backIcon),
              onTap: () {
                filterProviderRead.clearAllFilter();
                if (widget.args.isFromExploreExpert) {
                  ref.read(filterProvider).clearExploreExpertSearchData();
                  ref.read(filterProvider).clearExploreController();
                  ref.read(filterProvider).exploreExpertUserAndCategoryApiCall(context: context, isFromFilter: false, isPaginating: false);
                }
                context.toPop();
              }),
        ),
        body: filterProviderWatch.isLoading
            ? Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                  color: ColorConstants.primaryColor,
                  radius: 16,
                ),
              )
            : SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: TitleLargeText(
                        title: filterProviderWatch.singleCategoryData?.categoryData?.name ?? '',
                        fontSize: 20,
                        titleTextAlign: TextAlign.center,
                        maxLine: 5,
                      ),
                    ).addPaddingX(20),
                    10.0.spaceY,
                    LabelSmallText(
                      title: StringConstants.needAMentor,
                      fontFamily: FontWeightEnum.w400.toInter,
                      maxLine: 2,
                      titleTextAlign: TextAlign.center,
                    ).addPaddingX(20),
                    20.0.spaceY,
                    CategoryCommonView(
                      onTap: () {},
                      categoryName: filterProviderWatch.singleCategoryData?.categoryData?.name ?? '',
                      imageUrl: filterProviderWatch.singleCategoryData?.categoryData?.image ?? '',
                      isSelectedShadow: true,
                      blurRadius: 8,
                      spreadRadius: 1,),
                    20.0.spaceY,
                    if (filterProviderWatch.singleCategoryData?.categoryData?.topic?.isNotEmpty ?? false) ...[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: ColorConstants.scaffoldBg,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              color: ColorConstants.blackColor.withOpacity(0.1),
                              spreadRadius: 2.0,
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Wrap(
                          children: List.generate(filterProviderWatch.singleCategoryData?.categoryData?.topic?.length ?? 0, (index) {
                            final data = filterProviderWatch.singleCategoryData?.categoryData?.topic?[index];
                            int topicIndex = filterProviderWatch.allTopic.indexWhere((element) => element.id == data?.id);
                            return OnScaleTap(
                              onPress: () {},
                              child: ShadowContainer(
                                shadowColor: (topicIndex != -1 && (filterProviderWatch.allTopic[topicIndex].isCategorySelected ?? false))
                                    ? ColorConstants.primaryColor
                                    : ColorConstants.blackColor.withOpacity(0.1),
                                backgroundColor: ColorConstants.whiteColor,
                                isShadow: true,
                                spreadRadius: 1,
                                blurRadius: 2,
                                margin: EdgeInsets.only(bottom: 10, right: 10),
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                // offset: Offset(0, 3),
                                child: BodyMediumText(
                                  title: data?.name ?? '',
                                  fontFamily: FontWeightEnum.w500.toInter,
                                  maxLine: 5,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      20.0.spaceY,
                      BodyMediumText(
                        title: StringConstants.topicText,
                        fontFamily: FontWeightEnum.w400.toInter,
                      ),
                      5.0.spaceY,
                      if (filterProviderWatch.selectedTopicList?.isNotEmpty ?? false) ...[
                        Wrap(
                          children: List.generate(filterProviderWatch.selectedTopicList?.length ?? 0, (index) {
                            return BodyMediumText(
                              title: filterProviderWatch.selectedTopicList?[index].name.toString() ?? '',
                              maxLine: 3,
                            ).addPaddingX(4);
                          }),
                        ),
                        10.0.spaceY,
                      ]
                    ],
                    BodyMediumText(
                      title: StringConstants.descriptionText,
                      fontFamily: FontWeightEnum.w400.toInter,
                      maxLine: 5,
                      titleTextAlign: TextAlign.center,
                    ).addPaddingX(20),
                    20.0.spaceY,
                    PrimaryButton(
                      title: StringConstants.filterExpertCategory,
                      titleColor: ColorConstants.blackColor,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      onPressed: () {
                        context.toPushNamed(RoutesConstants.expertCategoryFilterScreen, args: FilterArgs(fromExploreExpert: false));
                      },
                      prefixIcon: ImageConstants.filter,
                      prefixIconPadding: 10,
                      buttonTextFontFamily: FontWeightEnum.w400.toInter,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                    ),
                    if (filterProviderWatch.commonSelectionModel.isNotEmpty) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          20.0.spaceY,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodySmallText(
                                title: LocaleKeys.appliedFilters.tr(),
                              ),
                              InkWell(
                                  onTap: () {
                                    filterProviderRead.clearAllFilter(selectedCategoryClearAll: true);
                                    filterProviderRead.getSingleCategoryApiCall(
                                        context: context, categoryId: widget.args.categoryId, requestModel: ExpertDataRequestModel(userId: SharedPrefHelper.getUserId));
                                    // filterProviderRead.getSelectedCategory();
                                  },
                                  child: BodySmallText(
                                    title: LocaleKeys.clearAll.tr(),
                                  )),
                            ],
                          ),
                          10.0.spaceY,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(filterProviderWatch.commonSelectionModel.length, (index) {
                              final data = filterProviderWatch.commonSelectionModel[index];
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (data.title != FilterType.Category.name) ...[
                                    OnScaleTap(
                                      onPress: () {
                                        filterProviderRead.removeFilter(index: index, context: context, isFromExploreExpert: false, singleCategoryId: widget.args.categoryId);
                                      },
                                      child: ShadowContainer(
                                        border: 20,
                                        height: 30,
                                        width: 30,
                                        shadowColor: ColorConstants.borderColor,
                                        backgroundColor: ColorConstants.yellowButtonColor,
                                        offset: Offset(0, 3),
                                        child: Center(child: Image.asset(ImageConstants.cancel)),
                                      ),
                                    ),
                                    20.0.spaceX,
                                  ],
                                  Flexible(
                                    child: ShadowContainer(
                                      border: 10,
                                      child: BodyMediumText(
                                        maxLine: 10,
                                        title: '${data.title}: ${data.value}',
                                        fontFamily: FontWeightEnum.w400.toInter,
                                      ),
                                    ),
                                  )
                                ],
                              ).addPaddingY(10);
                            }),
                          ),
                        ],
                      ).addPaddingXY(paddingX: 16, paddingY: 10)
                    ],
                    20.0.spaceY,
                    if (filterProviderWatch.singleCategoryData?.expertData?.isNotEmpty ?? false) ...[
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                          itemBuilder: (context, i) {
                            if (i == (filterProviderWatch.singleCategoryData?.expertData?.length ?? 0) &&
                                (filterProviderWatch.singleCategoryData?.expertData?.isNotEmpty ?? false)) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                              );
                            }
                            return ExpertDetailWidget(
                              expertData: filterProviderWatch.singleCategoryData?.expertData?[i],
                            );
                          },
                          separatorBuilder: (context, index) => 20.0.spaceY,
                          itemCount: (filterProviderWatch.singleCategoryData?.expertData?.length ?? 0) + (filterProviderWatch.reachedOneCategoryScreenLastPage ? 0 : 1))
                    ] else ...[
                      Center(
                        child: BodyLargeText(
                          title: LocaleKeys.thereWasNoExpertDataAvailable.tr(),
                          fontFamily: FontWeightEnum.w600.toInter,
                          maxLine: 2,
                        ),
                      ),
                      40.0.spaceY,
                    ]
                  ],
                ),
              ),
      ),
    );
  }
}
