import 'package:lottie/lottie.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  //late AnimationController _controller;
  late final Future<LottieComposition> _composition;

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

    Future.delayed(const Duration(milliseconds: 5000)).then((value) {
      var isLoginIn = SharedPrefHelper.getUserData;
      if (isLoginIn.isNotEmpty) {
        context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 0);
      } else {
        context.toPushNamedAndRemoveUntil(RoutesConstants.loginScreen);
      }
    });
    super.initState();

    //_composition = AssetLottie(ImageConstants.mirlJson).load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Center(
          //     child: Image.asset(
          //   ImageConstants.splashImages,
          // ),
          child: Lottie.asset(
            ImageConstants.mirlJson,
            decoder: LottieComposition.decodeGZip,
            frameBuilder: (context, child, composition) => Transform.scale(
              scale: 1.3,
              child: child,
            ),
          ),
          // child: Lottie.asset(
          //   ImageConstants.splashScreen,
          //   width: double.infinity,
          //   frameBuilder: (context, child, composition) => Transform.scale(
          //     scale: 1.5,
          //     child: child,
          //   ),
          // ),
        ),
      ),
    );
  }

  Future<LottieComposition?> customDecoder(List<int> bytes) {
    return LottieComposition.decodeZip(bytes, filePicker: (files) {
      return files.firstWhere((f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
    });
  }
}
