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

    Future.delayed(const Duration(seconds: 5)).then((value) {
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
    // return CustomTooltip(text: '10',position: Offset(200,200));
    // return Scaffold(
    //   body: ReviewSlider(
    //     onChange: (int index) {},
    //   ),
    // );
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: Center(
        child: Lottie.asset(
          ImageConstants.mirlSplashScreenJson,
          repeat: true,
          reverse: true,
          animate: true,
        ),
      ),
      // body: Container(
      //   constraints: const BoxConstraints.expand(),
      //   child: Center(
      //     //     child: Image.asset(
      //     //   ImageConstants.splashImages,
      //     // ),
      //     child: Lottie.asset(
      //       ImageConstants.mirlSplashScreenJson,
      //       decoder: LottieComposition.decodeGZip,
      //       frameBuilder: (context, child, composition) => Transform.scale(
      //         scale: 1,
      //         child: child,
      //       ),
      //     ),
      //     // child: Lottie.asset(
      //     //   ImageConstants.splashScreen,
      //     //   width: double.infinity,
      //     //   frameBuilder: (context, child, composition) => Transform.scale(
      //     //     scale: 1.5,
      //     //     child: child,
      //     //   ),
      //     // ),
      //   ),
      // ),
    );
  }

  Future<LottieComposition?> customDecoder(List<int> bytes) {
    return LottieComposition.decodeZip(bytes, filePicker: (files) {
      return files.firstWhere((f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
    });
  }
}

class CustomTooltip extends StatelessWidget {
  final String text;
  final Offset position;

  const CustomTooltip({
    super.key,
    required this.text,
    required this.position,
  });

  @override

    Widget build(BuildContext context) {
      return Center(
        child: CustomPaint(
          painter: CustomShapePainter(color: Colors.blue),
          size: Size(200, 200), // Adjust the size as needed
        ),
      );
    }
}

class CustomShapePainter extends CustomPainter {
  final Color color; // Optional property for customization

  const CustomShapePainter({this.color = Colors.blue}); // Default color

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color // Use the provided color or default
      ..style = PaintingStyle.fill; // Fill the shape

    final path = Path();

    // **Replace the following with code specific to your shape:**

    // Example lines and curves:
    path.moveTo(size.width * 0.2, size.height * 0.2); // Top left corner
    path.lineTo(size.width * 0.8, size.height * 0.8); // Right side line
    path.quadraticBezierTo(size.width * 0.5, size.height, size.width * 0.2, size.height * 0.8); // Bottom curve
    path.close();

    // **Add or modify path segments as needed based on your shape's components.**

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

