import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/margin_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends ConsumerStatefulWidget {
  const OTPScreen({super.key});

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //ref.watch(signupProvider).otpController.clear();

      //ref.watch(signupProvider).fileName = null;
    });
    super.initState();
    ref.read(loginScreenProvider).startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final loginScreenProviderWatch = ref.watch(loginScreenProvider);
    final loginScreenProviderRead = ref.read(loginScreenProvider);
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height, maxWidth: MediaQuery.of(context).size.width),
        decoration: const BoxDecoration(color: ColorConstants.whiteColor),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  ImageConstants.emailVerification,
                  height: 180,
                  width: 180,
                ).addMarginTop(80),
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
                    //FilteringTextInputFormatter.deny(RegExp(RegexConstants.blankSpace)),
                    FilteringTextInputFormatter.deny(RegExp(RegexConstants.emojiRegex)),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: loginScreenProviderWatch.otpController,
                  keyboardType: TextInputType.number,
                  length: 6,
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
                //  Image.asset(ImageConstants.line),
                PrimaryButton(
                  title: StringConstants.verifyOtp,
                  onPressed: () {
                    if (loginScreenProviderWatch.otpController.text.isNotEmpty) {
                      loginScreenProviderRead.otpVerifyRequestCall();
                    } else {
                      FlutterToast().showToast(msg: "The OTP Field is required ");
                    }
                  },
                ).addPaddingX(55),
                20.0.spaceY,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: BodySmallText(
                        title: 'You can resend code in ',
                        fontFamily: FontWeightEnum.w600.toInter,
                      ),
                    ),
                    if (loginScreenProviderRead.secondsRemaining == 0) ...{
                      4.0.spaceX,
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            loginScreenProviderWatch.enableResend ? loginScreenProviderRead.loginRequestCall(loginType: 0) : null;
                          },
                          child: BodySmallText(
                            title: 'Resend',
                            fontFamily: FontWeightEnum.w700.toInter,
                            titleColor:
                                loginScreenProviderWatch.enableResend ? ColorConstants.primaryColor : ColorConstants.whiteColor,

                            // style: TextStyle(
                            //     color:
                            //         loginScreenProviderWatch.enableResend ? ColorConstants.primaryColor : ColorConstants.whiteColor,
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    } else ...{
                      Flexible(
                        child: BodySmallText(
                          title: _getTimeString(Duration(seconds: loginScreenProviderWatch.secondsRemaining)),
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    }
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTimeString(Duration time) {
    final minutes = time.inMinutes.remainder(Duration.minutesPerHour).toString().padLeft(2, '0');
    final seconds = time.inSeconds.remainder(Duration.secondsPerMinute).toString().padLeft(2, '0');
    return time.inHours > 0 ? "${time.inHours}:${minutes.padLeft(2, "0")}:$seconds" : "$minutes:$seconds";
  }
}
