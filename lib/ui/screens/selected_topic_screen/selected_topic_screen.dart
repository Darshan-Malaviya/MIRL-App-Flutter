import 'dart:developer';

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
import 'package:mirl/ui/screens/expert_category_screen/widget/expert_details_widget.dart';
import 'package:mirl/ui/screens/multi_call_screen/arguments/multi_call_connect_request_arguments.dart';
import 'package:mirl/ui/screens/multi_call_screen/multi_connect_selected_category_screen.dart';
import 'package:mirl/ui/screens/selected_topic_screen/arguments/selected_topic_arguments.dart';


class SelectedTopicScreen extends ConsumerStatefulWidget {
  final SelectedTopicArgs args;

  const SelectedTopicScreen({super.key, required this.args});

  @override
  ConsumerState<SelectedTopicScreen> createState() => _SelectedTopicScreenState();
}

class _SelectedTopicScreenState extends ConsumerState<SelectedTopicScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(selectedTopicProvider).clearData();
      ref.read(selectedTopicProvider).selectedTopicApiCall(
          isFullScreenLoader: true, topicId: widget.args.topicId, categoryId: widget.args.categoryId, fromMultiConnect: widget.args.fromMultiConnect);
    });

    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(selectedTopicProvider).reachedCategoryLastPage;
        if (!isLoading) {
          await ref
              .read(selectedTopicProvider)
              .selectedTopicApiCall(topicId: widget.args.topicId, categoryId: widget.args.categoryId, fromMultiConnect: widget.args.fromMultiConnect);
        } else {
          log('reach last page on selected topic list api');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTopicWatch = ref.watch(selectedTopicProvider);
    final multiProviderWatch = ref.watch(multiConnectProvider);
    final multiProviderRead = ref.read(multiConnectProvider);

    return PopScope(
      child: Scaffold(
        backgroundColor: ColorConstants.scaffoldBg,
        appBar: AppBarWidget(
          // appTitle: TitleLargeText(
          //   title: widget.args.topicName != null ? widget.args.topicName ?? '' : widget.args.categoryName ?? '',
          //   fontSize: 20,
          //   maxLine: 2,
          // ),
          appBarColor: ColorConstants.scaffoldBg,
          leading: InkWell(
            child: Image.asset(ImageConstants.backIcon),
            onTap: () {
              multiProviderRead.clearExpertIds();
              context.toPop();
            },
          ),
        ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorConstants.primaryColor,
            onPressed: () async {
              await multiProviderRead.setExpertList();
              FlutterToast()
                  .showToast(msg: 'Nice, you have chosen ${multiProviderWatch.selectedExperts.length} expert(s) for a Multiple Connect Request!'
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
                              ref
                                  .read(socketProvider)
                                  .multiConnectRequestEmit(expertIdsList: data, requestedDuration: multiProviderWatch.multiCallDuration * 60);
                            }
                          },
                          onSecondBtnTap: () async {
                            /// cancel
                            if (multiConnectCallEnumNotifier.value.secondButtonName == LocaleKeys.goBack.tr().toUpperCase()) {
                              context.toPop();
                              ref.read(multiConnectProvider).getLoggedUserData();
                              await ref.read(multiConnectProvider).getSingleCategoryApiCall(
                                  categoryId: widget.args.categoryId.toString() ?? '',
                                  context: context,
                                  requestModel: ExpertDataRequestModel(userId: SharedPrefHelper.getUserId, multiConnectRequest: 'true'));
                              ref
                                  .read(filterProvider)
                                  .setCategoryWhenFromMultiConnect(ref.watch(multiConnectProvider).singleCategoryData?.categoryData);
                            } else if (multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiRequestApproved) {
                              if (multiProviderWatch.selectedExpertForCall != null &&
                                  multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiRequestApproved) {
                                multiProviderRead.getPayValue(fee: multiProviderWatch.selectedExpertForCall?.fee ?? 0);
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
                                  categoryId: widget.args.categoryId.toString() ?? '',
                                  context: context,
                                  requestModel: ExpertDataRequestModel(userId: SharedPrefHelper.getUserId, multiConnectRequest: 'true'));
                              ref
                                  .read(filterProvider)
                                  .setCategoryWhenFromMultiConnect(ref.watch(multiConnectProvider).singleCategoryData?.categoryData);
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
          ).addVisibility((widget.args.fromMultiConnect ?? false) && multiProviderWatch.selectedExperts.isNotEmpty),
        body: selectedTopicWatch.isLoading
            ? Center(
                child: CupertinoActivityIndicator(radius: 16, color: ColorConstants.primaryColor),
              )
            : SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TitleLargeText(
                      title: widget.args.topicName != null ? widget.args.topicName?.toUpperCase() ?? '' : widget.args.categoryName?.toUpperCase() ?? '',
                      titleTextAlign: TextAlign.center,
                      maxLine: 5,
                    ).addMarginX(20),
                    12.0.spaceY,
                    LabelSmallText(
                      title: widget.args.descriptionName?.toUpperCase() ?? "",
                      titleTextAlign: TextAlign.center,
                      fontFamily: FontWeightEnum.w400.toInter,
                      fontSize: 12,
                      maxLine: 5,
                    ).addMarginX(10),
                    12.0.spaceY,
                    PrimaryButton(
                      title: LocaleKeys.filterExperts.tr(),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      onPressed: () {
                        // context.toPushNamed(RoutesConstants.expertCategoryFilterScreen,
                        //     args: FilterArgs(fromExploreExpert: true,));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             ExpertCategoryFilterScreen(args: FilterArgs(fromExploreExpert: true)),
                        //         allowSnapshotting: false));
                      },
                      prefixIcon: ImageConstants.filter,
                      titleColor: ColorConstants.blackColor,
                      buttonTextFontFamily: FontWeightEnum.w400.toInter,
                      prefixIconPadding: 10,
                      padding: EdgeInsets.symmetric(horizontal: 100),
                    ),
                    10.0.spaceY,
                    if (selectedTopicWatch.categoryList?.expertData?.isNotEmpty ?? false) ...[
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                          itemBuilder: (context, i) {
                            if (i == (selectedTopicWatch.categoryList?.expertData?.length ?? 0) &&
                                (selectedTopicWatch.categoryList?.expertData?.isNotEmpty ?? false)) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                              );
                            }
                            return widget.args.fromMultiConnect ?? false
                                ? Stack(alignment: Alignment.bottomCenter, children: [
                                    ExpertDetailWidget(
                                      expertData: selectedTopicWatch.categoryList?.expertData?[i],
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
                                  ])
                                : ExpertDetailWidget(
                                    expertData: selectedTopicWatch.categoryList?.expertData?[i],
                                  );
                          },
                          separatorBuilder: (context, index) => 30.0.spaceY,
                          itemCount:
                              (selectedTopicWatch.categoryList?.expertData?.length ?? 0) + (selectedTopicWatch.reachedCategoryLastPage ? 0 : 1))
                    ] else ...[
                      100.0.spaceY,
                      Center(
                        child: BodySmallText(
                          title: LocaleKeys.noResultFound.tr(),
                          fontFamily: FontWeightEnum.w600.toInter,
                          //titleTextAlign: TextAlign.center,
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
