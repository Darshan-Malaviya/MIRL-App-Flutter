import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/margin_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _loginPassKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginScreenProviderWatch = ref.watch(loginScreenProvider);
    final loginScreenProviderRead = ref.read(loginScreenProvider);
    return Scaffold(
      body: Form(
        key: _loginPassKey,
        child: Column(
          children: [
            Image.asset(
              ImageConstants.backgroundLogo,
              height: 270,
              width: 270,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.greyColor,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      )
                    ],
                    color: ColorConstants.whiteColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TitleLargeText(
                        title: StringConstants.letsMirl,
                        fontFamily: FontWeightEnum.w700.toInter,
                        fontSize: 20,
                      ),

                      8.0.spaceY,
                      BodySmallText(
                        title: StringConstants.discoverExperts,
                        fontFamily: FontWeightEnum.w500.toInter,
                      ),
                      40.0.spaceY,
                      TextFormFieldWidget(
                        fontFamily: FontWeightEnum.w400.toInter,
                        hintText: StringConstants.typeYourEmailAddress,
                        textAlign: TextAlign.start,
                        controller: loginScreenProviderWatch.emailController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringConstants.requiredEmail;
                          } else {
                            if (!EmailValidator.validate(value)) {
                              return StringConstants.emailIsNotInProperFormat;
                            }
                          }
                          return null;
                        },
                      ).addPaddingX(10),
                      14.0.spaceY,
                      PrimaryButton(
                          title: StringConstants.selectLoginCode,
                          onPressed: () {
                            if (_loginPassKey.currentState?.validate() ?? false) {
                              loginScreenProviderRead.loginRequestCall(loginType: 0);
                            }
                          }).addMarginX(20),
                      30.0.spaceY,
                      Image.asset(ImageConstants.line),
                      // const HorizontalLine(),
                      30.0.spaceY,
                      PrimaryButton(
                        title: StringConstants.continueWithGoogle,
                        onPressed: () {
                          loginScreenProviderRead.signInGoogle();
                        },
                        prefixIcon: ImageConstants.google,
                      ),
                      // 30.0.spaceY,
                      Visibility(
                          visible: Platform.isIOS,
                          replacement: const SizedBox.shrink(),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: PrimaryButton(
                                title: StringConstants.continueWithApple,
                                prefixIcon: ImageConstants.apple,
                                onPressed: () {
                                  loginScreenProviderRead.signInApple();
                                }),
                          )),
                      30.0.spaceY,
                      PrimaryButton(
                        title: StringConstants.continueWithFacebook,
                        prefixIcon: ImageConstants.facebook,
                        onPressed: () {
                          loginScreenProviderRead.fbLogin();
                        },
                      ),
                      30.0.spaceY,
                      RichText(
                        softWrap: true,
                        textAlign: TextAlign.center,
                        text: TextSpan(text: StringConstants.signingUp, style: textStyle(context: context), children: [
                          const TextSpan(text: ' '),
                          TextSpan(
                              text: StringConstants.termsAndCondition,
                              style: textStyle(context: context, textColor: ColorConstants.primaryColor),
                              recognizer: TapGestureRecognizer()
                              // ..onTap = () {
                              //   privacyPolicy();
                              // },
                              ),
                          TextSpan(text: " ${StringConstants.acknowledge} ", style: textStyle(context: context)),
                          TextSpan(
                              text: StringConstants.privacyPolicy,
                              style: textStyle(context: context, textColor: ColorConstants.primaryColor),
                              recognizer: TapGestureRecognizer()
                              // ..onTap = () {
                              //   termsOfUse();
                              // },
                              ),
                        ]),
                      )
                      // const LabelSmallText(
                      //   title: StringConstants.terms,
                      //   fontWeight: FontWeight.w400,
                      //   fontSize: 10,
                      // ),
                    ],
                  ).addAllPadding(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle? textStyle({required BuildContext context, Color? textColor, bool? isUnderline}) {
    return Theme.of(context).textTheme.bodySmall?.copyWith(
          color: textColor ?? Theme.of(context).textTheme.bodySmall?.color,
          fontFamily: FontWeightEnum.w400.toInter,
          fontSize: 10,
          //decoration: (isUnderline ?? false) ? TextDecoration.underline : null,
          decorationColor: ColorConstants.primaryColor,
        );
  }
}
