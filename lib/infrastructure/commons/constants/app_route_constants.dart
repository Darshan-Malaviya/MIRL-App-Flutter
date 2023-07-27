import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
import 'package:flutter_boilerplate_may_2023/ui/screens/animated_button.dart';
import 'package:flutter_boilerplate_may_2023/ui/screens/screen.dart';

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
        return MaterialPageRoute(builder: (_) => AnimatedButton());

      ///page routing with page transition
      case RoutesConstants.loginScreen:
        return MaterialPageRoute(builder: (_) => Container());
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
