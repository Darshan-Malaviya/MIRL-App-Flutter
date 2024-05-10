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
import 'package:mirl/ui/common/container_widgets/category_common_view.dart';
import 'package:mirl/ui/screens/expert_category_screen/widget/expert_details_widget.dart';
import 'package:mirl/ui/screens/multi_call_screen/arguments/multi_call_connect_request_arguments.dart';
import 'package:mirl/ui/screens/selected_topic_screen/arguments/selected_topic_arguments.dart';

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
      child: RefreshIndicator(
        color: ColorConstants.primaryColor,
        onRefresh: () async {
          multiProviderRead.getLoggedUserData();
          filterRead.clearFinalSelectedModel();
          await ref.read(multiConnectProvider).getSingleCategoryApiCall(
              categoryId: widget.args.categoryId ?? '', context: context, requestModel: ExpertDataRequestModel(userId: SharedPrefHelper.getUserId, multiConnectRequest: 'true'));
          ref
              .read(filterProvider)
              .setCategoryWhenFromMultiConnect(ref.watch(multiConnectProvider).singleCategoryData?.categoryData);
        },
        child: Scaffold(
          backgroundColor: ColorConstants.greyLightColor,
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorConstants.primaryColor,
            onPressed: () async {
              await multiProviderRead.setExpertList();
              FlutterToast().showToast(
                  msg:
                      'Nice, you have chosen ${multiProviderWatch.selectedExperts.length} expert(s) for a Multiple Connect Request!'
                  // msg: 'You have chosen ${multiProviderWatch.selectedExperts.length} experts for multi connect.'
                  );
              multiConnectCallEnumNotifier.value = CallRequestTypeEnum.multiCallRequest;
              multiConnectRequestStatusNotifier.value = CallRequestStatusEnum.waiting;

              CommonBottomSheet.bottomSheet(
                  context: context,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: MultiCallDurationBottomSheetView(onPressed: () {
                    context.toPop();
                    allCallDurationNotifier.value = multiProviderWatch.multiCallDuration * 60;

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
                              CustomLoading.progressDialog(isLoading: true);
                              ref.read(socketProvider).multiConnectRequestEmit(
                                  expertIdsList: data, requestedDuration: multiProviderWatch.multiCallDuration * 60);
                            }
                          },
                          onSecondBtnTap: () async {
                            /// cancel
                            if (multiConnectCallEnumNotifier.value.secondButtonName == LocaleKeys.goBack.tr().toUpperCase()) {
                              context.toPop();
                              ref.read(multiConnectProvider).getLoggedUserData();
                              await ref.read(multiConnectProvider).getSingleCategoryApiCall(
                                  categoryId: widget.args.categoryId ?? '',
                                  context: context,
                                  requestModel:
                                      ExpertDataRequestModel(userId: SharedPrefHelper.getUserId, multiConnectRequest: 'true'));
                              ref.read(filterProvider).setCategoryWhenFromMultiConnect(
                                  ref.watch(multiConnectProvider).singleCategoryData?.categoryData);
                            } else if (multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiRequestApproved) {
                              if (multiProviderWatch.selectedExpertForCall != null &&
                                  multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiRequestApproved) {
                                multiProviderRead.getPayValue(fee: multiProviderWatch.selectedExpertForCall?.fee ?? 0);
                                CommonBottomSheet.bottomSheet(
                                    context: context,
                                    child: MultiCallPaymentBottomSheetView(onPressed: () {
                                      context.toPop();
                                      ref.read(socketProvider).connectCallEmit(
                                          expertId: multiProviderWatch.selectedExpertForCall?.id.toString() ?? '');
                                    }),
                                    isDismissible: true);
                              } else {
                                /// Choose any expert for call
                                FlutterToast().showToast(msg: LocaleKeys.pleasePickOneExpertStartYourCall.tr());
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
                              ref.read(multiConnectProvider).getLoggedUserData();
                              await ref.read(multiConnectProvider).getSingleCategoryApiCall(
                                  categoryId: widget.args.categoryId ?? '',
                                  context: context,
                                  requestModel:
                                      ExpertDataRequestModel(userId: SharedPrefHelper.getUserId, multiConnectRequest: 'true'));
                              ref.read(filterProvider).setCategoryWhenFromMultiConnect(
                                  ref.watch(multiConnectProvider).singleCategoryData?.categoryData);
                            }
                          },
                        ));
                  }),
                  isDismissible: true);
            },
            child: Icon(
              Icons.check,
              size: 30,
              color: ColorConstants.buttonTextColor,
            ),
          ).addVisibility(multiProviderWatch.selectedExperts.isNotEmpty),
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
                      if (multiProviderWatch.singleCategoryData?.categoryData != null) ...[
                        LabelSmallText(
                          title: multiProviderWatch.singleCategoryData?.categoryData?.description ?? '',
                          fontFamily: FontWeightEnum.w400.toInter,
                          maxLine: 10,
                          titleTextAlign: TextAlign.center,
                        ),
                        10.0.spaceY,
                        CategoryCommonView(
                          categoryName: multiProviderWatch.singleCategoryData?.categoryData?.name ?? '',
                          imageUrl: multiProviderWatch.singleCategoryData?.categoryData?.image ?? '',
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(0, 0),
                          isSelectedShadow: true,
                        ),
                      ],
                      20.0.spaceY,
                      if (multiProviderWatch.singleCategoryData?.categoryData?.topic?.isNotEmpty ?? false) ...[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
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
                          child: Column(
                            children: [
                              BodyMediumText(
                                title: LocaleKeys.selectTopicFromFilter.tr(),
                                fontFamily: FontWeightEnum.w500.toInter,
                              ),
                              20.0.spaceY,
                              Wrap(
                                children:
                                    List.generate(multiProviderWatch.singleCategoryData?.categoryData?.topic?.length ?? 0, (index) {
                                  final data = multiProviderWatch.singleCategoryData?.categoryData?.topic?[index];
                                  int topicIndex = filterWatch.allTopic.indexWhere((element) => element.id == data?.id);
                                  return InkWell(
                                onTap: () {
                                  context.toPushNamed(
                                    RoutesConstants.selectedTopicScreen,
                                    args: SelectedTopicArgs(
                                        topicName: multiProviderWatch.singleCategoryData?.categoryData?.topic?[index].name ?? '',
                                        topicId: multiProviderWatch.singleCategoryData?.categoryData?.topic?[index].id ?? 0),
                                  );
                                },
                                child:ShadowContainer(
                                    shadowColor: ((filterWatch.allTopic.isEmpty) && index == 0)
                                        ? ColorConstants.primaryColor
                                         :(topicIndex != -1 && (filterWatch.allTopic[topicIndex].isCategorySelected ?? false))
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
                                );}),
                              ),
                            ],
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
                      if (filterWatch.finalCommonSelectionModel.isNotEmpty) ...[
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
                              children: List.generate(filterWatch.finalCommonSelectionModel.length, (index) {
                                final data = filterWatch.finalCommonSelectionModel[index];
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //  if (data.title != null) ...[
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
                                    //  ],
                                    Flexible(
                                      child: ShadowContainer(
                                        border: 10,
                                        // child :RichText(
                                        //   softWrap: true,
                                        //   text: TextSpan(
                                        //     text:'${data.title} : ',
                                        //     style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        //         color: ColorConstants.buttonTextColor,
                                        //         fontFamily: FontWeightEnum.w400.toInter,
                                        //         fontSize: 12),
                                        //     children: [
                                        //       WidgetSpan(child: 2.0.spaceX),
                                        //       TextSpan(
                                        //           text: '${data.value }',
                                        //           style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        //               color: ColorConstants.buttonTextColor,
                                        //               fontFamily: FontWeightEnum.w700.toInter,
                                        //               fontSize: 12))
                                        //     ],
                                        //   ),
                                        //   textAlign: TextAlign.center,
                                        // ),
                                        child: BodyMediumText(
                                          maxLine: 10,
                                          title: '${data.displayText}: ${data.value}',
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
                          itemCount: (multiProviderWatch.expertData?.length ?? 0) +
                              (multiProviderWatch.reachedAllExpertLastPage ? 0 : 1),
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
                            30.0.spaceY,
                          ],
                        ).addMarginX(40),
                      ]
                    ],
                  ),
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
          title: LocaleKeys.pleaseSelectCallDuration.tr(),
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
        BodySmallText(
            title: '${LocaleKeys.maxCallDuration.tr()} 30 ${LocaleKeys.minutes.tr()}', fontFamily: FontWeightEnum.w500.toInter),
        20.0.spaceY,
        PrimaryButton(
          height: 55,
          title: LocaleKeys.checkAvailability.tr(),
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
          titleTextAlign: TextAlign.center,
          maxLine: 3,
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
                  multiConnectProviderWatch.selectedExpertForCall?.overAllRating != 0 &&
                          multiConnectProviderWatch.selectedExpertForCall?.overAllRating != null
                      ? multiConnectProviderWatch.selectedExpertForCall?.overAllRating.toString() ?? '0'
                      : LocaleKeys.newText.tr(),
                  maxLines: 1,
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ColorConstants.overallRatingColor,
                    shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))],
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
                  multiConnectProviderWatch.selectedExpertForCall?.fee != null
                      ? '\$${((multiConnectProviderWatch.selectedExpertForCall?.fee ?? 0) / 100).toStringAsFixed(2).toString()}'
                      : LocaleKeys.proBono.tr(),
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ColorConstants.overallRatingColor,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 3,
                        color: ColorConstants.blackColor.withOpacity(0.25),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        20.0.spaceY,
        BodyMediumText(
          title: LocaleKeys.selectedCallDuration.tr(),
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
          title: '${LocaleKeys.pay.tr()} \$${multiConnectProviderWatch.totalPayAmountMultiConnect?.toStringAsFixed(2)}',
          margin: EdgeInsets.symmetric(horizontal: 10),
          fontSize: 18,
          onPressed: widget.onPressed,
        ),
        22.0.spaceY,
        BodyMediumText(
          title:
              '${LocaleKeys.scheduleDescription.tr()} ${multiConnectProviderWatch.selectedExpertForCall?.expertName?.toUpperCase() ?? LocaleKeys.anonymous.tr().toUpperCase()}',
          fontFamily: FontWeightEnum.w500.toInter,
          titleColor: ColorConstants.buttonTextColor,
          titleTextAlign: TextAlign.center,
          maxLine: 4,
        )
      ],
    ).addAllPadding(28);
  }
}
