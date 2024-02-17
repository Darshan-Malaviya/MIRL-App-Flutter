import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
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
    if(!(widget.args.fromMultiConnectFilterBack ?? false)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(multiConnectProvider).getSingleCategoryApiCall(
            categoryId: widget.args.categoryId ?? '', context: context, requestModel: ExpertDataRequestModel(userId: SharedPrefHelper.getUserId, multiConnectRequest: 'true'));
      });

      scrollController.addListener(() async {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          bool isLoading = ref
              .watch(multiConnectProvider)
              .reachedAllExpertLastPage;
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
  }

  @override
  Widget build(BuildContext context) {
    final multiProviderWatch = ref.watch(multiConnectProvider);
    final filterRead = ref.read(filterProvider);

    return PopScope(
      canPop: true,
      onPopInvoked: (value) {
        filterRead.clearAllFilter();
      },
      child: Scaffold(
        backgroundColor: ColorConstants.grayLightColor,
        appBar: AppBarWidget(
          appBarColor: ColorConstants.grayLightColor,
          preferSize: 40,
          leading: InkWell(
            child: Image.asset(ImageConstants.backIcon),
            onTap: () {
              filterRead.clearAllFilter();
              context.toPop();
            },
          ),
        ),
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
                    TitleSmallText(
                      title: LocaleKeys.multiConnectScreenDesc.tr(),
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleTextAlign: TextAlign.center,
                      maxLine: 10,
                    ),
                    20.0.spaceY,
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
                    ),
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
                            int topicIndex = multiProviderWatch.allTopic.indexWhere((element) => element.id == data?.id);
                            return OnScaleTap(
                              onPress: () {},
                              child: ShadowContainer(
                                shadowColor: (topicIndex != -1 && (multiProviderWatch.allTopic[topicIndex].isCategorySelected ?? false))
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
                      onPressed: () {
                        context.toPushNamed(RoutesConstants.multiConnectFilterScreen, args: false);
                      },
                      prefixIcon: ImageConstants.filter,
                      prefixIconPadding: 10,
                    ),
                    30.0.spaceY,
                    BodySmallText(
                      title: LocaleKeys.instantlyConnectWithLiveExpert.tr(),
                      titleTextAlign: TextAlign.center,
                      maxLine: 2,
                      letterSpacing: 1.1,
                    ),
                    if (multiProviderWatch.singleCategoryData?.expertData?.isNotEmpty ?? false) ...[
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                          itemBuilder: (context, i) {
                            if (i == (multiProviderWatch.singleCategoryData?.expertData?.length ?? 0) && (multiProviderWatch.singleCategoryData?.expertData?.isNotEmpty ?? false)) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                              );
                            }
                            return ExpertDetailWidget(
                              expertData: multiProviderWatch.singleCategoryData?.expertData?[i],
                            );
                          },
                          separatorBuilder: (context, index) => 20.0.spaceY,
                          itemCount: (multiProviderWatch.singleCategoryData?.expertData?.length ?? 0) + (multiProviderWatch.reachedAllExpertLastPage ? 0 : 1))
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
