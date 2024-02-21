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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(addYourAreaExpertiseProvider).areaCategoryListApiCall(isLoaderVisible: true);
      ref.read(addYourAreaExpertiseProvider).clearSelectChildId();
      ref.read(addYourAreaExpertiseProvider).setCategoryChildDefaultData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addYourAreaExpertiseProviderWatch = ref.watch(addYourAreaExpertiseProvider);
    final addYourAreaExpertiseProviderRead = ref.read(addYourAreaExpertiseProvider);

    return Scaffold(
        appBar: AppBarWidget(
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
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                            itemCount: addYourAreaExpertiseProviderWatch.categoryList?.length ?? 0,
                            itemBuilder: (context, index) {
                              CategoryListData? element = addYourAreaExpertiseProviderWatch.categoryList?[index];

                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      addYourAreaExpertiseProviderWatch.onSelectedCategory(index);
                                      context.toPushNamed(RoutesConstants.selectedExpertCategoryScreen,
                                          args: SelectedCategoryArgument(
                                              categoryId: element?.id.toString() ?? '', isFromExploreExpert: true));
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
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                          4.0.spaceY,
                                          LabelSmallText(
                                            fontSize: 9,
                                            title: element?.name ?? '',
                                          ),
                                        ],
                                      ),
                                      height: 90,
                                      width: 90,
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
              LabelSmallText(
                title: LocaleKeys.suggestNewCategoriesAndTopicsToAdd.tr(),
                titleTextAlign: TextAlign.center,
                fontFamily: FontWeightEnum.w700.toInter,
                maxLine: 2,
              ),
              20.0.spaceY
            ],
          ).addPaddingX(20),
        ));
  }
}
