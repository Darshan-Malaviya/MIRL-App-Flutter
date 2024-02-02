import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/auth_screen/login_screen.dart';
import 'package:mirl/ui/screens/auth_screen/otp_screen.dart';
import 'package:mirl/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:mirl/ui/screens/edit_profile/add_your_areas_of_expertise_screen.dart';
import 'package:mirl/ui/screens/edit_profile/certifications_and_experience_screen.dart';
import 'package:mirl/ui/screens/edit_profile/edit_your_expert_profile_screen.dart';
import 'package:mirl/ui/screens/edit_profile/instant_calls_availability_screen.dart';
import 'package:mirl/ui/screens/edit_profile/more_about_me_screen.dart';
import 'package:mirl/ui/screens/edit_profile/set_your_fee_screen.dart';
import 'package:mirl/ui/screens/edit_profile/set_your_gender_screen.dart';
import 'package:mirl/ui/screens/edit_profile/set_your_location_screen.dart';
import 'package:mirl/ui/screens/edit_profile/set_your_weekly_availability_screen.dart';
import 'package:mirl/ui/screens/edit_profile/your_bank_account_details_screen.dart';
import 'package:mirl/ui/screens/edit_profile/your_expert_profile_name.dart';
import 'package:mirl/ui/screens/edit_profile/your_mirl_id_update_screen.dart';
import 'package:mirl/ui/screens/expert_detail/expert_detail_screen.dart';
import 'package:mirl/ui/screens/expert_profile_screen/expert_profile_screen.dart';
import 'package:mirl/ui/screens/explore_screen%20/explore_screen.dart';
import 'package:mirl/ui/screens/home_screen/home_screen.dart';
import 'package:mirl/ui/screens/notifications_screen%20/notification_screen.dart';
import 'package:mirl/ui/screens/schedule_screen/schedule_call_screen.dart';
import 'package:mirl/ui/screens/splash_screen/splash_screen.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/user_seeting_screen.dart';

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
      case RoutesConstants.dashBoardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case RoutesConstants.expertProfileScreen:
        return MaterialPageRoute(builder: (_) => const ExpertProfileScreen());
      case RoutesConstants.exploreScreen:
        return MaterialPageRoute(builder: (_) => const ExploreScreen());
      case RoutesConstants.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case RoutesConstants.userSettingScreen:
        return MaterialPageRoute(builder: (_) => const UserSettingScreen());
      case RoutesConstants.editYourExpertProfileScreen:
        return MaterialPageRoute(builder: (_) => const EditYourExpertProfileScreen());
      case RoutesConstants.setYourFreeScreen:
        return MaterialPageRoute(builder: (_) => const SetYourFreeScreen());
      case RoutesConstants.instantCallsAvailabilityScreen:
        return MaterialPageRoute(builder: (_) => const InstantCallsAvailabilityScreen());
      case RoutesConstants.setYourLocationScreen:
        return MaterialPageRoute(builder: (_) => const SetYourLocationScreen());
      case RoutesConstants.setYourGenderScreen:
        return MaterialPageRoute(builder: (_) => const SetYourGenderScreen());
      case RoutesConstants.setWeeklyAvailability:
        return MaterialPageRoute(builder: (_) => const SetYourWeeklyAvailabilityScreen());
      case RoutesConstants.certificationsAndExperienceScreen:
        return MaterialPageRoute(builder: (_) => const CertificationsAndExperienceScreen());
      case RoutesConstants.yourBankAccountDetailsScreen:
        return MaterialPageRoute(builder: (_) => const YourBankAccountDetailsScreen());
      case RoutesConstants.addYourAreasOfExpertiseScreen:
        return MaterialPageRoute(builder: (_) => const AddYourAreasOfExpertiseScreen());
      case RoutesConstants.yourExpertProfileName:
        return MaterialPageRoute(builder: (_) => const YourExpertProfileNameScreen());
      case RoutesConstants.yourMirlId:
        return MaterialPageRoute(builder: (_) => const YourMirlIdScreen());
      case RoutesConstants.moreAboutMeScreen:
        return MaterialPageRoute(builder: (_) => const MoreAboutMeScreen());
        case RoutesConstants.expertDetailScreen:
        return MaterialPageRoute(builder: (_) => const ExpertDetailScreen());
      case RoutesConstants.scheduleCallScreen:
        return MaterialPageRoute(builder: (_) => const ScheduleCallScreen());
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
