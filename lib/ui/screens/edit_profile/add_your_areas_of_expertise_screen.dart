import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/ui/screens/edit_profile/widget/child_category_bottom_view.dart';

class AddYourAreasOfExpertiseScreen extends ConsumerStatefulWidget {
  const AddYourAreasOfExpertiseScreen({super.key});

  @override
  ConsumerState<AddYourAreasOfExpertiseScreen> createState() => _AddYourAreasOfExpertiseScreenState();
}

class _AddYourAreasOfExpertiseScreenState extends ConsumerState<AddYourAreasOfExpertiseScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(editExpertProvider).getUserData();
      await ref.read(addYourAreaExpertiseProvider).areaCategoryListApiCall(isLoaderVisible: true);
      ref.read(addYourAreaExpertiseProvider).clearSelectChildId();
      ref.read(addYourAreaExpertiseProvider).setCategoryChildDefaultData();
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(addYourAreaExpertiseProvider).reachedCategoryLastPage;
        if (!isLoading) {
          await ref.read(addYourAreaExpertiseProvider).areaCategoryListApiCall();
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
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
        trailingIcon: InkWell(
          onTap: () async {
            await addYourAreaExpertiseProviderRead.childUpdateApiCall(context: context);
            ref.read(editExpertProvider).getUserData();
            context.toPop();
          },
          child: TitleMediumText(
            title: StringConstants.done,
          ),
        ).addPaddingRight(14),
      ),
      body: Column(
        children: [
          TitleLargeText(
            title: StringConstants.addYourAreas,
            titleColor: ColorConstants.bottomTextColor,
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
            child: addYourAreaExpertiseProviderWatch.isLoading
                ? CupertinoActivityIndicator(color: ColorConstants.primaryColor)
                : addYourAreaExpertiseProviderWatch.categoryList?.isNotEmpty ?? false
                    ? GridView.builder(
                        controller: scrollController,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                        itemCount: ((addYourAreaExpertiseProviderWatch.categoryList?.length ?? 0) + (addYourAreaExpertiseProviderWatch.reachedCategoryLastPage ? 0 : 1)),
                        itemBuilder: (context, index) {
                          if (index == addYourAreaExpertiseProviderWatch.categoryList?.length && (addYourAreaExpertiseProviderWatch.categoryList?.isNotEmpty ?? false)) {
                            /*  return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                        );*/
                          } else {
                            CategoryListData? element = addYourAreaExpertiseProviderWatch.categoryList?[index];

                            return Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (element?.topic?.isNotEmpty ?? false) {
                                      addYourAreaExpertiseProviderWatch.onSelectedCategory(index);
                                      CommonBottomSheet.bottomSheet(
                                          context: context,
                                          isDismissible: true,
                                          backgroundColor: ColorConstants.categoryList,
                                          child: ChildCategoryBottomView(
                                            childCategoryList: element,
                                          ));
                                    } else {
                                      FlutterToast().showToast(msg: LocaleKeys.thereAreNoAvailableTopics.tr());
                                    }
                                  },
                                  child: ShadowContainer(
                                    shadowColor: (addYourAreaExpertiseProviderWatch.categoryList?[index].isVisible ?? false)
                                        ? ColorConstants.categoryListBorder
                                        : ColorConstants.blackColor.withOpacity(0.1),
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                    blurRadius: 3,
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
                                          titleTextAlign: TextAlign.center,
                                          maxLine: 2,
                                        ),
                                      ],
                                    ),
                                    height: 100,
                                    width: 100,
                                    isShadow: true,
                                  ).addPaddingTop(5),
                                ),
                                if (element?.badgeCount != 0) ...[
                                  Positioned(
                                      top: 0,
                                      right: 15,
                                      child: CircleAvatar(
                                        child: TitleMediumText(
                                          title: element?.badgeCount.toString() ?? '0',
                                          fontFamily: FontWeightEnum.w600.toInter,
                                          titleColor: ColorConstants.blackColor,
                                        ),
                                        radius: 14,
                                        backgroundColor: ColorConstants.primaryColor,
                                      ))
                                ]
                              ],
                            );
                          }
                          return SizedBox.shrink();
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
              onPressed: () async {
                await addYourAreaExpertiseProviderRead.childUpdateApiCall(context: context);
                ref.read(editExpertProvider).getUserData();
                context.toPop();
              })
        ],
      ).addAllPadding(20),
    );
  }
}
