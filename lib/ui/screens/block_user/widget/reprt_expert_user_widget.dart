import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ReportExpertUserWidget extends ConsumerStatefulWidget {
  const ReportExpertUserWidget({super.key});

  @override
  ConsumerState<ReportExpertUserWidget> createState() => _ReportExpertUserWidgetState();
}

class _ReportExpertUserWidgetState extends ConsumerState<ReportExpertUserWidget> {
  @override
  Widget build(BuildContext context) {
    final reportUserRead = ref.read(reportUserProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        30.0.spaceY,
        TitleLargeText(
          title: LocaleKeys.reportThisUser.tr(),
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
