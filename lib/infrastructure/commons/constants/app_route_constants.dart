import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/auth_screen/login_screen.dart';
import 'package:mirl/ui/screens/auth_screen/otp_screen.dart';
import 'package:mirl/ui/screens/home_screen/home_screen.dart';
import 'package:mirl/ui/screens/splash_screen/splash_screen.dart';

///use this service for provide global context to widgets
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;
}

/// on generate route
class RouterConstant {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// normal page routing
      case RoutesConstants.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      ///page routing with page transition
      case RoutesConstants.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
        case RoutesConstants.otpScreen:
        return MaterialPageRoute(builder: (_) => const OTPScreen());
        case RoutesConstants.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

///page transition animations in routing
class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
