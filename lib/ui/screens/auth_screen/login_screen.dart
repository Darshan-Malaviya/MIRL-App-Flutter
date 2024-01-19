import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                ImageConstants.backgroundLogo,
              ).addPaddingTop(100),
              40.0.spaceY,
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  // decoration: ShapeDecoration(
                  //   color: Colors.white,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(40),
                  //       topRight: Radius.circular(40),
                  //     ),
                  //   ),
                  //   shadows: [
                  //     BoxShadow(
                  //       color: Color(0x4C000000),
                  //       blurRadius: 5,
                  //     )
                  //   ]
                  // ),
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.borderColor,
                          //spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, -3),
                        )
                      ],
                      color: ColorConstants.whiteColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      25.0.spaceY,
                      TitleLargeText(
                        title: StringConstants.letsMirl,
                        fontFamily: FontWeightEnum.w800.toInter,
                        fontSize: 20,
                      ),
                      8.0.spaceY,
                      BodySmallText(
                        title: StringConstants.discoverExperts,
                        fontFamily: FontWeightEnum.w600.toInter,
                        titleColor: ColorConstants.blackColor,
                      ),
                      40.0.spaceY,
                      TextFormFieldWidget(
                        fontFamily: FontWeightEnum.w400.toInter,
                        hintText: StringConstants.typeYourEmailAddress,
                        textAlign: TextAlign.start,
                        controller: loginScreenProviderWatch.emailController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.emailAddress,
                        onFieldSubmitted: (value) {
                          context.unFocusKeyboard();
                        },
                        validator: (value) {
                          return value?.toEmailValidation();
                        },
                      ).addPaddingX(42),
                      14.0.spaceY,
                      PrimaryButton(
                          title: StringConstants.selectLoginCode,
                          width: 235,
                          onPressed: () {
                            if (_loginPassKey.currentState?.validate() ?? false) {
                              loginScreenProviderRead.loginRequestCall(loginType: LoginType.normal);
                            }
                          }),
                      40.0.spaceY,
                      Image.asset(ImageConstants.line),
                      40.0.spaceY,
                      PrimaryButton(
                        title: StringConstants.continueWithGoogle,
                        onPressed: () {
                          loginScreenProviderRead.signInGoogle();
                        },
                        prefixIcon: ImageConstants.google,
                      ).addMarginX(50),
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
                            },
                          ),
                        ),
                      ).addPaddingX(50),
                      30.0.spaceY,
                      PrimaryButton(
                        title: StringConstants.continueWithFacebook,
                        prefixIcon: ImageConstants.facebook,
                        onPressed: () {
                          loginScreenProviderRead.fbLogin();
                        },
                      ).addPaddingX(50),
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
                          TextSpan(
                            text: " ${StringConstants.acknowledge} ",
                            style: textStyle(context: context),
                          ),
                          TextSpan(
                              text: StringConstants.privacyPolicy,
                              style: textStyle(context: context, textColor: ColorConstants.primaryColor),
                              recognizer: TapGestureRecognizer()
                              // ..onTap = () {
                              //   termsOfUse();
                              // },
                              ),
                        ]),
                      ).addPaddingX(16),
                      30.0.spaceY,
                      // const LabelSmallText(
                      //   title: StringConstants.terms,
                      //   fontWeight: FontWeight.w400,
                      //   fontSize: 10,
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle? textStyle({required BuildContext context, Color? textColor, bool? isUnderline}) {
    return Theme.of(context).textTheme.bodySmall?.copyWith(
          color: textColor ?? Theme.of(context).textTheme.bodySmall?.color,
          fontFamily: FontWeightEnum.w500.toInter,
          fontSize: 10,
          //decoration: (isUnderline ?? false) ? TextDecoration.underline : null,
          decorationColor: ColorConstants.primaryColor,
        );
  }
}
