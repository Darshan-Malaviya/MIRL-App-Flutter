import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/cms_screen/arguments/cms_arguments.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _loginPassKey = GlobalKey<FormState>();
  FocusNode loginFocusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getFirebaseToken();
    });
    super.initState();
  }

  Future getFirebaseToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    SharedPrefHelper.saveFirebaseToken(token);
  }

  @override
  Widget build(BuildContext context) {
    final loginScreenProviderWatch = ref.watch(loginScreenProvider);
    final loginScreenProviderRead = ref.read(loginScreenProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _loginPassKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImageConstants.backgroundLogo,
              ).addPaddingTop(100),
              50.0.spaceY,
              Container(
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
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                      fontFamily: FontWeightEnum.w400.toInter,
                      hintText: StringConstants.typeYourEmailAddress,
                      textAlign: TextAlign.start,
                      controller: loginScreenProviderWatch.emailController,
                      focusNode: loginFocusNode,
                      canRequestFocus: !loginScreenProviderWatch.isLoading,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        return value?.toEmailValidation();
                      },
                      onFieldSubmitted: (value) {
                        loginFocusNode.unfocus();
                      },
                    ).addPaddingX(42),
                    14.0.spaceY,
                    PrimaryButton(
                        title: StringConstants.selectLoginCode,
                        titleColor: ColorConstants.textColor,
                        isLoading: loginScreenProviderWatch.isLoading,
                        width: 235,
                        onPressed: () {
                          loginFocusNode.unfocus();
                          if (_loginPassKey.currentState?.validate() ?? false) {
                            loginScreenProviderRead.loginRequestCall(
                                context: context,
                                loginType: LoginType.normal,
                                email: loginScreenProviderWatch.emailController.text.trim());
                          }
                        }),
                    40.0.spaceY,
                    Image.asset(ImageConstants.line),
                    10.0.spaceY,
                    PrimaryButton(
                      title: StringConstants.continueWithGoogle,
                      titleColor: ColorConstants.textColor,
                      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                      onPressed: () {
                        loginFocusNode.unfocus();
                        loginScreenProviderRead.signInGoogle();
                      },
                      prefixIcon: ImageConstants.google,
                      width: 280,
                    ),
                    Visibility(
                      visible: Platform.isIOS,
                      replacement: const SizedBox.shrink(),
                      child: PrimaryButton(
                        title: StringConstants.continueWithApple,
                        prefixIcon: ImageConstants.apple,
                        titleColor: ColorConstants.textColor,
                        width: 280,
                        margin: EdgeInsets.only(left: 50, right: 50),
                        onPressed: () {
                          loginFocusNode.unfocus();
                          loginScreenProviderRead.signInApple();
                        },
                      ),
                    ),
                    /*           PrimaryButton(
                      title: StringConstants.continueWithFacebook,
                      prefixIcon: ImageConstants.facebook,
                      titleColor: ColorConstants.textColor,
                      width: 280,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      onPressed: () {
                        loginScreenProviderRead.fbLogin();
                      },
                    ),*/
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
                            ..onTap = () {
                              context.unFocusKeyboard();
                              context.toPushNamed(RoutesConstants.cmsScreen,
                                  args: CmsArgs(
                                    name: 'termsConditions',
                                    title: AppConstants.termsAndConditions,
                                  ));
                            },
                        ),
                        TextSpan(
                          text: " ${StringConstants.acknowledge} ",
                          style: textStyle(context: context),
                        ),
                        TextSpan(
                          text: StringConstants.privacyPolicy,
                          style: textStyle(context: context, textColor: ColorConstants.primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.unFocusKeyboard();
                              context.toPushNamed(RoutesConstants.cmsScreen,
                                  args: CmsArgs(title: AppConstants.privacyPolicy, name: "privacyPolicy"));
                            },
                        ),
                      ]),
                    ).addPaddingX(16),
                    30.0.spaceY,
                  ],
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
          decorationColor: ColorConstants.primaryColor,
        );
  }
}
