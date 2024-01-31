import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/ui/screens/edit_profile/widget/child_category_bottom_view.dart';

class ExpertCategoryScreen extends ConsumerStatefulWidget {
  const ExpertCategoryScreen({super.key});

  @override
  ConsumerState createState() => _ExpertCategoryScreenState();
}

class _ExpertCategoryScreenState extends ConsumerState<ExpertCategoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(addYourAreaExpertiseProvider).areaCategoryListApiCall();
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
      body: Column(
        children: [
          TitleLargeText(
            title: StringConstants.expertCategories,
            maxLine: 2,
            titleTextAlign: TextAlign.center,
          ),
          20.0.spaceY,
          LabelSmallText(
            title: StringConstants.tapOnWayExpert,
            titleTextAlign: TextAlign.center,
            fontFamily: FontWeightEnum.w400.toInter,
            maxLine: 2,
          ),
          LabelSmallText(
            title: StringConstants.tapOnWayTopic,
            titleTextAlign: TextAlign.center,
            fontFamily: FontWeightEnum.w400.toInter,
            maxLine: 2,
          ),
          30.0.spaceY,
          Expanded(
            child: addYourAreaExpertiseProviderWatch.categoryList?.isNotEmpty ?? false
                ? GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                    itemCount: addYourAreaExpertiseProviderWatch.categoryList?.length ?? 0,
                    itemBuilder: (context, index) {
                      CategoryListData? element = addYourAreaExpertiseProviderWatch.categoryList?[index];

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              addYourAreaExpertiseProviderWatch.onSelectedCategory(index);
                              context.toPushNamed(RoutesConstants.selectedExpertCategoryScreen);
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
                                    titleColor: ColorConstants.blackColor,
                                    fontFamily: FontWeightEnum.w700.toInter,
                                    titleTextAlign: TextAlign.center,
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
        ],
      ).addPaddingX(20),
    );
  }
}
