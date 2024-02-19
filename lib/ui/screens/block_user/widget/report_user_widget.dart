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
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(reportUserProvider).getAllBlockListApiCall(role: widget.args.userRole ?? 0);
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(reportUserProvider).reachedCategoryLastPage;
        if (!isLoading) {
          ref.read(reportUserProvider).getAllBlockListApiCall(role: widget.args.userRole ?? 0);
        } else {
          log('reach last page on get report list api');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reportUserRead = ref.read(reportUserProvider);
    final reportUserWatch = ref.watch(reportUserProvider);

    return Column(
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
        20.0.spaceY,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(reportUserWatch.reportListDetails.length, (index) {
            return InkWell(
              onTap: () {
                reportUserRead.reportUser();
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
                          maxLine: 3,
                        ),
                      ],
                    ).addMarginTop(20),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 36,
                      color: ColorConstants.redColor,
                    ),
                  )
                ],
              ),
            );
          }),
        )
      ],
    ).addAllPadding(20);
  }
}
