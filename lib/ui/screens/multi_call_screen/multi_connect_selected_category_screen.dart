import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';
import 'package:mirl/infrastructure/models/request/expert_data_request_model.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
import 'package:mirl/ui/common/button_widget/fees_action_button.dart';
import 'package:mirl/ui/screens/expert_category_screen/widget/expert_details_widget.dart';
import 'package:mirl/ui/screens/multi_call_screen/arguments/multi_call_connect_request_arguments.dart';

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
      ref.read(multiConnectProvider).getLoggedUserData();
      await ref.read(multiConnectProvider).getSingleCategoryApiCall(
          categoryId: widget.args.categoryId ?? '',
          context: context,
          requestModel: ExpertDataRequestModel(userId: SharedPrefHelper.getUserId, multiConnectRequest: 'true'));
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
          log('reach last page on multi connect list api');
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
              onTap: () async {
                await multiProviderRead.setExpertList();
                FlutterToast()
                    .showToast(msg: 'You have chosen ${multiProviderWatch.selectedExperts.length} experts for multi connect.');
                multiConnectCallEnumNotifier.value = CallRequestTypeEnum.multiCallRequest;
                multiConnectRequestStatusNotifier.value = CallRequestStatusEnum.waiting;

                CommonBottomSheet.bottomSheet(
                    context: context,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: MultiCallDurationBottomSheetView( onPressed: () {
                      context.toPop();
                      allCallDurationNotifier.value = multiProviderWatch.multiCallDuration;
                      /// user side
                      NavigationService.context.toPushNamed(RoutesConstants.multiConnectCallDialogScreen,
                          args: MultiConnectDialogArguments(
                            //expertList: multiProviderRead.selectedExpertDetails,
                            userDetail: multiProviderRead.loggedUserData,
                            onFirstBtnTap: () {
                              if (instanceCallEnumNotifier.value == CallRequestTypeEnum.multiRequestTimeout) {
                                /// tru again
                              } else {
                                List<int> data = multiProviderWatch.selectedExpertDetails.map((e) => e.id ?? 0).toList();
                                ref.read(socketProvider).multiConnectRequestEmit(expertIdsList: data);
                              }
                            },
                            onSecondBtnTap: () {
                              /// cancel
                              if (multiConnectCallEnumNotifier.value.secondButtonName == LocaleKeys.goBack.tr().toUpperCase()) {
                                context.toPop();
                              } else if (multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiRequestApproved) {
                                if (multiProviderWatch.selectedExpertForCall != null &&
                                    multiConnectCallEnumNotifier.value  == CallRequestTypeEnum.multiRequestApproved) {
                                  CommonBottomSheet.bottomSheet(
                                      context: context,
                                      child: MultiCallPaymentBottomSheetView(onPressed: () {
                                        context.toPop();
                                        ref
                                            .read(socketProvider)
                                            .connectCallEmit(expertId: multiProviderWatch.selectedExpertForCall?.id.toString() ?? '');
                                      }),
                                      isDismissible: true);
                                } else {
                                  /// Choose any expert for call
                                  FlutterToast().showToast(msg: 'Please choose expert for call.');
                                }
                              } else {
                                /// change expert id here
                                ref.read(socketProvider).multiConnectStatusEmit(
                                    callStatusEnum: CallRequestStatusEnum.cancel,
                                    expertId: null,
                                    userId: SharedPrefHelper.getUserId,
                                    callRoleEnum: CallRoleEnum.user,
                                    callRequestId: SharedPrefHelper.getCallRequestId.toString());
                                context.toPop();
                              }
                            },
                          ));
                    }),
                    isDismissible: true);


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
                          children:
                              List.generate(multiProviderWatch.singleCategoryData?.categoryData?.topic?.length ?? 0, (index) {
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
                      buttonTextFontFamily: FontWeightEnum.w400.toInter,
                      prefixIconPadding: 10,
                      padding: EdgeInsets.symmetric(horizontal: 50),
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
                              if (widget.args.fromExploreExpert == true) ...[
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
                              ] else ...[
                                if (filterRead.commonSelectionModel.first.title == FilterType.Category.name &&
                                    filterRead.commonSelectionModel.length > 1) ...[
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
                                ]
                              ],
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
                                            index: index,
                                            context: context,
                                            isFromMultiConnect: true,
                                            singleCategoryId: widget.args.categoryId,
                                            multiConnectRequest: 'true');
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
                      ).addPaddingXY(paddingX: 20, paddingY: 10)
                    ],
                    if (multiProviderWatch.expertData?.isNotEmpty ?? false) ...[
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => 30.0.spaceY,
                        itemCount:
                            (multiProviderWatch.expertData?.length ?? 0) + (multiProviderWatch.reachedAllExpertLastPage ? 0 : 1),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        itemBuilder: (context, i) {
                          if (i == (multiProviderWatch.expertData?.length ?? 0) &&
                              (multiProviderWatch.expertData?.isNotEmpty ?? false)) {
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
                                title: multiProviderWatch.expertData?[i].selectedForMultiConnect ?? false
                                    ? LocaleKeys.selected.tr()
                                    : LocaleKeys.clickToSelect.tr(),
                                buttonColor: multiProviderWatch.expertData?[i].selectedForMultiConnect ?? false
                                    ? ColorConstants.primaryColor
                                    : ColorConstants.buttonColor,
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
                      Column(
                        children: [
                          100.0.spaceY,
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
    );
  }
}

class MultiCallDurationBottomSheetView extends ConsumerStatefulWidget {
  final void Function() onPressed;
  const MultiCallDurationBottomSheetView({required this.onPressed, super.key});

  @override
  ConsumerState createState() => _MultiCallDurationBottomSheetViewState();
}

class _MultiCallDurationBottomSheetViewState extends ConsumerState<MultiCallDurationBottomSheetView> {

  @override
  Widget build(BuildContext context) {
    final multiConnectProviderWatch = ref.watch(multiConnectProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BodyMediumText(
          title: "Please select call duration",
          fontSize: 15,
          titleColor: ColorConstants.blueColor,
        ),
        22.0.spaceY,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FeesActionButtonWidget(
              onTap: () => multiConnectProviderWatch.decrementMultiCallDuration(),
              icons: ImageConstants.minus,
              isDisable: multiConnectProviderWatch.multiCallDuration == 10,
            ),
            20.0.spaceX,
            PrimaryButton(
              height: 45,
              width: 148,
              title: '${multiConnectProviderWatch.multiCallDuration} ${LocaleKeys.minutes.tr()}',
              onPressed: () {},
              buttonColor: ColorConstants.buttonColor,
            ),
            20.0.spaceX,
            FeesActionButtonWidget(
              onTap: () => multiConnectProviderWatch.incrementMultiCallDuration(),
              icons: ImageConstants.plus,
              isDisable: multiConnectProviderWatch.multiCallDuration == 30,
            ),
          ],
        ),
        20.0.spaceY,
        BodySmallText(title: '${LocaleKeys.maxCallDuration.tr()} 30 ${LocaleKeys.minutes.tr()}', fontFamily: FontWeightEnum.w500.toInter),
        20.0.spaceY,
        PrimaryButton(
          height: 55,
          title: 'Done',
          margin: EdgeInsets.symmetric(horizontal: 10),
          fontSize: 18,
          onPressed: widget.onPressed,
        ),
      ],
    ).addAllPadding(28);
  }
}


class MultiCallPaymentBottomSheetView extends ConsumerStatefulWidget {
  final void Function() onPressed;
  const MultiCallPaymentBottomSheetView({required this.onPressed, super.key});

  @override
  ConsumerState createState() => _MultiCallPaymentBottomSheetViewState();
}

class _MultiCallPaymentBottomSheetViewState extends ConsumerState<MultiCallPaymentBottomSheetView> {

  @override
  Widget build(BuildContext context) {
    final multiConnectProviderWatch = ref.watch(multiConnectProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        HeadlineMediumText(
          title: multiConnectProviderWatch.selectedExpertForCall?.expertName ?? LocaleKeys.anonymous.tr(),
          fontSize: 30,
          titleColor: ColorConstants.bottomTextColor,
        ),
        22.0.spaceY,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                BodySmallText(
                  title: LocaleKeys.overAllRating.tr(),
                  fontFamily: FontWeightEnum.w400.toInter,
                  titleTextAlign: TextAlign.center,
                ),
                10.0.spaceX,
                AutoSizeText(
                  multiConnectProviderWatch.selectedExpertForCall?.overAllRating != 0 ? multiConnectProviderWatch.selectedExpertForCall?.overAllRating.toString() ?? '0' : LocaleKeys.newText.tr(),
                  maxLines: 1,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorConstants.overallRatingColor,
                    shadows: [Shadow(offset: Offset(0, 3), blurRadius: 4, color: ColorConstants.blackColor.withOpacity(0.3))],
                  ),
                )
              ],
            ),
            Row(
              children: [
                BodySmallText(
                  title: LocaleKeys.feesPerMinute.tr(),
                  fontFamily: FontWeightEnum.w400.toInter,
                  titleTextAlign: TextAlign.center,
                ),
                10.0.spaceX,
                AutoSizeText(
                  '\$${((multiConnectProviderWatch.selectedExpertForCall?.fee ?? 0) / 100).toStringAsFixed(2).toString()}',
                  maxLines: 1,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorConstants.overallRatingColor,
                    shadows: [Shadow(offset: Offset(0, 3), blurRadius: 4, color: ColorConstants.blackColor.withOpacity(0.3))],
                  ),
                )
              ],
            ),
          ],
        ),
        20.0.spaceY,
        BodyMediumText(
          title: " Selected Call Duration",
          fontSize: 15,
          titleColor: ColorConstants.blueColor,
        ),
        20.0.spaceY,
        PrimaryButton(
          height: 45,
          width: 148,
          title: '${multiConnectProviderWatch.multiCallDuration} ${LocaleKeys.minutes.tr()}',
          onPressed: () {},
          buttonColor: ColorConstants.buttonColor,
        ),
        20.0.spaceY,
        PrimaryButton(
          height: 55,
          // title: '${LocaleKeys.pay.tr()} \$${scheduleWatch.totalPayAmount?.toStringAsFixed(2)}',
          title: '${LocaleKeys.pay.tr()} \$20',
          margin: EdgeInsets.symmetric(horizontal: 10),
          fontSize: 18,
          onPressed: widget.onPressed,
        ),
        22.0.spaceY,
        BodyMediumText(
          title: '${LocaleKeys.scheduleDescription.tr()} ${multiConnectProviderWatch.selectedExpertForCall?.expertName ?? LocaleKeys.anonymous.tr()}',
          fontFamily: FontWeightEnum.w500.toInter,
          titleColor: ColorConstants.buttonTextColor,
          titleTextAlign: TextAlign.center,
        )
      ],
    ).addAllPadding(28);
  }
}