import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/ui/screens/edit_profile/widget/child_category_bottom_view.dart';

class AddYourAreasOfExpertiseScreen extends ConsumerStatefulWidget {
  const AddYourAreasOfExpertiseScreen({super.key});

  @override
  ConsumerState<AddYourAreasOfExpertiseScreen> createState() => _AddYourAreasOfExpertiseScreenState();
}

class _AddYourAreasOfExpertiseScreenState extends ConsumerState<AddYourAreasOfExpertiseScreen> {
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
        trailingIcon: InkWell(
          onTap: () {
            addYourAreaExpertiseProviderRead.childUpdateApiCall(context: context);
          },
          child: TitleMediumText(
            title: StringConstants.done,
            fontFamily: FontWeightEnum.w700.toInter,
          ),
        ).addPaddingRight(14),
      ),
      body: Column(
        children: [
          TitleLargeText(
            title: StringConstants.addYourAreas,
            titleColor: ColorConstants.bottomTextColor,
            fontFamily: FontWeightEnum.w700.toInter,
            maxLine: 2,
            titleTextAlign: TextAlign.center,
          ),
          20.0.spaceY,
          TitleSmallText(
            fontFamily: FontWeightEnum.w400.toInter,
            title: StringConstants.categoryView,
            titleTextAlign: TextAlign.center,
            maxLine: 3,
          ),
          20.0.spaceY,
          Expanded(
            child: addYourAreaExpertiseProviderWatch.categoryList?.isNotEmpty ?? false
                ? GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                    itemCount: addYourAreaExpertiseProviderWatch.categoryList?.length ?? 0,
                    itemBuilder: (context, index) {
                      CategoryListData? element = addYourAreaExpertiseProviderWatch.categoryList?[index];

                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              addYourAreaExpertiseProviderWatch.onSelectedCategory(index);
                              CommonBottomSheet.bottomSheet(
                                  context: context,
                                  isDismissible: true,
                                  backgroundColor: ColorConstants.categoryList,
                                  child: ChildCategoryBottomView(
                                    childCategoryList: element,
                                  ));
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
                                      imageURL:
                                      addYourAreaExpertiseProviderWatch.categoryList?[index].image ?? '',
                                      isNetworkImage: true,
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  4.0.spaceY,
                                  LabelSmallText(
                                    fontSize: 9,
                                    title: element?.parentName ?? '',
                                    titleColor: ColorConstants.blackColor,
                                    fontFamily: FontWeightEnum.w700.toInter,
                                    titleTextAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              height: 90,
                              width: 90,
                              isShadow: true,
                            ).addPaddingTop(5),
                          ),
                          if (element?.badgecount != 0) ...[
                            Positioned(
                                top: 0,
                                right: 15,
                                child: CircleAvatar(
                                  child: TitleMediumText(
                                    title: element?.badgecount.toString() ?? '0',
                                    fontWeight: FontWeight.w600,
                                    titleColor: ColorConstants.blackColor,
                                  ),
                                  radius: 14,
                                  backgroundColor: ColorConstants.primaryColor,
                                ))
                          ]
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
          PrimaryButton(
              title: StringConstants.setYourExpertise,
              onPressed: () {
                addYourAreaExpertiseProviderRead.childUpdateApiCall(context: context);
              })
        ],
      ).addAllPadding(20),
    );
  }
}
