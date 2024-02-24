import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';

class ReportUserWidget extends ConsumerStatefulWidget {
  final BlockUserArgs args;

  const ReportUserWidget({super.key, required this.args});

  @override
  ConsumerState<ReportUserWidget> createState() => _ReportUserWidgetState();
}

class _ReportUserWidgetState extends ConsumerState<ReportUserWidget> {
  // ScrollController scrollController = ScrollController();
  //
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     ref.read(reportUserProvider).getAllReportListApiCall(role: widget.args.userRole ?? 0, isFullScreenLoader: true);
  //   });
  //   scrollController.addListener(() async {
  //     if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
  //       bool isLoading = ref.watch(reportUserProvider).reachedCategoryLastPage;
  //       if (!isLoading) {
  //         ref.read(reportUserProvider).getAllReportListApiCall(role: widget.args.userRole ?? 0);
  //       } else {
  //         log('reach last page on get report list api');
  //       }
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final reportUserRead = ref.read(reportUserProvider);
    final reportUserWatch = ref.watch(reportUserProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          30.0.spaceY,
          TitleLargeText(
            // title: LocaleKeys.reportThisUser.tr(),
            title: widget.args.reportName ?? '',
            titleColor: ColorConstants.bottomTextColor,
            titleTextAlign: TextAlign.center,
          ),
          10.0.spaceY,
          BodySmallText(
            title: LocaleKeys.appropriate.tr(),
            titleColor: ColorConstants.blackColor,
            titleTextAlign: TextAlign.center,
            fontFamily: FontWeightEnum.w400.toInter,
            maxLine: 3,
          ),
          reportUserWatch.isLoading
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                )
              : reportUserWatch.reportListDetails.isNotEmpty
                  ? ListView.builder(
                      //controller: widget.args.controller,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (reportUserWatch.reportListDetails.length) + (reportUserWatch.reachedCategoryLastPage ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index == reportUserWatch.reportListDetails.length && reportUserWatch.reportListDetails.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                          );
                        }
                        return InkWell(
                          onTap: () async {
                            reportUserRead.userReportRequestCall(
                                reportListId: reportUserWatch.reportListDetails[index].id ?? 0,
                                reportToId: int.parse(widget.args.expertId ?? ''));
                            await reportUserRead.reportUser();
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: BodySmallText(
                                        title: reportUserWatch.reportListDetails[index].title ?? '',
                                        titleColor: ColorConstants.blackColor,
                                        titleTextAlign: TextAlign.start,
                                        maxLine: 3,
                                        fontSize: 13,
                                      ),
                                    ),
                                    20.0.spaceY,
                                    BodySmallText(
                                      title: reportUserWatch.reportListDetails[index].description ?? '',
                                      titleColor: ColorConstants.blackColor,
                                      titleTextAlign: TextAlign.start,
                                      fontFamily: FontWeightEnum.w400.toInter,
                                      fontSize: 13,
                                      maxLine: 10,
                                    ),
                                  ],
                                ).addMarginTop(30),
                              ),
                              10.0.spaceX,
                              Align(alignment: Alignment.centerRight, child: Image.asset(ImageConstants.arrow))
                            ],
                          ),
                        );
                      })
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: BodyLargeText(
                          title: StringConstants.noDataFound,
                          fontFamily: FontWeightEnum.w600.toInter,
                        ),
                      ),
                    ),
          20.0.spaceY
        ],
      ).addAllPadding(30),
    );
  }
}
