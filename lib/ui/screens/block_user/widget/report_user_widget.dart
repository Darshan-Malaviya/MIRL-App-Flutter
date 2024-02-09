import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ReportUserWidget extends ConsumerStatefulWidget {
  final String reportName;

  const ReportUserWidget({super.key, this.reportName = 'REPORT THIS USER'});

  @override
  ConsumerState<ReportUserWidget> createState() => _ReportUserWidgetState();
}

class _ReportUserWidgetState extends ConsumerState<ReportUserWidget> {
  @override
  Widget build(BuildContext context) {
    final reportUserRead = ref.read(reportUserProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        30.0.spaceY,
        TitleLargeText(
          // title: LocaleKeys.reportThisUser.tr(),
          title: widget.reportName,
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
          children: List.generate(2, (index) {
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
                            title: 'ABUSIVE OR DISRESPECTFUL BEHAVIOR',
                            titleColor: ColorConstants.blackColor,
                            titleTextAlign: TextAlign.start,
                            maxLine: 3,
                            fontSize: 13,
                          ),
                        ),
                        20.0.spaceY,
                        BodySmallText(
                          title: 'Engaging in any form of verbal abuse, harassment, or showing disrespect towards the expert.',
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
