import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/shimmer_widgets/home_page_shimmer.dart';
import 'package:mirl/ui/screens/expert_category_screen/widget/expert_details_widget.dart';
import 'package:mirl/ui/screens/explore_expert_screen/widget/category_image_and_name_list_widget.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';

class ExploreExpertScreen extends ConsumerStatefulWidget {
  final bool isFromHomePage;

  const ExploreExpertScreen({super.key, required this.isFromHomePage});

  @override
  ConsumerState<ExploreExpertScreen> createState() => _ExploreExpertScreenState();
}

class _ExploreExpertScreenState extends ConsumerState<ExploreExpertScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(filterProvider).clearExploreExpertSearchData();
      ref.read(filterProvider).clearExploreController();
      ref.read(filterProvider).exploreExpertUserAndCategoryApiCall(context: context, clearFilter: true);
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(filterProvider).reachedExploreExpertLastPage;
        if (!isLoading) {
          await ref.read(filterProvider).exploreExpertUserAndCategoryApiCall(context: context, isPaginating: true);
        } else {
          log('reach last page on explore export data list api');
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
      canPop: widget.isFromHomePage ? false : true,
      onPopInvoked: (value) {
        filterProviderRead.clearAllFilter();
      },
      child: Scaffold(
          backgroundColor: ColorConstants.greyLightColor,
          appBar: AppBarWidget(
            preferSize: 0,
            appBarColor: ColorConstants.greyLightColor,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (!widget.isFromHomePage) ...[
                    InkWell(
                        child: Image.asset(ImageConstants.backIcon),
                        onTap: () {
                          filterProviderRead.clearAllFilter();
                          context.toPop();
                        }),
                    8.0.spaceX,
                  ],
                  Flexible(
                    child: TextFormFieldWidget(
                      textAlign: TextAlign.start,
                      suffixIcon: filterProviderWatch.exploreExpertController.text.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                filterProviderRead.clearExploreExpertSearchData();
                                filterProviderRead.clearExploreController();
                                filterProviderRead.exploreExpertUserAndCategoryApiCall(context: context);
                              },
                              child: Icon(Icons.close),
                            )
                          : SizedBox.shrink(),
                      hintText: LocaleKeys.typeAnyCategoryHint.tr(),
                      hintTextColor: ColorConstants.blackColor,
                      enabledBorderColor: ColorConstants.dropDownBorderColor,
                      focusedBorderColor: ColorConstants.dropDownBorderColor,
                      controller: filterProviderWatch.exploreExpertController,
                      onChanged: (value) {
                        if (filterProviderWatch.exploreExpertController.text.isNotEmpty) {
                          filterProviderRead.clearExploreExpertSearchData();
                          filterProviderRead.exploreExpertUserAndCategoryApiCall(context: context);
                        }
                      },
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        context.unFocusKeyboard();
                      },
                    ),
                  ),
                ],
              ).addMarginXY(marginX: 20, marginY: 10),
              if (filterProviderWatch.isLoading) ...[
                Center(
                    child: CupertinoActivityIndicator(
                  animating: true,
                  color: ColorConstants.primaryColor,
                  radius: 16,
                ).addPaddingY(20)),
              ] else ...[
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        5.0.spaceY,
                        if (filterProviderWatch.isLoading) ...[
                          CategoryListShimmerWidget()
                        ] else ...[
                          CategoryNameAndImageListView(),
                        ],
                        PrimaryButton(
                          title: LocaleKeys.filterExperts.tr(),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          onPressed: () {
                            context.toPushNamed(RoutesConstants.expertCategoryFilterScreen, args: FilterArgs(fromExploreExpert: true));
                          },
                          prefixIcon: ImageConstants.filter,
                          titleColor: ColorConstants.blackColor,
                          buttonTextFontFamily: FontWeightEnum.w400.toInter,
                          prefixIconPadding: 10,
                          padding: EdgeInsets.symmetric(horizontal: 100),
                        ),
                        if (filterProviderWatch.commonSelectionModel.isNotEmpty) ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              10.0.spaceY,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  BodySmallText(
                                    title: LocaleKeys.appliedFilters.tr(),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        filterProviderRead.clearAllFilter();
                                        filterProviderRead.exploreExpertUserAndCategoryApiCall(context: context);
                                      },
                                      child: BodySmallText(
                                        title: LocaleKeys.clearAll.tr(),
                                      ).addAllPadding(5)),
                                ],
                              ),
                              5.0.spaceY,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(filterProviderWatch.commonSelectionModel.length, (index) {
                                  final data = filterProviderWatch.commonSelectionModel[index];
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      OnScaleTap(
                                        onPress: () {
                                          filterProviderRead.removeFilter(
                                            index: index,
                                            context: context,
                                            isFromExploreExpert: true,
                                          );
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
                        if (filterProviderWatch.categoryList?.expertData?.isNotEmpty ?? false) ...[
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(20),
                              itemBuilder: (context, i) {
                                if (i == (filterProviderWatch.categoryList?.expertData?.length ?? 0) && (filterProviderWatch.categoryList?.expertData?.isNotEmpty ?? false)) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                                  );
                                }
                                return ExpertDetailWidget(
                                  expertData: filterProviderWatch.categoryList?.expertData?[i],
                                );
                              },
                              separatorBuilder: (context, index) => 30.0.spaceY,
                              itemCount: (filterProviderWatch.categoryList?.expertData?.length ?? 0) + (filterProviderWatch.reachedExploreExpertLastPage ? 0 : 1)),
                        ] else ...[
                          Column(
                            children: [
                              BodySmallText(
                                title: LocaleKeys.noResultFound.tr(),
                                fontFamily: FontWeightEnum.w600.toInter,
                              ),
                              20.0.spaceY,
                              BodySmallText(
                                title: LocaleKeys.tryWideningYourSearch.tr(),
                                fontFamily: FontWeightEnum.w400.toInter,
                                titleTextAlign: TextAlign.center,
                                maxLine: 5,
                              ),
                            ],
                          ).addMarginX(40),
                        ]
                      ],
                    ),
                  ),
                ),
              ]
            ],
          )),
    );
  }
}
