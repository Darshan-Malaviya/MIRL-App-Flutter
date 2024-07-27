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
// Map of All button title and link
final Map<int,Map<String,String>> buttonData = {
  0:{
    "title":LocaleKeys.privacyTerms.tr(),
    "link": ApiConstants.privacyPolicy
  },
  1:{
    "title":LocaleKeys.termsAndConditions.tr(),
    "link": ApiConstants.termsConditions
  },
  2:{
    "title":LocaleKeys.endUserEula.tr(),
    "link": ApiConstants.endUserEula
  },
  3:{
    "title":LocaleKeys.cookiePolicy.tr(),
    "link": ApiConstants.cookiePolicy
  },
  4:{
    "title":LocaleKeys.disclaimer.tr(),
    "link": ApiConstants.disclaimer
  },
  5:{
    "title":LocaleKeys.acceptableUsePolicy.tr(),
    "link": ApiConstants.acceptableUsePolicy
  },
  6:{
    "title":LocaleKeys.userGeneratedContent.tr(),
    "link": ApiConstants.userGeneratedContent
  },
  7:{
    "title":LocaleKeys.refundPolicy.tr(),
    "link": ApiConstants.refundPolicy
  }
};

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
              maxLine: 2,
              titleTextAlign: TextAlign.center,
            ),
            10.0.spaceY,
            BodySmallText(
              title: StringConstants.PoliciesWelcomeMsg,
              titleTextAlign: TextAlign.center,
              titleColor: ColorConstants.textGreyLightColor,
            ),
            40.0.spaceY,
            ...List.generate(buttonData.length, (index){
              return Column(
                children: [
                  PrimaryButton(
                    height: 40,
                    buttonColor:
                    ColorConstants.yellowButtonColor,
                    title: buttonData[index]!['title'].toString(),
                    titleColor: ColorConstants.buttonTextColor,
                    fontSize: 12,
                    onPressed: () async {
                      final Uri _url = Uri.parse(buttonData[index]!['link'].toString());
                      if (!await launchUrl(_url)) {
                        throw Exception('Could not launch $_url');
                      }
                    },
                  ),
                  40.0.spaceY,
                ],
              );
            }),
          ],
        ).addAllPadding(20),
      ),
    );
  }
}
