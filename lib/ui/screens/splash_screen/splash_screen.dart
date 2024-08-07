import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';
import 'package:mirl/infrastructure/commons/constants/route_constants.dart';
import 'package:mirl/infrastructure/services/shared_pref_helper.dart';
import 'package:mirl/ui/screens/auth_screen/login_screen.dart';
import 'package:mirl/ui/screens/dashboard_screen/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool isLoginIn = false;

  late GifController gifController;

  @override
  void initState() {
    super.initState();
    gifController = GifController(
      loop: false,
      autoPlay: true,
      onFinish: () {
        _onGifCompleted();
      },
    );
    getLoginStatus();
  }

  Future<void> getLoginStatus() async {
    // Assuming SharedPrefHelper.getUserData returns a bool or a non-nullable value indicating login status.
    final loginStatus = await SharedPrefHelper.getUserData;
    isLoginIn = loginStatus.isNotEmpty;
  }

  Future<void> _onGifCompleted() async {
    if (isLoginIn) {
      Navigator.of(context).push(_createRoute(DashboardScreen(index: 0)));
    } else {
      Navigator.of(context).push(_createRoute(LoginScreen()));
    }
  }
  Route _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Center(
              child: GifView.asset(
                controller: gifController,
                ImageConstants.splashImagesGif,
                repeat: ImageRepeat.noRepeat,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                onError: (error) {
                  return Text('ERROR ----$error');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
