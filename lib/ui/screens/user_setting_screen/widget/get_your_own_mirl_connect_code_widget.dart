import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:url_launcher/url_launcher.dart';

class GetYourOwnMirlConnectCodeWidget extends ConsumerStatefulWidget {
  const GetYourOwnMirlConnectCodeWidget({super.key});

  @override
  ConsumerState<GetYourOwnMirlConnectCodeWidget> createState() => _GetYourOwnMirlConnectCodeWidgetState();
}

class _GetYourOwnMirlConnectCodeWidgetState extends ConsumerState<GetYourOwnMirlConnectCodeWidget> {
  @override
  Widget build(BuildContext context) {
    final mirlConnectRead = ref.read(mirlConnectProvider);
    final mirlConnectWatch = ref.watch(mirlConnectProvider);

    return Column(
      children: [
        40.0.spaceY,
        TitleSmallText(
          title: LocaleKeys.friendReferralCode.tr().toUpperCase(),
          fontFamily: FontWeightEnum.w600.toInter,
          maxLine: 2,
          titleTextAlign: TextAlign.center,
          titleColor: ColorConstants.blackColor,
        ),
        20.0.spaceY,
        TextFormFieldWidget(
          controller: mirlConnectRead.friendReferralCodeController,
          labelTextSpace: 0.0,
          borderWidth: 1,
          onTap: () {},
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (value) {
            context.unFocusKeyboard();
          },
          height: 45,
          hintText: LocaleKeys.friendReferralCode.tr(),
          alignment: Alignment.centerLeft,
        ),
        20.0.spaceY,
        PrimaryButton(
          buttonColor: ColorConstants.primaryColor,
          title: LocaleKeys.mirlConnectCode.tr(),
          titleColor: ColorConstants.textColor,
          isLoading: mirlConnectWatch.isSubmitLoading,
          onPressed:  () {
            if(mirlConnectRead.friendReferralCodeController.text.isNotEmpty){
              mirlConnectRead.submitReferralCodeApiCall(context: context,friendReferralCode:mirlConnectRead.friendReferralCodeController.text);
            }else{
              FlutterToast().showToast(msg: LocaleKeys.pleaseEnterReferralCode.tr(),);
            }
          },
        ),
        40.0.spaceY,
        GestureDetector(
          onTap: () async {
            if (!await launchUrl(
              Uri.parse(ApiConstants.connect),
              mode: LaunchMode.inAppBrowserView,
              browserConfiguration: const BrowserConfiguration(showTitle: true),
            )
            );
          },
          child: LabelSmallText(
            title: LocaleKeys.inaugural.tr(),
            titleColor: ColorConstants.primaryColor,
            titleTextAlign: TextAlign.center,
            maxLine: 2,
            fontSize: 10,
          ),
        ),
        60.0.spaceY,
        RichText(
          text: TextSpan(
            text: LocaleKeys.referralCode.tr().split("Click")[0],
            style: TextStyle(fontFamily: FontWeightEnum.w500.toInter, color: ColorConstants.blackColor),
            children: <TextSpan>[
              TextSpan(
                text: LocaleKeys.referralCode.tr().split("?")[1],
                style: TextStyle(color: ColorConstants.bottomTextColor,),
                recognizer: TapGestureRecognizer()..onTap = () {
                  mirlConnectRead.getOwnReferralCodeApiCall(context: context).then((value) {
                    if(value==true){
                      // MIRL-REF-00051
                      CommonAlertDialog.dialog(
                          context: context,
                          width: 300,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BodyLargeText(
                                title: LocaleKeys.codeGenerated.tr(),
                                fontFamily: FontWeightEnum.w600.toInter,
                                titleColor: ColorConstants.bottomTextColor,
                                fontSize: 17,
                                titleTextAlign: TextAlign.center,
                              ),
                              20.0.spaceY,
                              BodyLargeText(
                                title: LocaleKeys.awesomeYouAreIn.tr(),
                                maxLine: 5,
                                fontFamily: FontWeightEnum.w400.toInter,
                                titleColor: ColorConstants.blackColor,
                                titleTextAlign: TextAlign.center,
                              ),
                              30.0.spaceY,
                              InkWell(
                                onTap: () async {
                                  await context.toPop();
                                },
                                child: Center(
                                    child: BodyLargeText(
                                      title: LocaleKeys.ok.tr(),
                                      fontFamily: FontWeightEnum.w500.toInter,
                                      titleColor: ColorConstants.bottomTextColor,
                                      fontSize: 17,
                                      titleTextAlign: TextAlign.center,
                                    )).addMarginTop(20),
                              )
                            ],
                          ));
                    }
                  },);
                },
              ),
            ],
          ),
        ),
        40.0.spaceY,
      ],
    );
  }
}
