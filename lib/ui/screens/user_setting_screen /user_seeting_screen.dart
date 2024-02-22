import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class UserSettingScreen extends ConsumerStatefulWidget {
  const UserSettingScreen({super.key});

  @override
  ConsumerState<UserSettingScreen> createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends ConsumerState<UserSettingScreen> {
  @override
  Widget build(BuildContext context) {
    final providerWatch = ref.watch(callProvider);

    return Scaffold(
      appBar: AppBarWidget(),
      body:

          // SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       TitleLargeText(
          //         title: LocaleKeys.userProfileAndSetting.tr(),
          //         titleColor: ColorConstants.bottomTextColor,
          //         titleTextAlign: TextAlign.center,
          //       ),
          //       20.0.spaceY,
          //       BodySmallText(
          //         title: LocaleKeys.editUserPicture.tr(),
          //         titleColor: ColorConstants.blackColor,
          //         titleTextAlign: TextAlign.center,
          //       ),
          //       20.0.spaceY,
          //       Container(),
          //       20.0.spaceY,
          //       LabelSmallText(
          //         title: LocaleKeys.userProfileDesc.tr(),
          //         titleColor: ColorConstants.blackColor,
          //         titleTextAlign: TextAlign.center,
          //         fontSize: 10,
          //         maxLine: 5,
          //         fontFamily: FontWeightEnum.w600.toInter,
          //       ),
          //       20.0.spaceY,
          //       Container(),
          //       20.0.spaceY,
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           TitleMediumText(
          //             title: LocaleKeys.yourDetails.tr(),
          //             titleColor: ColorConstants.blueColor,
          //           ),
          //           18.0.spaceY,
          //           TextFormFieldWidget(
          //             enabledBorderColor: ColorConstants.borderLightColor,
          //             isReadOnly: true,
          //             onTap: () {},
          //             height: 30,
          //             labelText: LocaleKeys.yourName.tr(),
          //             alignment: Alignment.centerLeft,
          //             labelTextSpace: 0.0,
          //           ),
          //           20.0.spaceY,
          //           TextFormFieldWidget(
          //             labelTextSpace: 0.0,
          //             enabledBorderColor: ColorConstants.borderLightColor,
          //             isReadOnly: true,
          //             onTap: () {},
          //             height: 30,
          //             labelText: LocaleKeys.emailId.tr(),
          //             alignment: Alignment.centerLeft,
          //           ),
          //           20.0.spaceY,
          //           TextFormFieldWidget(
          //             labelTextSpace: 0.0,
          //             enabledBorderColor: ColorConstants.borderLightColor,
          //             isReadOnly: true,
          //             onTap: () {},
          //             height: 30,
          //             labelText: LocaleKeys.phoneNumber.tr(),
          //             alignment: Alignment.centerLeft,
          //           ),
          //           50.0.spaceY,
          //           PrimaryButton(
          //             buttonColor: ColorConstants.buttonColor,
          //             title: LocaleKeys.notificationAndPreference.tr(),
          //             titleColor: ColorConstants.buttonTextColor,
          //             onPressed: () => context.toPushNamed(RoutesConstants.mirlConnectScreen),
          //           ),
          //           50.0.spaceY,
          //           PrimaryButton(
          //             buttonColor: ColorConstants.buttonColor,
          //             title: LocaleKeys.reportAndIssue.tr(),
          //             titleColor: ColorConstants.buttonTextColor,
          //             onPressed: () {},
          //             //  onPressed: () => context.toPushNamed(RoutesConstants.ratingAndReviewScreen),
          //           ),
          //           50.0.spaceY,
          //           PrimaryButton(
          //             buttonColor: ColorConstants.buttonColor,
          //             title: LocaleKeys.callHistoryAndBilling.tr(),
          //             titleColor: ColorConstants.buttonTextColor,
          //             onPressed: () {},
          //             // onPressed: () => context.toPushNamed(RoutesConstants.earningReportScreen),
          //           ),
          //           50.0.spaceY,
          //           PrimaryButton(
          //             buttonColor: ColorConstants.buttonColor,
          //             title: LocaleKeys.signOut.tr(),
          //             titleColor: ColorConstants.buttonTextColor,
          //             onPressed: () {
          //               SharedPrefHelper.clearPrefs();
          //               context.toPushNamedAndRemoveUntil(RoutesConstants.loginScreen);
          //             },
          //           ),
          //           50.0.spaceY,
          //         ],
          //       ).addMarginX(20),
          //     ],
          //   ).addAllPadding(20),
          // )

          Center(
        child: PrimaryButton(
          title: StringConstants.logOut,
          onPressed: () async {
            SharedPrefHelper.clearPrefs();
            context.toPushNamedAndRemoveUntil(RoutesConstants.loginScreen);
          },
        ),
      ).addAllPadding(20),
    );
  }
}
