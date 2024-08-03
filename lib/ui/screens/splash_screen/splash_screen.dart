import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';
import 'package:mirl/infrastructure/commons/constants/route_constants.dart';
import 'package:mirl/infrastructure/services/shared_pref_helper.dart';

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
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesConstants.dashBoardScreen, (route) => false,
          arguments: 0);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesConstants.loginScreen, (route) => false);
    }
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
