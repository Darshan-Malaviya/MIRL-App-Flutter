import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/services/shared_pref_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // SharedPrefHelper get _sharePref => _services.sharedPreferenceService;

  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 2), () async {
    //   context.toPushNamedAndRemoveUntil(RoutesConstants.loginScreen);
    //   if (_sharePref.getUserLogout) {
    //     context.toPushNamedAndRemoveUntil(RoutesConstants.loginScreen);
    //   } else {
    //     context.toPushNamedAndRemoveUntil(RoutesConstants.homeScreen);
    //   }
    // });

    Future.delayed(const Duration(seconds: 3)).then((value) {
      var isLoginIn = SharedPrefHelper.getUserData;
      if (isLoginIn.isNotEmpty) {
        context.toPushNamedAndRemoveUntil(RoutesConstants.homeScreen);
      } else {
        context.toPushNamedAndRemoveUntil(RoutesConstants.loginScreen);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: Center(child: Image.asset(ImageConstants.mirlImage)),
    );
  }
}
