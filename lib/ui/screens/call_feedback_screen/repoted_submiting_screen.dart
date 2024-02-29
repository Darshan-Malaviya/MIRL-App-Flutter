import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ReportedSubmittingScreen extends StatelessWidget {
  const ReportedSubmittingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          100.0.spaceY,
          TitleLargeText(
            title: LocaleKeys.reported.tr(),
            titleColor: ColorConstants.bottomTextColor,
            titleTextAlign: TextAlign.center,
          ),
          20.0.spaceY,
          TitleSmallText(
            title: LocaleKeys.letting.tr(),
            titleColor: ColorConstants.buttonTextColor,
            fontFamily: FontWeightEnum.w400.toInter,
            titleTextAlign: TextAlign.center,
            maxLine: 6,
          ),
          50.0.spaceY,
          Image.asset(ImageConstants.reported),
          60.0.spaceY,
          PrimaryButton(
            title: LocaleKeys.backToProfile.tr(),
            titleColor: ColorConstants.buttonTextColor,
            onPressed: () => context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 0),
          ),
        ],
      ).addAllMargin(20),
    );
  }
}
