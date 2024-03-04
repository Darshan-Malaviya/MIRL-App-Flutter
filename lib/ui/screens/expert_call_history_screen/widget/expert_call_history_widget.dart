import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/call_history_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

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
      ref.read(callHistoryProvider).callHistoryApiCall(role: widget.role);
    });

    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(upcomingAppointmentProvider).reachedLastPage;
        if (!isLoading) {
          ref.read(callHistoryProvider).callHistoryApiCall(role: widget.role);
        } else {
          log('reach last page on get appointment list api');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final callHistoryWatch = ref.watch(callHistoryProvider);
    final callHistoryRead = ref.read(callHistoryProvider);
    print(callHistoryWatch.callHistoryData.length);
    return callHistoryWatch.callHistoryData.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            controller: scrollController,
            itemCount: callHistoryWatch.callHistoryData.length + (callHistoryWatch.reachedLastPage ? 0 : 1),
            itemBuilder: (context, index) {
              // if (index == callHistoryWatch.callHistoryData.length && callHistoryWatch.callHistoryData.isNotEmpty == true) {
              //   return Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 12),
              //     child: Center(child: CupertinoActivityIndicator(color: ColorConstants.primaryColor)),
              //   );
              // }
              return Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: ColorConstants.categoryList,
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
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          title: '0',
                                          titleColor: ColorConstants.buttonTextColor,
                                          titleTextAlign: TextAlign.center,
                                          fontFamily: FontWeightEnum.w400.toInter,
                                        ),
                                      ),
                                    ),
                                    14.0.spaceX,
                                    Container(
                                        alignment: Alignment.center,
                                        decoration: ShapeDecoration(
                                          color: callHistoryEnumNotifier.value.callHistoryTypeNameColor,
                                          shadows: [
                                            BoxShadow(color: Colors.black, blurRadius: 1, spreadRadius: 0),
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
                                          padding: const EdgeInsets.only(right: 30, left: 30, top: 5, bottom: 5),
                                          child: Center(
                                            child: BodySmallText(
                                              title: callHistoryEnumNotifier.value.callHistoryTypeName,
                                              titleColor: ColorConstants.buttonTextColor,
                                              titleTextAlign: TextAlign.center,
                                              fontFamily: FontWeightEnum.w600.toInter,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                                20.0.spaceY,
                                RichText(
                                  softWrap: true,
                                  text: TextSpan(
                                    text: 'User: ',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: ColorConstants.buttonTextColor,
                                        fontFamily: FontWeightEnum.w400.toInter,
                                        fontSize: 12),
                                    children: [
                                      WidgetSpan(child: 2.0.spaceX),
                                      TextSpan(
                                          text: callHistoryWatch.callHistoryData[index].userDetails?.name?.toUpperCase() ?? '',
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
                                    text: LocaleKeys.feePerMinute.tr(),
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: ColorConstants.buttonTextColor,
                                        fontFamily: FontWeightEnum.w400.toInter,
                                        fontSize: 12),
                                    children: [
                                      WidgetSpan(child: 2.0.spaceX),
                                      TextSpan(
                                          text: 'INR ${callHistoryWatch.callHistoryData[index].userDetails?.fee ?? ''}',
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
                                    text: LocaleKeys.durationCallHistory.tr(),
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: ColorConstants.buttonTextColor,
                                        fontFamily: FontWeightEnum.w400.toInter,
                                        fontSize: 12),
                                    children: [
                                      WidgetSpan(child: 2.0.spaceX),
                                      TextSpan(
                                          text: '${callHistoryWatch.callHistoryData[index].duration ?? ''} mins',
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
                                          text: 'INR ${callHistoryWatch.callHistoryData[index].totalPayment ?? ''}',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: ColorConstants.buttonTextColor,
                                              fontFamily: FontWeightEnum.w700.toInter,
                                              fontSize: 12))
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                10.0.spaceY,
                                Column(
                                  children: List.generate(3, (index) {
                                    return Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: '04:05PM',
                                            style: TextStyle(
                                                fontFamily: FontWeightEnum.w400.toInter,
                                                color: ColorConstants.buttonTextColor,
                                                fontSize: 12),
                                            children: <InlineSpan>[
                                              WidgetSpan(
                                                  child: SizedBox(
                                                width: 14,
                                              )),
                                              TextSpan(
                                                text: "callTime",
                                                style: TextStyle(
                                                    fontFamily: FontWeightEnum.w400.toInter,
                                                    color: ColorConstants.buttonTextColor,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ).addMarginY(6);
                                  }),
                                ),
                                10.0.spaceY,
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
                                              text: "call completed".toUpperCase(),
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: ColorConstants.textGreenColor,
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
                          ),
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
                                imageURL: callHistoryWatch.callHistoryData[index].userDetails?.profile ?? '',
                                boxFit: BoxFit.cover,
                                height: 75,
                                width: 75,
                              ),
                            ),
                          ),
                        ],
                      ),
                      4.0.spaceY,
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: BodySmallText(
                          title: LocaleKeys.blockAndReportUser.tr(),
                          fontFamily: FontWeightEnum.w400.toInter,
                          titleTextAlign: TextAlign.end,
                          titleColor: ColorConstants.darkRedColor,
                        ),
                      ),
                    ],
                  ).addMarginXY(marginX: 20, marginY: 20));
            },
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: BodyLargeText(
                title: StringConstants.noDataFound,
                fontFamily: FontWeightEnum.w600.toInter,
              ),
            ),
          );
  }
}
