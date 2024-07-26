import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:url_launcher/url_launcher.dart';

class userPolicies extends ConsumerStatefulWidget {
  const userPolicies({super.key});

  @override
  ConsumerState<userPolicies> createState() => _HelpAndTermsScreenState();
}



class _HelpAndTermsScreenState extends ConsumerState<userPolicies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            10.0.spaceY,
            TitleLargeText(
              fontSize: 20,
              title: StringConstants.userPolicies,
              titleColor: ColorConstants.bottomTextColor,
            ),
            10.0.spaceY,
            BodySmallText(
              title: StringConstants.PoliciesWelcomeMsg,
              titleTextAlign: TextAlign.center,
              titleColor: ColorConstants.textGreyLightColor,
            ),
            40.0.spaceY,
            PrimaryButton(
              height: 40,
              buttonColor:
              ColorConstants.yellowButtonColor,
              title: LocaleKeys.privacyTerms.tr(),
              titleColor: ColorConstants.buttonTextColor,
              fontSize: 12,
              onPressed: () async {},
            ),
            40.0.spaceY,
            PrimaryButton(
              height: 40,
              buttonColor:
              ColorConstants.yellowButtonColor,
              title: LocaleKeys.back.tr(),
              titleColor: ColorConstants.buttonTextColor,
              fontSize: 12,
              onPressed: () async {},
            ),
            40.0.spaceY,
            PrimaryButton(
              height: 40,
              buttonColor:
              ColorConstants.yellowButtonColor,
              title: LocaleKeys.back.tr(),
              titleColor: ColorConstants.buttonTextColor,
              fontSize: 12,
              onPressed: () async {},
            ),
            40.0.spaceY,
            PrimaryButton(
              height: 40,
              buttonColor:
              ColorConstants.yellowButtonColor,
              title: LocaleKeys.back.tr(),
              titleColor: ColorConstants.buttonTextColor,
              fontSize: 12,
              onPressed: () async {},
            ),
            40.0.spaceY,
            PrimaryButton(
              height: 40,
              buttonColor:
              ColorConstants.yellowButtonColor,
              title: LocaleKeys.back.tr(),
              titleColor: ColorConstants.buttonTextColor,
              fontSize: 12,
              onPressed: () async {},
            ),
            40.0.spaceY,
            PrimaryButton(
              height: 40,
              buttonColor:
              ColorConstants.yellowButtonColor,
              title: LocaleKeys.back.tr(),
              titleColor: ColorConstants.buttonTextColor,
              fontSize: 12,
              onPressed: () async {},
            ),
            40.0.spaceY,
            PrimaryButton(
              height: 40,
              buttonColor:
              ColorConstants.yellowButtonColor,
              title: LocaleKeys.back.tr(),
              titleColor: ColorConstants.buttonTextColor,
              fontSize: 12,
              onPressed: () async {},
            ),
            40.0.spaceY,
            PrimaryButton(
              height: 40,
              buttonColor:
              ColorConstants.yellowButtonColor,
              title: LocaleKeys.back.tr(),
              titleColor: ColorConstants.buttonTextColor,
              fontSize: 12,
              onPressed: () async {},
            ),
          ],
        ).addAllPadding(20),
      ),
    );
  }
}
