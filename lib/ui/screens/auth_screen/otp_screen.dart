import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/time_extension.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends ConsumerStatefulWidget {
  const OTPScreen({super.key});

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  FocusNode otpFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    ref.read(loginScreenProvider).startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final loginScreenProviderWatch = ref.watch(loginScreenProvider);
    final loginScreenProviderRead = ref.read(loginScreenProvider);

    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () {
            loginScreenProviderWatch.otpController.clear();
            loginScreenProviderWatch.timer?.cancel();
            context.toPop();
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: MediaQuery.of(context).viewInsets.bottom > 0.0?BouncingScrollPhysics():NeverScrollableScrollPhysics(),
        child: Container(
          height:MediaQuery.of(context).viewInsets.bottom > 0.0? MediaQuery.of(context).size.height/1.3:MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: 80),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: ColorConstants.borderColor,
                blurRadius: 5,
                offset: Offset(0, -3),
              )
            ],
            color: ColorConstants.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                ImageConstants.emailVerification,
                height: 180,
                width: 180,
              ).addMarginTop(30),
              BodyLargeText(
                title: StringConstants.checkYourEmail,
                fontWeight: FontWeight.bold,
                fontFamily: FontWeightEnum.w600.toInter,
              ),
              BodyLargeText(
                title: StringConstants.secretCode,
                fontFamily: FontWeightEnum.w500.toInter,
              ),
              BodyLargeText(
                title: StringConstants.enterHereLogin,
                fontFamily: FontWeightEnum.w500.toInter,
              ),
              60.0.spaceY,
              Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(RegexConstants.emojiRegex)),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: loginScreenProviderWatch.otpController,
                focusNode: otpFocusNode,
                keyboardType: TextInputType.number,
                length: 6,
                onSubmitted: (value) {
                  otpFocusNode.unfocus();
                },
                focusedPinTheme: PinTheme(
                  height: 45,
                  width: 46,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.blackColor),
                    borderRadius: BorderRadius.circular(6.0),
                    shape: BoxShape.rectangle,
                    color: ColorConstants.whiteColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 7.0,
                      ),
                    ],
                  ),
                ),
                followingPinTheme: PinTheme(
                  height: 45,
                  width: 46,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.blackColor),
                    borderRadius: BorderRadius.circular(6.0),
                    shape: BoxShape.rectangle,
                    color: ColorConstants.whiteColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 7.0,
                      ),
                    ],
                  ),
                ),
                submittedPinTheme: PinTheme(
                  height: 45,
                  width: 46,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.blackColor),
                    borderRadius: BorderRadius.circular(6.0),
                    shape: BoxShape.rectangle,
                    color: ColorConstants.whiteColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 7.0,
                      ),
                    ],
                  ),
                ),
              ).addPaddingX(20),
              60.0.spaceY,
              PrimaryButton(
                title: StringConstants.verifyOtp,
                titleColor: ColorConstants.textColor,
                onPressed: () {
                  otpFocusNode.unfocus();
                  if (loginScreenProviderWatch.otpController.text.isNotEmpty) {
                    loginScreenProviderRead.otpVerifyRequestCall();
                  } else {
                    FlutterToast().showToast(msg: LocaleKeys.pleaseEnterOtp.tr());
                  }
                },
              ).addPaddingX(55),
              20.0.spaceY,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: BodySmallText(
                      title: loginScreenProviderRead.secondsRemaining == 0 ? LocaleKeys.dontReceiveCode.tr() : LocaleKeys.youCanSendAnotherCode.tr(),
                      fontFamily: FontWeightEnum.w600.toInter,
                      maxLine: 2,
                    ),
                  ),
                  if (loginScreenProviderRead.secondsRemaining == 0) ...{
                    4.0.spaceX,
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          otpFocusNode.unfocus();
                          loginScreenProviderWatch.otpController.clear();
                          loginScreenProviderRead.loginRequestCall(
                            context: context,
                            loginType: 0,
                            email: loginScreenProviderWatch.emailController.text.trim(),
                            fromResend: true,
                          );
                        },
                        child: BodySmallText(
                          title: LocaleKeys.resend.tr(),
                          titleColor: ColorConstants.primaryColor,
                        ),
                      ),
                    )
                  } else ...{
                    // Flexible(
                    //   child: BodySmallText(
                    //     title: Duration(seconds: loginScreenProviderWatch.secondsRemaining).toTimeString(),
                    //     fontSize: 10,
                    //   ),
                    // ),
                  Row(
                    children: [
                      BodySmallText(titleColor: ColorConstants.primaryColor,
                        title: Duration(seconds: loginScreenProviderWatch.secondsRemaining).toTimeString(),
                        fontSize: 12,
                      ),
                      4.0.spaceX,
                      BodySmallText(
                        title: LocaleKeys.minutes.tr(),
                        fontFamily: FontWeightEnum.w600.toInter,
                        maxLine: 2,
                        fontSize: 12,),
                    ],
                  )
                  }
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
