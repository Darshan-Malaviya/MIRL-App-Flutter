import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndTermsScreen extends ConsumerStatefulWidget {
  const HelpAndTermsScreen({super.key});

  @override
  ConsumerState<HelpAndTermsScreen> createState() => _HelpAndTermsScreenState();
}

class _HelpAndTermsScreenState extends ConsumerState<HelpAndTermsScreen> {
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
            children: [
              30.0.spaceY,
              TitleLargeText(
                // title: LocaleKeys.reportThisUser.tr(),
                title: LocaleKeys.helpTerms.tr(),
                titleColor: ColorConstants.bottomTextColor,
                titleTextAlign: TextAlign.center,
              ),
              10.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.information.tr(),
                titleColor: ColorConstants.blackColor,
                titleTextAlign: TextAlign.center,
                fontFamily: FontWeightEnum.w400.toInter,
                maxLine: 3,
              ),
              50.0.spaceY,
              Column(
                children: [
                  PrimaryButton(
                    height: 40,
                    buttonColor: ColorConstants.yellowButtonColor,
                    title: LocaleKeys.useMirl.tr(),
                    titleColor: ColorConstants.buttonTextColor,
                    fontSize: 12,
                    onPressed: () async {
                      final Uri _url = Uri.parse(AppConstants.useMirlUrl);
                      if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                      }
                    },
                  ),
                  50.0.spaceY,
                  PrimaryButton(
                    height: 40,
                    buttonColor: ColorConstants.yellowButtonColor,
                    title: LocaleKeys.mustKnows.tr(),
                    titleColor: ColorConstants.buttonTextColor,
                    fontSize: 12,
                    onPressed: () async {
                      final Uri _url = Uri.parse(AppConstants.faqUrl);
                      if (!await launchUrl(_url)) {
                        throw Exception('Could not launch $_url');
                      }
                    },
                    // onPressed: () => context.toPushNamed(RoutesConstants.earningReportScreen),
                  ),
                  50.0.spaceY,
                  PrimaryButton(
                    height: 40,
                    buttonColor: ColorConstants.buttonColor,
                    title: LocaleKeys.referralsHelp.tr(),
                    titleColor: ColorConstants.buttonTextColor,
                    fontSize: 12,
                    onPressed: () {},
                    // onPressed: () => context.toPushNamed(RoutesConstants.earningReportScreen),
                  ),
                  50.0.spaceY,
                  PrimaryButton(
                    height: 40,
                    buttonColor: ColorConstants.buttonColor,
                    title: LocaleKeys.accountHelp.tr(),
                    titleColor: ColorConstants.buttonTextColor,
                    fontSize: 12,
                    onPressed: () {},
                    // onPressed: () => context.toPushNamed(RoutesConstants.earningReportScreen),
                  ),
                  50.0.spaceY,
                  PrimaryButton(
                    height: 40,
                    buttonColor: ColorConstants.buttonColor,
                    title: LocaleKeys.callsAndPayments.tr(),
                    titleColor: ColorConstants.buttonTextColor,
                    onPressed: () {},
                    fontSize: 12,
                    // onPressed: () => context.toPushNamed(RoutesConstants.earningReportScreen),
                  ),
                  50.0.spaceY,
                  PrimaryButton(
                    height: 40,
                    buttonColor: ColorConstants.buttonColor,
                    title: LocaleKeys.privacyAndTerms.tr(),
                    titleColor: ColorConstants.buttonTextColor,
                    fontSize: 12,
                    onPressed: () {},
                    // onPressed: () => context.toPushNamed(RoutesConstants.earningReportScreen),
                  ),
                  50.0.spaceY,
                  PrimaryButton(
                    height: 40,
                    buttonColor: ColorConstants.buttonColor,
                    title: LocaleKeys.deleteAccount.tr(),
                    titleColor: ColorConstants.buttonTextColor,
                    fontSize: 12,
                    onPressed: () {},
                    // onPressed: () => context.toPushNamed(RoutesConstants.earningReportScreen),
                  ),
                ],
              ).addMarginX(30)
            ],
          ).addAllPadding(20),
        ));
  }
}
