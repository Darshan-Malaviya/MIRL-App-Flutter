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

bool _messageSent = false;

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
                    onPressed: () {
                      CommonBottomSheet.bottomSheet(
                        isShadowContainer: false,
                        height: MediaQuery.of(context).size.height * 0.8,
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.9),
                        context: context,
                        isDismissible: true,
                        child: StatefulBuilder(
                          builder: (BuildContext context,
                                  StateSetter setState) =>
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Column(
                                    children: [
                                      BodyMediumText(
                                        title: StringConstants.referrals_help,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      BodyMediumText(
                                        title: StringConstants.expertSetupDesc,
                                        titleTextAlign: TextAlign.center,
                                        titleColor:
                                            ColorConstants.textGreyLightColor,
                                      ),
                                      10.0.spaceY,
                                      GestureDetector(
                                        onTap: () async {
                                          final Uri _url = Uri.parse(
                                              AppConstants.useMirlUrl);
                                          if (!await launchUrl(_url)) {
                                            throw Exception(
                                                'Could not launch $_url');
                                          }
                                        },
                                        child: BodyLargeText(
                                          title: StringConstants.MirlGuid,
                                          titleTextAlign: TextAlign.center,
                                          titleColor:
                                              ColorConstants.bottomTextColor,
                                        ),
                                      ),
                                      50.0.spaceY,
                                      BodyMediumText(
                                        title: StringConstants.expertSetupDesc1,
                                        titleTextAlign: TextAlign.center,
                                        titleColor:
                                            ColorConstants.textGreyLightColor,
                                      ),
                                      10.0.spaceY,
                                      Container(
                                        height: 200,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                          maxLines: 1000,
                                          maxLength: 1000,
                                        ),
                                      ),
                                      10.0.spaceY,
                                      PrimaryButton(
                                        height: 50,
                                        buttonColor:
                                            ColorConstants.mirlConnectColor,
                                        title: "SEND MESSAGE",
                                        titleColor:
                                            ColorConstants.buttonTextColor,
                                        fontSize: 12,
                                        onPressed: () {
                                          setState(() {
                                            _messageSent = true;
                                          });
                                        },
                                      ),
                                    ],
                                  )),
                        ),
                      );
                    },
                    // onPressed: () => context.toPushNamed(RoutesConstants.earningReportScreen),
                  ),
                  50.0.spaceY,
                  PrimaryButton(
                    height: 40,
                    buttonColor: ColorConstants.buttonColor,
                    title: LocaleKeys.accountHelp.tr().toUpperCase(),
                    titleColor: ColorConstants.buttonTextColor,
                    fontSize: 12,
                    onPressed: () {
                      CommonBottomSheet.bottomSheet(
                        isShadowContainer: false,
                        height: MediaQuery.of(context).size.height * 0.8,
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.9),
                        context: context,
                        isDismissible: true,
                        child: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) =>
                                  Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: !_messageSent
                                ? SingleChildScrollView(
                                  child: Column(
                                      children: [
                                        BodyMediumText(
                                          title: StringConstants.expertSetup,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        BodyMediumText(
                                          title: StringConstants.expertSetupDesc,
                                          titleTextAlign: TextAlign.center,
                                          titleColor:
                                              ColorConstants.textGreyLightColor,
                                        ),
                                        10.0.spaceY,
                                        GestureDetector(
                                          onTap: () async {
                                            final Uri _url = Uri.parse(
                                                AppConstants.expertSetupUrl);
                                            if (!await launchUrl(_url)) {
                                              throw Exception(
                                                  'Could not launch $_url');
                                            }
                                          },
                                          child: BodyLargeText(
                                            title: StringConstants.setupAcc,
                                            titleTextAlign: TextAlign.center,
                                            titleColor:
                                                ColorConstants.bottomTextColor,
                                          ),
                                        ),
                                        50.0.spaceY,
                                        BodyMediumText(
                                          title: StringConstants.expertSetupDesc1,
                                          titleTextAlign: TextAlign.center,
                                          titleColor:
                                              ColorConstants.textGreyLightColor,
                                        ),
                                        10.0.spaceY,
                                        Container(
                                          height: 200,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                            maxLines: 1000,
                                            maxLength: 1000,
                                          ),
                                        ),
                                        10.0.spaceY,
                                        PrimaryButton(
                                          height: 50,
                                          buttonColor:
                                              ColorConstants.mirlConnectColor,
                                          title: "SEND MESSAGE",
                                          titleColor:
                                              ColorConstants.buttonTextColor,
                                          fontSize: 12,
                                          onPressed: () {
                                            setState(() {
                                              _messageSent = true;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                )
                                : SingleChildScrollView(
                                  child: Column(
                                      children: [
                                        TitleLargeText(
                                          title: StringConstants.msgReceived,
                                          titleColor:
                                              ColorConstants.bottomTextColor,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        BodyMediumText(
                                          title: StringConstants.thankYouMessage,
                                          titleTextAlign: TextAlign.center,
                                          titleColor:
                                              ColorConstants.textGreyLightColor,
                                        ),
                                        50.0.spaceY,
                                        Image.asset(
                                          ImageConstants.help_message_sent,
                                          scale: 4,
                                        ),
                                        50.0.spaceY,
                                        PrimaryButton(
                                          height: 50,
                                          buttonColor:
                                              ColorConstants.mirlConnectColor,
                                          title: "BACK TO MY USER PROFILE",
                                          titleColor:
                                              ColorConstants.buttonTextColor,
                                          fontSize: 12,
                                          onPressed: () {
                                            setState(() {
                                              _messageSent = false;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                ),
                          ),
                        ),
                      );
                    },
                    // onPressed: () => context.toPushNamed(RoutesConstants.earningReportScreen),
                  ),
                  50.0.spaceY,
                  PrimaryButton(
                    height: 40,
                    buttonColor: ColorConstants.buttonColor,
                    title: LocaleKeys.seekerHelpCenter.tr(),
                    titleColor: ColorConstants.buttonTextColor,
                    onPressed: () {
                      // showModalBottomSheet(
                      //     context: context,
                      //   builder: (context){
                      //     return SingleChildScrollView(
                      //       child: Container(
                      //           padding: const EdgeInsets.symmetric(
                      //               horizontal: 10, vertical: 20),
                      //           child: Column(
                      //             children: [
                      //               BodyMediumText(
                      //                 title: StringConstants.seekerHelp,
                      //               ),
                      //               SizedBox(
                      //                 height: 10,
                      //               ),
                      //               BodyMediumText(
                      //                 title: StringConstants.seekerDesc,
                      //                 titleTextAlign: TextAlign.center,
                      //                 titleColor:
                      //                 ColorConstants.textGreyLightColor,
                      //               ),
                      //               10.0.spaceY,
                      //               GestureDetector(
                      //                 onTap: () {},
                      //                 child: BodyLargeText(
                      //                   title: StringConstants.seekerFaq,
                      //                   titleTextAlign: TextAlign.center,
                      //                   titleColor:
                      //                   ColorConstants.bottomTextColor,
                      //                 ),
                      //               ),
                      //               50.0.spaceY,
                      //               BodyMediumText(
                      //                 title: StringConstants.seekerDesc1,
                      //                 titleTextAlign: TextAlign.center,
                      //                 titleColor:
                      //                 ColorConstants.textGreyLightColor,
                      //               ),
                      //               10.0.spaceY,
                      //               Container(
                      //                 height: 200,
                      //                 child: TextFormField(
                      //                   decoration: InputDecoration(
                      //                     enabledBorder: OutlineInputBorder(
                      //                       borderRadius:
                      //                       BorderRadius.circular(20.0),
                      //                     ),
                      //                     focusedBorder: OutlineInputBorder(
                      //                       borderRadius:
                      //                       BorderRadius.circular(20.0),
                      //                     ),
                      //                   ),
                      //                   maxLines: 1000,
                      //                   maxLength: 1000,
                      //                 ),
                      //               ),
                      //               10.0.spaceY,
                      //               PrimaryButton(
                      //                 height: 50,
                      //                 buttonColor:
                      //                 ColorConstants.mirlConnectColor,
                      //                 title: "SEND MESSAGE",
                      //                 titleColor:
                      //                 ColorConstants.buttonTextColor,
                      //                 fontSize: 12,
                      //                 onPressed: () {
                      //                   setState(() {});
                      //                 },
                      //               ),
                      //             ],
                      //           )),
                      //     );
                      //   }
                      // );
                      CommonBottomSheet.bottomSheet(
                        isShadowContainer: false,
                        context: context,
                        isDismissible: true,
                        child: StatefulBuilder(
                          builder: (BuildContext context,
                                  StateSetter setState) =>
                              SingleChildScrollView(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        BodyMediumText(
                                          title: StringConstants.seekerHelp,
                                        ),
                                        10.0.spaceY,
                                        BodyMediumText(
                                          title: StringConstants.seekerDesc,
                                          titleTextAlign: TextAlign.center,
                                          titleColor:
                                              ColorConstants.textGreyLightColor,
                                        ),
                                        10.0.spaceY,
                                        GestureDetector(
                                          onTap: () {},
                                          child: BodyLargeText(
                                            title: StringConstants.seekerFaq,
                                            titleTextAlign: TextAlign.center,
                                            titleColor:
                                                ColorConstants.bottomTextColor,
                                          ),
                                        ),
                                        50.0.spaceY,
                                        BodyMediumText(
                                          title: StringConstants.seekerDesc1,
                                          titleTextAlign: TextAlign.center,
                                          titleColor:
                                              ColorConstants.textGreyLightColor,
                                        ),
                                        10.0.spaceY,
                                        Container(
                                          height: 200,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                            maxLines: 1000,
                                            maxLength: 1000,
                                          ),
                                        ),
                                        10.0.spaceY,
                                        PrimaryButton(
                                          height: 50,
                                          buttonColor:
                                              ColorConstants.mirlConnectColor,
                                          title: "SEND MESSAGE",
                                          titleColor:
                                              ColorConstants.buttonTextColor,
                                          fontSize: 12,
                                          onPressed: () {
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    )),
                              ),
                        ),
                      );
                    },
                    fontSize: 12,
                    // onPressed: () => context.toPushNamed(RoutesConstants.earningReportScreen),
                  ),
                  50.0.spaceY,
                  PrimaryButton(
                    height: 40,
                    buttonColor: ColorConstants.yellowButtonColor,
                    title: LocaleKeys.privacyAndTerms.tr(),
                    titleColor: ColorConstants.buttonTextColor,
                    fontSize: 12,
                    onPressed: () async {
                      context.toPushNamed(RoutesConstants.userPolicies);
                      // if (!await launchUrl(
                      //   Uri.parse(ApiConstants.privacyPolicy),
                      //   mode: LaunchMode.inAppBrowserView,
                      //   browserConfiguration:
                      //       const BrowserConfiguration(showTitle: true),
                      // )) ;
                    },
                  ),
                  50.0.spaceY,
                  PrimaryButton(
                    height: 40,
                    buttonColor: ColorConstants.buttonColor,
                    title: LocaleKeys.deleteAccount.tr(),
                    titleColor: ColorConstants.buttonTextColor,
                    fontSize: 12,
                    onPressed: () {
                      CommonBottomSheet.bottomSheet(
                        isShadowContainer: false,
                        height: MediaQuery.of(context).size.height * 0.8,
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.9),
                        context: context,
                        isDismissible: true,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              HeadlineSmallText(
                                title: StringConstants.deleteAccount,
                                titleColor: ColorConstants.bottomTextColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BodySmallText(
                                title: StringConstants.deleteDesc,
                                titleTextAlign: TextAlign.center,
                                titleColor: ColorConstants.textGreyLightColor,
                              ),
                              10.0.spaceY,
                              BodySmallText(
                                title: StringConstants.deleteDesc1,
                                titleTextAlign: TextAlign.center,
                                titleColor: ColorConstants.textGreyLightColor,
                              ),
                              10.0.spaceY,
                              BodySmallText(
                                title: StringConstants.deleteDesc2,
                                titleTextAlign: TextAlign.center,
                                titleColor: ColorConstants.textGreyLightColor,
                              ),
                              25.0.spaceY,
                              Image.asset(
                                ImageConstants.deleteAccount,
                                scale: 4,
                              ),
                              30.0.spaceY,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  PrimaryButton(
                                    width: 150,
                                    height: 40,
                                    buttonColor:
                                        ColorConstants.yellowButtonColor,
                                    title: LocaleKeys.back.tr(),
                                    titleColor: ColorConstants.buttonTextColor,
                                    fontSize: 12,
                                    onPressed: () async {},
                                  ),
                                  PrimaryButton(
                                    width: 150,
                                    height: 40,
                                    buttonColor:
                                        ColorConstants.mirlConnectColor,
                                    title: LocaleKeys.yes.tr(),
                                    titleColor: ColorConstants.buttonTextColor,
                                    fontSize: 12,
                                    onPressed: () async {},
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    // onPressed: () => context.toPushNamed(RoutesConstants.earningReportScreen),
                  ),
                ],
              ).addMarginX(30)
            ],
          ).addAllPadding(20),
        ));
  }
}

Widget bottomSheetContent(
    {String? title, String? desc, String? desc1, String? linkTitle}) {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            BodyMediumText(
              title: title ?? "",
            ),
            SizedBox(
              height: 10,
            ),
            BodyMediumText(
              title: desc ?? "",
              titleTextAlign: TextAlign.center,
              titleColor: ColorConstants.textGreyLightColor,
            ),
            10.0.spaceY,
            GestureDetector(
              onTap: () {},
              child: BodyLargeText(
                title: linkTitle ?? "",
                titleTextAlign: TextAlign.center,
                titleColor: ColorConstants.bottomTextColor,
              ),
            ),
            50.0.spaceY,
            BodyMediumText(
              title: desc1 ?? "",
              titleTextAlign: TextAlign.center,
              titleColor: ColorConstants.textGreyLightColor,
            ),
            10.0.spaceY,
            Container(
              height: 200,
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                maxLines: 1000,
                maxLength: 1000,
              ),
            ),
            10.0.spaceY,
            PrimaryButton(
              height: 50,
              buttonColor: ColorConstants.mirlConnectColor,
              title: "SEND MESSAGE",
              titleColor: ColorConstants.buttonTextColor,
              fontSize: 12,
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        )),
  );
}
