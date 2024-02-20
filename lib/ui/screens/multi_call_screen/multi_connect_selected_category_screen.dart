import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';
import 'package:mirl/infrastructure/models/request/expert_data_request_model.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
import 'package:mirl/ui/screens/expert_category_screen/widget/expert_details_widget.dart';

class MultiConnectSelectedCategoryScreen extends ConsumerStatefulWidget {
  final FilterArgs args;

  const MultiConnectSelectedCategoryScreen({super.key, required this.args});

  @override
  ConsumerState createState() => _MultiConnectSelectedCategoryScreenState();
}

class _MultiConnectSelectedCategoryScreenState extends ConsumerState<MultiConnectSelectedCategoryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(multiConnectProvider).getSingleCategoryApiCall(
          categoryId: widget.args.categoryId ?? '', context: context, requestModel: ExpertDataRequestModel(userId: SharedPrefHelper.getUserId, multiConnectRequest: 'true'));
      ref.read(filterProvider).setCategoryWhenFromMultiConnect(ref.watch(multiConnectProvider).singleCategoryData?.categoryData);
    });

    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(multiConnectProvider).reachedAllExpertLastPage;
        if (!isLoading) {
          ref.read(multiConnectProvider).getSingleCategoryApiCall(
              categoryId: widget.args.categoryId ?? '',
              context: context,
              isPaginating: true,
              requestModel: ExpertDataRequestModel(
                userId: SharedPrefHelper.getUserId,
                multiConnectRequest: 'true',
              ));
        } else {
          log('reach last page on selected category export data list api');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final multiProviderWatch = ref.watch(multiConnectProvider);
    final multiProviderRead = ref.read(multiConnectProvider);
    final filterRead = ref.read(filterProvider);
    final filterWatch = ref.watch(filterProvider);

    return PopScope(
      canPop: true,
      onPopInvoked: (value) {
        multiProviderRead.clearExpertIds();
        filterRead.clearAllFilter();
      },
      child: Scaffold(
        backgroundColor: ColorConstants.greyLightColor,
        appBar: AppBarWidget(
            appBarColor: ColorConstants.greyLightColor,
            preferSize: 40,
            leading: InkWell(
              child: Image.asset(ImageConstants.backIcon),
              onTap: () {
                multiProviderRead.clearExpertIds();
                filterRead.clearAllFilter();
                context.toPop();
              },
            ),
            trailingIcon: InkWell(
              onTap: () {
                FlutterToast().showToast(msg: 'You have chosen ${multiProviderWatch.selectedExperts.length} experts for multi connect.');
              },
              child: TitleMediumText(
                title: StringConstants.done,
              ).addPaddingRight(14),
            ).addVisibility(multiProviderWatch.selectedExperts.isNotEmpty)),
        body: multiProviderWatch.isLoading
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
                    TitleLargeText(
                      title: LocaleKeys.multipleConnect.tr(),
                      maxLine: 2,
                      titleTextAlign: TextAlign.center,
                    ),
                    20.0.spaceY,
                    if (multiProviderWatch.singleCategoryData?.categoryData != null) ...[
                      ShadowContainer(
                        shadowColor: ColorConstants.categoryListBorder,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: NetworkImageWidget(
                                boxFit: BoxFit.cover,
                                imageURL: multiProviderWatch.singleCategoryData?.categoryData?.image ?? '',
                                isNetworkImage: true,
                                height: 50,
                                width: 50,
                              ),
                            ),
                            4.0.spaceY,
                            LabelSmallText(
                              fontSize: 9,
                              title: multiProviderWatch.singleCategoryData?.categoryData?.name ?? '',
                              titleColor: ColorConstants.blackColor,
                              fontFamily: FontWeightEnum.w700.toInter,
                              titleTextAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        height: 90,
                        width: 90,
                        isShadow: true,
                      )
                    ],
                    20.0.spaceY,
                    if (multiProviderWatch.singleCategoryData?.categoryData?.topic?.isNotEmpty ?? false) ...[
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
                          children: List.generate(multiProviderWatch.singleCategoryData?.categoryData?.topic?.length ?? 0, (index) {
                            final data = multiProviderWatch.singleCategoryData?.categoryData?.topic?[index];
                            int topicIndex = filterWatch.allTopic.indexWhere((element) => element.id == data?.id);
                            return OnScaleTap(
                              onPress: () {},
                              child: ShadowContainer(
                                shadowColor: (topicIndex != -1 && (filterWatch.allTopic[topicIndex].isCategorySelected ?? false))
                                    ? ColorConstants.primaryColor
                                    : ColorConstants.blackColor.withOpacity(0.1),
                                backgroundColor: ColorConstants.whiteColor,
                                isShadow: true,
                                spreadRadius: 1,
                                blurRadius: 2,
                                margin: EdgeInsets.only(bottom: 10, right: 10),
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                    ],
                    30.0.spaceY,
                    PrimaryButton(
                      title: LocaleKeys.filterFromTopicAndCategories.tr(),
                      titleColor: ColorConstants.blackColor,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      onPressed: () => context.toPushNamed(RoutesConstants.multiConnectFilterScreen),
                      prefixIcon: ImageConstants.filter,
                      prefixIconPadding: 10,
                    ),
                    20.0.spaceY,
                    if (filterWatch.commonSelectionModel.isNotEmpty) ...[
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
                                  onTap: () async {
                                    multiProviderRead.clearExpertIds();
                                    filterRead.clearAllFilter(selectedCategoryClearAll: true);
                                    await multiProviderRead.getSingleCategoryApiCall(
                                      context: context,
                                      categoryId: widget.args.categoryId ?? '',
                                      requestModel: ExpertDataRequestModel(
                                        userId: SharedPrefHelper.getUserId,
                                        multiConnectRequest: 'true',
                                      ),
                                    );
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
                            children: List.generate(filterWatch.commonSelectionModel.length, (index) {
                              final data = filterWatch.commonSelectionModel[index];
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (data.title != FilterType.Category.name) ...[
                                    OnScaleTap(
                                      onPress: () {
                                        filterRead.removeFilter(
                                            index: index, context: context, isFromMultiConnect: true, singleCategoryId: widget.args.categoryId, multiConnectRequest: 'true');
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
                    if (multiProviderWatch.expertData?.isNotEmpty ?? false) ...[
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => 20.0.spaceY,
                        itemCount: (multiProviderWatch.expertData?.length ?? 0) + (multiProviderWatch.reachedAllExpertLastPage ? 0 : 1),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        itemBuilder: (context, i) {
                          if (i == (multiProviderWatch.expertData?.length ?? 0) && (multiProviderWatch.expertData?.isNotEmpty ?? false)) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                            );
                          }
                          return Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              ExpertDetailWidget(
                                expertData: multiProviderWatch.expertData?[i],
                                fromMultiConnect: true,
                              ).addMarginBottom(22),
                              PrimaryButton(
                                title: multiProviderWatch.expertData?[i].selectedForMultiConnect ?? false ? LocaleKeys.selected.tr() : LocaleKeys.clickToSelect.tr(),
                                buttonColor: multiProviderWatch.expertData?[i].selectedForMultiConnect ?? false ? ColorConstants.primaryColor : ColorConstants.buttonColor,
                                width: 140,
                                onPressed: () {
                                  multiProviderRead.setSelectedExpert(i);
                                },
                              )
                            ],
                          );
                        },
                      )
                    ] else ...[
                      Container(
                        height: 100,
                        child: Center(
                          child: BodyLargeText(
                            title: LocaleKeys.thereWasNoExpertDataAvailable.tr(),
                            fontFamily: FontWeightEnum.w600.toInter,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
      ),
    );
  }
}
