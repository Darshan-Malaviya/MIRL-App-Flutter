import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/shimmer_widgets/home_page_shimmer.dart';
import 'package:mirl/ui/screens/expert_category_screen/widget/expert_details.dart';
import 'package:mirl/ui/screens/explore_expert_screen/widget/category_image_and_name_list_widget.dart';
import 'package:mirl/ui/screens/filter_screen/widget/filter_args.dart';

class ExploreExpertScreen extends ConsumerStatefulWidget {
  const ExploreExpertScreen({super.key});

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
      ref.read(filterProvider).exploreExpertUserAndCategoryApiCall(context: context);
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(filterProvider).reachedExploreExpertLastPage;
        if (!isLoading) {
          await ref.read(filterProvider).exploreExpertUserAndCategoryApiCall(context: context,  isPaginating: true,);
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
      canPop: true,
      onPopInvoked: (value){
        filterProviderRead.clearAllFilter();
      },
      child: Scaffold(
          backgroundColor: ColorConstants.scaffoldBg,
          appBar: AppBarWidget(
            preferSize: 0,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  InkWell(
                    child: Image.asset(ImageConstants.backIcon),
                      onTap: () {
                        filterProviderRead.clearAllFilter();
                        context.toPop();
                      }),
                  8.0.spaceX,
                  Flexible(
                    child: TextFormFieldWidget(
                      // maxLines: 2,
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
                      hintText: LocaleKeys.searchCategory.tr(),
                      fontFamily: FontWeightEnum.w400.toInter,
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
              ),
              20.0.spaceY,
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
                        if (filterProviderWatch.isLoading) ...[
                          CategoryListShimmerWidget()
                        ] else ...[
                          CategoryNameAndImageListView(),
                        ],
                        PrimaryButton(
                          title: LocaleKeys.filterExperts.tr(),
                          onPressed: () {
                            context.toPushNamed(RoutesConstants.expertCategoryFilterScreen,
                                args: FilterArgs(fromExploreExpert: true));
                          },
                          prefixIcon: ImageConstants.filter,
                          prefixIconPadding: 10,
                        ),
                        if(filterProviderWatch.commonSelectionModel.isNotEmpty)...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              20.0.spaceY,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  BodySmallText(title: LocaleKeys.appliedFilters.tr(),),
                                  InkWell(
                                      onTap: () {
                                        filterProviderRead.clearAllFilter();
                                        filterProviderRead.exploreExpertUserAndCategoryApiCall(context: context);
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
                                      OnScaleTap(
                                        onPress: () {
                                          filterProviderRead.removeFilter(index: index, context: context,isFromExploreExpert: true,);
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
                          ).addPaddingXY(paddingX: 16,paddingY: 10)
                        ],
                        40.0.spaceY,
                        if (filterProviderWatch.categoryList?.expertData?.isNotEmpty ?? false) ...[
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                              itemBuilder: (context, i) {
                                if (i == (filterProviderWatch.categoryList?.expertData?.length ?? 0) &&
                                    (filterProviderWatch.categoryList?.expertData?.isNotEmpty ?? false)) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                                  );
                                }
                                return ExpertDetailWidget(
                                  expertData: filterProviderWatch.categoryList?.expertData?[i],
                                );
                              },
                              separatorBuilder: (context, index) => 20.0.spaceY,
                              itemCount: (filterProviderWatch.categoryList?.expertData?.length ?? 0) + (filterProviderWatch.reachedExploreExpertLastPage ? 0 : 1)),
                        ] else ...[
                          Center(
                            child: BodyLargeText(
                              title: LocaleKeys.thereWasNoExpertDataAvailable.tr(),
                              fontFamily: FontWeightEnum.w600.toInter,
                              maxLine: 2,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ]
            ],
          ).addAllPadding(20)),
    );
  }
}
