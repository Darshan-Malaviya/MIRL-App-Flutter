import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/ui/screens/expert_category_screen/arguments/selected_category_arguments.dart';

class ExpertCategoryScreen extends ConsumerStatefulWidget {
  const ExpertCategoryScreen({super.key});

  @override
  ConsumerState createState() => _ExpertCategoryScreenState();
}

class _ExpertCategoryScreenState extends ConsumerState<ExpertCategoryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(addYourAreaExpertiseProvider).areaCategoryListApiCall(isLoaderVisible: true);
      ref.read(addYourAreaExpertiseProvider).clearSelectChildId();
      ref.read(addYourAreaExpertiseProvider).setCategoryChildDefaultData();
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(addYourAreaExpertiseProvider).reachedCategoryLastPage;
        if (!isLoading) {
          await ref.read(addYourAreaExpertiseProvider).areaCategoryListApiCall(isLoaderVisible: false);
        } else {
          log('reach last page on all category list api');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addYourAreaExpertiseProviderWatch = ref.watch(addYourAreaExpertiseProvider);
    final addYourAreaExpertiseProviderRead = ref.read(addYourAreaExpertiseProvider);

    return Scaffold(
        backgroundColor: ColorConstants.greyLightColor,
        appBar: AppBarWidget(
          appBarColor: ColorConstants.greyLightColor,
          leading: InkWell(
            child: Image.asset(ImageConstants.backIcon),
            onTap: () => context.toPop(),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              TitleLargeText(
                title: LocaleKeys.expertCategories.tr().toUpperCase(),
                maxLine: 2,
                titleTextAlign: TextAlign.center,
              ),
              20.0.spaceY,
              LabelSmallText(
                title: LocaleKeys.tapOnWayExpert.tr(),
                titleTextAlign: TextAlign.center,
                fontFamily: FontWeightEnum.w400.toInter,
                maxLine: 2,
              ),
              LabelSmallText(
                title: LocaleKeys.tapOnWayTopic.tr(),
                titleTextAlign: TextAlign.center,
                fontFamily: FontWeightEnum.w400.toInter,
                maxLine: 2,
              ),
              30.0.spaceY,
              Expanded(
                child: addYourAreaExpertiseProviderWatch.isLoading
                    ? CupertinoActivityIndicator(color: ColorConstants.primaryColor)
                    : addYourAreaExpertiseProviderWatch.categoryList?.isNotEmpty ?? false
                        ? GridView.builder(
                            padding: EdgeInsets.zero,
                            controller: scrollController,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 25),
                            itemCount: addYourAreaExpertiseProviderWatch.categoryList?.length ?? 0 + (addYourAreaExpertiseProviderWatch.reachedCategoryLastPage ? 0 : 1),
                            itemBuilder: (context, index) {
                              CategoryListData? element = addYourAreaExpertiseProviderWatch.categoryList?[index];

                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      addYourAreaExpertiseProviderWatch.onSelectedCategory(index);
                                      context.toPushNamed(RoutesConstants.selectedExpertCategoryScreen,
                                          args: SelectedCategoryArgument(categoryId: element?.id.toString() ?? '', isFromExploreExpert: true));
                                    },
                                    child: ShadowContainer(
                                      shadowColor: (addYourAreaExpertiseProviderWatch.categoryList?[index].isVisible ?? false)
                                          ? ColorConstants.categoryListBorder
                                          : ColorConstants.blackColor.withOpacity(0.1),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(20.0),
                                            child: NetworkImageWidget(
                                              boxFit: BoxFit.cover,
                                              imageURL: addYourAreaExpertiseProviderWatch.categoryList?[index].image ?? '',
                                              isNetworkImage: true,
                                              height: 60,
                                              width: 50,
                                            ),
                                          ),
                                          10.0.spaceY,
                                          LabelSmallText(
                                            fontSize: 9,
                                            title: element?.name ?? '',
                                            maxLine: 2,
                                            titleTextAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      height: 120,
                                      width: 100,
                                      isShadow: true,
                                    ),
                                  ),
                                ],
                              );
                            })
                        : Center(
                            child: BodyLargeText(
                              title: StringConstants.noDataFound,
                              fontFamily: FontWeightEnum.w600.toInter,
                            ),
                          ),
              ),
              10.0.spaceY,
              LabelSmallText(
                title: LocaleKeys.suggestNewCategoriesAndTopicsToAdd.tr(),
                titleTextAlign: TextAlign.center,
                maxLine: 2,
              ),
              20.0.spaceY
            ],
          ).addPaddingX(20),
        ));
  }
}
