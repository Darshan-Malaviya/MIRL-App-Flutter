import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class FeedbackSubmittingScreen extends StatelessWidget {
  const FeedbackSubmittingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          100.0.spaceY,
          TitleLargeText(
            title: LocaleKeys.thanksForFeedback.tr(),
            titleColor: ColorConstants.bottomTextColor,
            titleTextAlign: TextAlign.center,
            maxLine: 2,
          ),
          50.0.spaceY,
          Image.asset(ImageConstants.smiley),
          60.0.spaceY,
          PrimaryButton(
            title: LocaleKeys.backToHome.tr(),
            titleColor: ColorConstants.buttonTextColor,
            onPressed: () => context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 0),
          ),
        ],
      ).addAllMargin(20),
    );
  }
}
