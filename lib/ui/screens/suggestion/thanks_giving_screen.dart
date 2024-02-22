import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ThanksGivingScreen extends StatelessWidget {
  const ThanksGivingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleLargeText(
            title: LocaleKeys.whyNotThinkOfThat.tr(),
            maxLine: 2,
            titleTextAlign: TextAlign.center,
            titleColor: ColorConstants.bottomTextColor,
          ),
          10.0.spaceY,
          BodyMediumText(
            title: LocaleKeys.thanksNote.tr(),
            maxLine: 4,
            fontFamily: FontWeightEnum.w400.toInter,
            titleTextAlign: TextAlign.center,
          ),
          50.0.spaceY,
          Image.asset(
            ImageConstants.suggestNewExpertise,
          ),
          70.0.spaceY,
          PrimaryButton(
              title: LocaleKeys.backToExpertCategories.tr(),
              titleColor: ColorConstants.buttonTextColor,
              onPressed: () {
                context.toPop();
                context.toPop();
              })
        ],
      ).addPaddingXY(paddingX: 30, paddingY: 10),
    );
  }
}
