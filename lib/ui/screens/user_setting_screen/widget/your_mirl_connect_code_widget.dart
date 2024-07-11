import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/constants/storage_constants.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/user_setting_screen/screens/mirl_referral_dashboard_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class YourMirlConnectCodeWidget extends ConsumerStatefulWidget {
  const YourMirlConnectCodeWidget({super.key});

  @override
  ConsumerState<YourMirlConnectCodeWidget> createState() => _YourMirlConnectCodeWidgetState();
}

class _YourMirlConnectCodeWidgetState extends ConsumerState<YourMirlConnectCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.0.spaceY,
        TitleSmallText(
          title: LocaleKeys.mirlMagic.tr(),
          fontFamily: FontWeightEnum.w400.toInter,
          maxLine: 2,
          titleTextAlign: TextAlign.center,
          titleColor: ColorConstants.blackColor,
        ),
        40.0.spaceY,
        PrimaryButton(
          height: 50,
          width: MediaQuery.sizeOf(context).width * 0.8,
          buttonColor: ColorConstants.primaryColor,
          title: LocaleKeys.yourMirlConnectCode.tr(),
          fontSize: 15,
          titleColor: ColorConstants.textColor,
          onPressed: () {
            // context.toPop();
          },
        ),
        20.0.spaceY,
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          height: 50,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          alignment: Alignment.center,
          child: SelectableText(
            SharedPrefHelper.getString(StorageConstants.myReferralCode),
            style: TextStyle(fontFamily: FontWeightEnum.w600.toInter, fontSize: 17),
          ),
        ),
        4.0.spaceY,
        TitleSmallText(
          title: LocaleKeys.inviteYourFriend.tr(),
          fontFamily: FontWeightEnum.w400.toInter,
          maxLine: 2,
          titleTextAlign: TextAlign.center,
          titleColor: ColorConstants.greyColor,
        ),
        40.0.spaceY,
        TitleSmallText(
          fontFamily: FontWeightEnum.w600.toInter,
          title: LocaleKeys.moreYouInvite.tr(),
          titleColor: ColorConstants.blackColor,
          maxLine: 2,
        ),
        6.0.spaceY,
        TitleSmallText(
          fontFamily: FontWeightEnum.w400.toInter,
          title: LocaleKeys.turnConnections.tr(),
          titleColor: ColorConstants.blackColor,
          titleTextAlign: TextAlign.center,
          maxLine: 10,
        ),
        20.0.spaceY,
        LabelSmallText(
          title: LocaleKeys.inaugural.tr(),
          titleColor: ColorConstants.primaryColor,
          titleTextAlign: TextAlign.center,
          maxLine: 2,
          fontSize: 10,
        ),
        20.0.spaceY,
        PrimaryButton(
          buttonColor: ColorConstants.yellowButtonColor,
          title: LocaleKeys.inviteWhatsapp.tr(),
          titleColor: ColorConstants.textColor,
          onPressed: () async {
            String url =
                "https://wa.me/?text=This is my Code: ${SharedPrefHelper.getString(StorageConstants.myReferralCode)}";
            await launchUrl(Uri.parse(url));
          },
        ),
        20.0.spaceY,
        PrimaryButton(
          buttonColor: ColorConstants.yellowButtonColor,
          title: LocaleKeys.shareInviteLink.tr(),
          titleColor: ColorConstants.textColor,
          onPressed: () {
            Share.share(
                'This is my referral Code:\n\nhttps://bolstersys.com/share/?referral_code=${SharedPrefHelper.getString(StorageConstants.myReferralCode)}');
          },
        ),
        20.0.spaceY,
        PrimaryButton(
          buttonColor: ColorConstants.yellowButtonColor,
          title: LocaleKeys.myReferralDashboard.tr(),
          titleColor: ColorConstants.textColor,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MirlReferralDashboardScreen(),
                ));
          },
        ),
      ],
    );
  }
}
