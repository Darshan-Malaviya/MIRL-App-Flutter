import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/call_history_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/call_history_response_model.dart';
import 'package:mirl/ui/common/grouped_list_widget/grouped_list.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';

class ExpertCallHistoryWidget extends ConsumerStatefulWidget {
  final int role;

  const ExpertCallHistoryWidget({super.key, required this.role});

  @override
  ConsumerState<ExpertCallHistoryWidget> createState() => _ExpertCallHistoryWidgetState();
}

class _ExpertCallHistoryWidgetState extends ConsumerState<ExpertCallHistoryWidget> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(callHistoryProvider).clearPaginationData();
      ref.read(callHistoryProvider).callHistoryApiCall(role: widget.role, showLoader: true);
    });

    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(callHistoryProvider).reachedLastPage;
        if (!isLoading) {
          ref
              .read(callHistoryProvider)
              .callHistoryApiCall(role: widget.role, showLoader: false, isFromPagination: true);
        } else {
          log('reach last page on get appointment list api');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final callHistoryWatch = ref.watch(callHistoryProvider);


    return callHistoryWatch.isLoading ?? false
        ? Center(
            child: CupertinoActivityIndicator(radius: 16, color: ColorConstants.primaryColor),
          )
        : callHistoryWatch.callHistoryData.isNotEmpty
            ? Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                    child: GroupedListView<CallHistoryData, dynamic>(
                      padding: const EdgeInsets.all(10),
                      reverse: false,
                      controller: scrollController,
                      elements: callHistoryWatch.callHistoryData,
                      groupBy: (element) {
                        print("check==========================${DateTime(DateTime.parse(element.date ?? '').year,
                            DateTime.parse(element.date ?? '').month, DateTime.parse(element.date ?? '').day)
                            .toString()
                            .toDisplayMonthWithYear()}");
                        return DateTime(DateTime.parse(element.date ?? '').year,
                                DateTime.parse(element.date ?? '').month, DateTime.parse(element.date ?? '').day)
                            .toString()
                            .toDisplayMonthWithYear();
                      },
                      groupComparator: (value1, value2) => value2.compareTo(value1),
                      shrinkWrap: true,
                      sort: false,
                      groupSeparatorBuilder: (value) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TitleSmallText(
                              title: value.toString().toUpperCase(),
                              titleColor: ColorConstants.buttonTextColor,
                              titleTextAlign: TextAlign.center,
                            ),
                            10.0.spaceY,
                            Image.asset(ImageConstants.purpleLine),
                          ],
                        ).addMarginX(20);
                      },
                      itemBuilder: (context, element) {
                        double durationInMinute = 0;
                        if(element.duration != null){
                           durationInMinute = (element.duration ?? 0) / 60;
                        }

                       return Container(
                            width: double.infinity,
                            decoration: ShapeDecoration(
                              color: widget.role == 1
                                  ? (element.status?.toString() ?? '').callHistoryStatusUserFromString ==
                                  CallHistoryUserStatusEnum.incomplete
                                  ? ColorConstants.certificatedBgColor
                                  : ColorConstants.whiteColor
                                  : (element.status?.toString() ?? '').callHistoryStatusExpertFromString ==
                                  CallHistoryStatusExpertEnum.incomplete
                                  ? ColorConstants.certificatedBgColor
                                  : ColorConstants.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0xffDDDDDD),
                                  blurRadius: 6.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                   Row(
                                     mainAxisSize: MainAxisSize.max,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       Expanded(child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         mainAxisSize: MainAxisSize.max,
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: [
                                           Row(
                                             children: [
                                               Container(
                                                 height: 25,
                                                 width: 25,
                                                 decoration: BoxDecoration(
                                                   color: ColorConstants.yellowButtonColor,
                                                   shape: BoxShape.circle,
                                                   boxShadow: [
                                                     BoxShadow(
                                                       color: ColorConstants.dropDownBorderColor,
                                                       blurRadius: 2,
                                                       offset: Offset(0, 2),
                                                       spreadRadius: 0,
                                                     )
                                                   ],
                                                 ),
                                                 child: Center(
                                                   child: BodySmallText(
                                                     title: element.date?.toDisplayDay() ?? '',
                                                     titleColor: ColorConstants.buttonTextColor,
                                                     titleTextAlign: TextAlign.center,
                                                     fontFamily: FontWeightEnum.w400.toInter,
                                                   ),
                                                 ),
                                               ),
                                               14.0.spaceX,
                                               Flexible(
                                                 child: Container(
                                                     alignment: Alignment.center,
                                                     decoration: ShapeDecoration(
                                                       color: element.requestType
                                                           .toString()
                                                           .getCallHistoryColorFromString,
                                                       shadows: [
                                                         BoxShadow(
                                                             color: Colors.black,
                                                             blurRadius: 1,
                                                             spreadRadius: 0),
                                                         BoxShadow(
                                                           color: Colors.white,
                                                           blurRadius: 10,
                                                           spreadRadius: 8,
                                                           offset: Offset(1, 2),
                                                         ),
                                                       ],
                                                       shape: RoundedRectangleBorder(
                                                         side: BorderSide(
                                                           width: 1,
                                                           strokeAlign: BorderSide.strokeAlignCenter,
                                                           color: Color(0xFFCAC9C9),
                                                         ),
                                                         borderRadius: BorderRadius.circular(10),
                                                       ),
                                                     ),
                                                     child: Padding(
                                                       padding: const EdgeInsets.symmetric(
                                                         vertical: 5,
                                                       ),
                                                       child: Center(
                                                         child: BodySmallText(
                                                           title: element.requestType
                                                               .toString()
                                                               .getCallHistoryFromString,
                                                           titleColor: ColorConstants.buttonTextColor,
                                                           titleTextAlign: TextAlign.center,
                                                           fontFamily: FontWeightEnum.w600.toInter,
                                                         ),
                                                       ),
                                                     )),
                                               )
                                             ],
                                           ),
                                           20.0.spaceY,
                                           RichText(
                                             softWrap: true,
                                             text: TextSpan(
                                               text: widget.role == 2
                                                   ? LocaleKeys.userWith.tr()
                                                   : LocaleKeys.expertWith.tr(),
                                               style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                   color: ColorConstants.buttonTextColor,
                                                   fontFamily: FontWeightEnum.w400.toInter,
                                                   fontSize: 12),
                                               children: [
                                                 WidgetSpan(child: 2.0.spaceX),
                                                 TextSpan(
                                                     text: (element.userDetails?.name?.isNotEmpty ?? false)
                                                         ? element.userDetails?.name?.toUpperCase()
                                                         : LocaleKeys.anonymous.tr().toUpperCase(),
                                                     // text: callHistoryWatch.callHistoryData[index].userDetails?.name?.toUpperCase() ?? '',
                                                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                         color: ColorConstants.buttonTextColor,
                                                         fontFamily: FontWeightEnum.w700.toInter,
                                                         fontSize: 12))
                                               ],
                                             ),
                                             textAlign: TextAlign.center,
                                           ),
                                           10.0.spaceY,
                                           if (widget.role == 1) ...[
                                             RichText(
                                               text: TextSpan(
                                                 text: LocaleKeys.feePerMinute.tr(),
                                                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                     color: ColorConstants.buttonTextColor,
                                                     fontFamily: FontWeightEnum.w400.toInter,
                                                     fontSize: 12),
                                                 children: [
                                                   WidgetSpan(child: 2.0.spaceX),
                                                   TextSpan(
                                                       text: 'INR ${element.userDetails?.fee ?? ''}',
                                                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                           color: ColorConstants.buttonTextColor,
                                                           fontFamily: FontWeightEnum.w700.toInter,
                                                           fontSize: 12))
                                                 ],
                                               ),
                                               textAlign: TextAlign.center,
                                             ),
                                             10.0.spaceY,
                                           ],
                                           RichText(
                                             text: TextSpan(
                                               text: LocaleKeys.durationCallHistory.tr(),
                                               style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                   color: ColorConstants.buttonTextColor,
                                                   fontFamily: FontWeightEnum.w400.toInter,
                                                   fontSize: 12),
                                               children: [
                                                 WidgetSpan(child: 2.0.spaceX),
                                                 TextSpan(
                                                     text: durationInMinute > 1 ? '${durationInMinute.toInt()} mins' : '${durationInMinute.toInt()} min',
                                                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                         color: ColorConstants.buttonTextColor,
                                                         fontFamily: FontWeightEnum.w700.toInter,
                                                         fontSize: 12))
                                               ],
                                             ),
                                             textAlign: TextAlign.center,
                                           ),
                                           10.0.spaceY,
                                           RichText(
                                             text: TextSpan(
                                               text: LocaleKeys.totalPayment.tr(),
                                               style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                   color: ColorConstants.buttonTextColor,
                                                   fontFamily: FontWeightEnum.w400.toInter,
                                                   fontSize: 12),
                                               children: [
                                                 WidgetSpan(child: 2.0.spaceX),
                                                 TextSpan(
                                                     text: 'INR ${element.totalPayment ?? ''}',
                                                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                         color: ColorConstants.buttonTextColor,
                                                         fontFamily: FontWeightEnum.w700.toInter,
                                                         fontSize: 12))
                                               ],
                                             ),
                                             textAlign: TextAlign.center,
                                           ),
                                         ],
                                       ),),
                                       10.0.spaceX,
                                       Container(
                                         decoration: BoxDecoration(boxShadow: [
                                           BoxShadow(
                                               offset: Offset(2, 4),
                                               color: ColorConstants.blackColor.withOpacity(0.3),
                                               spreadRadius: 0,
                                               blurRadius: 2),
                                         ], shape: BoxShape.circle),
                                         child: ClipRRect(
                                           borderRadius: BorderRadius.circular(50),
                                           child: NetworkImageWidget(
                                             imageURL: element.userDetails?.profile ?? '',
                                             boxFit: BoxFit.cover,
                                             height: 75,
                                             width: 75,
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                    10.0.spaceY,
                                    Column(
                                      children: List.generate(element.callStatusHistory?.length ?? 0,
                                              (index) {
                                        return Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            BodySmallText(title: element.callStatusHistory?[index].firstCreated
                                                ?.to12HourTimeFormat()
                                                .toUpperCase() ??
                                                '',
                                              fontFamily: FontWeightEnum.w400.toInter,
                                              titleColor: ColorConstants.buttonTextColor),
                                            10.0.spaceX,
                                            Flexible(
                                                  child: element.requestType == '3'
                                                      ? RichText(
                                                          text: TextSpan(
                                                            text: element.callStatusHistory?[index].status ?? '',
                                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                                color: ColorConstants.buttonTextColor,
                                                                fontFamily: FontWeightEnum.w400.toInter,
                                                                fontSize: 12),
                                                            children: [
                                                              WidgetSpan(child: 4.0.spaceX),
                                                              TextSpan(
                                                                  text: element.callStatusHistory?[index].firstCreated
                                                                          ?.toDisplayDateWithMonth()
                                                                          ?.toUpperCase() ??
                                                                      '',
                                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                                      color: ColorConstants.buttonTextColor,
                                                                      fontFamily: FontWeightEnum.w400.toInter,
                                                                      fontSize: 12)),
                                                            ],
                                                          ),
                                                          textAlign: TextAlign.start,
                                                        )
                                                      : BodySmallText(
                                                          title: element.callStatusHistory?[index].status ?? '',
                                                          fontFamily: FontWeightEnum.w400.toInter,
                                                          maxLine: 6,
                                                          titleColor: ColorConstants.buttonTextColor,
                                                        ),
                                                )
                                              ],
                                        ).addPaddingBottom(10);
                                          }),
                                    ),

                                    Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: LocaleKeys.status.tr(),
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: ColorConstants.buttonTextColor,
                                                fontFamily: FontWeightEnum.w400.toInter,
                                                fontSize: 12),
                                            children: [
                                              WidgetSpan(child: 6.0.spaceX),
                                              TextSpan(
                                                  text: widget.role == 1
                                                      ? (element.status?.toString() ?? '')
                                                      .callHistoryStatusUserFromString
                                                      .callHistoryUserStatusText
                                                      : (element.status?.toString() ?? '')
                                                      .callHistoryStatusExpertFromString
                                                      .callHistoryExpertStatusText,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                      color: widget.role == 1
                                                          ? (element.status?.toString() ?? '')
                                                          .callHistoryStatusUserFromString
                                                          .callHistoryUserStatusColor
                                                          : (element.status?.toString() ?? '')
                                                          .callHistoryStatusExpertFromString
                                                          .callHistoryExpertStatusColor,
                                                      fontFamily: FontWeightEnum.w700.toInter,
                                                      fontSize: 12))
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                if (widget.role == 2) ...[
                                  4.0.spaceY,
                                  InkWell(
                                    onTap: () {
                                       context.toPushNamed(RoutesConstants.blockUserScreen,
                                           args: BlockUserArgs(
                                                  userName: (element.userDetails?.name?.isNotEmpty ?? false)
                                                      ? element.userDetails?.name
                                                      : LocaleKeys.anonymous.tr(),
                                                  imageURL: element.userDetails?.profile ?? '',
                                               userId: int.parse(element.userDetails?.id.toString() ?? ''),
                                               userRole: 2,
                                               reportName: '',
                                               isFromInstantCall: false));
                                    },
                                    child: Align(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      child: BodySmallText(
                                        title: LocaleKeys.blockAndReportUser.tr(),
                                        fontFamily: FontWeightEnum.w400.toInter,
                                        titleTextAlign: TextAlign.end,
                                        titleColor: ColorConstants.darkRedColor,
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                            ).addMarginXY(marginX: 20, marginY: 20)).addMarginY(20);

                        //return buildUi(element, context, callHistoryWatch);
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Visibility(
                      //visible: true,
                      visible: callHistoryWatch.isPaginationLoading ?? false,
                      child: Center(child: CircularProgressIndicator(color: ColorConstants.primaryColor)),
                    ).addPaddingXY(paddingX: 20, paddingY: 20),
                  )
                ],
              )
            : Center(
                child: BodyLargeText(
                  title: StringConstants.noDataFound,
                  fontFamily: FontWeightEnum.w600.toInter,
                ),
              );
  }
}
