import 'dart:developer';

import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/utils/value_notifier_utils.dart';
import 'package:mirl/ui/screens/auth_screen/login_screen.dart';
import 'package:mirl/ui/screens/auth_screen/otp_screen.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';
import 'package:mirl/ui/screens/block_user/block_user_list_screen.dart';
import 'package:mirl/ui/screens/block_user/block_user_screen.dart';
import 'package:mirl/ui/screens/block_user/report_user_screen.dart';
import 'package:mirl/ui/screens/block_user/thanks_screen.dart';
import 'package:mirl/ui/screens/cms_screen/arguments/cms_arguments.dart';
import 'package:mirl/ui/screens/cms_screen/cms_screen.dart';
import 'package:mirl/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:mirl/ui/screens/earning_report_screen/earning_report_screen.dart';
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
import 'package:mirl/ui/screens/expert_call_history_screen/expert_call_history_screen.dart';
import 'package:mirl/ui/screens/expert_category_screen/arguments/selected_category_arguments.dart';
import 'package:mirl/ui/screens/expert_category_screen/expert_category_screen.dart';
import 'package:mirl/ui/screens/expert_category_screen/selected_category_screen.dart';
import 'package:mirl/ui/screens/expert_detail/expert_detail_screen.dart';
import 'package:mirl/ui/screens/expert_detail/report_expert_screen.dart';
import 'package:mirl/ui/screens/expert_profile_screen/expert_profile_screen.dart';
import 'package:mirl/ui/screens/explore_expert_screen/explore_expert_screen.dart';
import 'package:mirl/ui/screens/explore_screen%20/explore_screen.dart';
import 'package:mirl/ui/screens/filter_screen/expert_category_filter.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
import 'package:mirl/ui/screens/home_screen/home_screen.dart';
import 'package:mirl/ui/screens/instant_call_screen/arguments/instance_call_dialog_arguments.dart';
import 'package:mirl/ui/screens/instant_call_screen/instant_call_screen.dart';
import 'package:mirl/ui/screens/multi_call_screen/multi_connect_filter_screen.dart';
import 'package:mirl/ui/screens/multi_call_screen/multi_connect_selected_category_screen.dart';
import 'package:mirl/ui/screens/multi_call_screen/multi_connect_screen.dart';
import 'package:mirl/ui/screens/notifications_screen%20/notification_screen.dart';
import 'package:mirl/ui/screens/rating_and_review_screen/rating_and_review_screen.dart';
import 'package:mirl/ui/screens/schedule_screen/booking_screen.dart';
import 'package:mirl/ui/screens/schedule_screen/canceled_appointment_option_screen.dart';
import 'package:mirl/ui/screens/schedule_screen/canceled_appointment_screen.dart';
import 'package:mirl/ui/screens/schedule_screen/schedule_appointment_screen.dart';
import 'package:mirl/ui/screens/schedule_screen/schedule_call_screen.dart';
import 'package:mirl/ui/screens/search_screen/search_screen.dart';
import 'package:mirl/ui/screens/splash_screen/splash_screen.dart';
import 'package:mirl/ui/screens/suggestion/suggest_new_experties_screen.dart';
import 'package:mirl/ui/screens/suggestion/thanks_giving_screen.dart';
import 'package:mirl/ui/screens/upcoming_appointment_screen/upcoming_appointment_screen.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/screens/edit_your_email_id_screen.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/screens/edit_your_name_screen.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/screens/edit_your_phone_number_screen.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/screens/help_and_terms_screen.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/screens/mirl_connect_screen.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/screens/notification_and_preferences_screen.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/screens/payment_details_screen.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/screens/report_an_issue_screen.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/screens/seekar_call_history_screen.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/user_seeting_screen.dart';
import 'package:mirl/ui/screens/video_call_screen/arguments/video_call_arguments.dart';
import 'package:mirl/ui/screens/video_call_screen/video_call_screen.dart';

///use this service for provide global context to widgets
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;
}

/// on generate route
class RouterConstant {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    activeRoute.value = settings.name ?? '';
    log('Active route: ${activeRoute.value}');

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
        return MaterialPageRoute(builder: (_) => DashboardScreen(index: settings.arguments as int));
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
        return MaterialPageRoute(builder: (_) => SetYourWeeklyAvailabilityScreen(initialIndex: settings.arguments as int));
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
      case RoutesConstants.searchScreen:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case RoutesConstants.expertDetailScreen:
        return MaterialPageRoute(builder: (_) => ExpertDetailScreen(expertId: settings.arguments as String));
      // case RoutesConstants.reportExpertDetailScreen:
      //   return MaterialPageRoute(builder: (_) => ReportExpertDetailScreen(args: settings.arguments as BlockUserArgs));
      case RoutesConstants.expertCategoryScreen:
        return MaterialPageRoute(builder: (_) => const ExpertCategoryScreen());
      case RoutesConstants.exploreExpertScreen:
        return MaterialPageRoute(builder: (_) => ExploreExpertScreen(isFromHomePage: settings.arguments as bool));
      case RoutesConstants.selectedExpertCategoryScreen:
        return MaterialPageRoute(builder: (_) => SelectedCategoryScreen(args: settings.arguments as SelectedCategoryArgument));
      case RoutesConstants.expertCategoryFilterScreen:
        return MaterialPageRoute(builder: (_) => ExpertCategoryFilterScreen(args: settings.arguments as FilterArgs));
      case RoutesConstants.scheduleCallScreen:
        return MaterialPageRoute(builder: (_) => ScheduleCallScreen(callArgs: settings.arguments as CallArgs));
      case RoutesConstants.bookingConfirmScreen:
        return MaterialPageRoute(builder: (_) => const BookingConfirmScreen());
      case RoutesConstants.scheduleAppointmentScreen:
        return MaterialPageRoute(builder: (_) => const ScheduleAppointmentScreen());
      case RoutesConstants.canceledAppointmentScreen:
        return MaterialPageRoute(builder: (_) => CanceledAppointmentScreen(args: settings.arguments as CancelArgs));
      case RoutesConstants.canceledAppointmentOptionScreen:
        return MaterialPageRoute(builder: (_) => CanceledAppointmentOptionScreen(args: settings.arguments as CancelArgs));
      case RoutesConstants.blockUserListScreen:
        return MaterialPageRoute(builder: (_) => const BlockUserListScreen());
      case RoutesConstants.reportUserScreen:
        return MaterialPageRoute(builder: (_) => ReportUserScreen(args: settings.arguments as BlockUserArgs));
      case RoutesConstants.thanksScreen:
        return MaterialPageRoute(builder: (_) => const ThanksScreen());
      case RoutesConstants.reportExpertScreen:
        return MaterialPageRoute(builder: (_) => ReportExpertScreen(args: settings.arguments as BlockUserArgs));
      case RoutesConstants.videoCallScreen:
        return MaterialPageRoute(builder: (_) => VideoCallScreen(arguments: settings.arguments as VideoCallArguments));
      case RoutesConstants.instantCallRequestDialogScreen:
        return MaterialPageRoute(builder: (_) => InstantCallRequestDialog(args: settings.arguments as InstanceCallDialogArguments));
      case RoutesConstants.blockUserScreen:
        return MaterialPageRoute(builder: (_) => BlockUserScreen(args: settings.arguments as BlockUserArgs));
      case RoutesConstants.multiConnectScreen:
        return MaterialPageRoute(builder: (_) => const MultiConnectScreen());
      case RoutesConstants.multiConnectFilterScreen:
        return MaterialPageRoute(builder: (_) => MultiConnectFilterScreen());
      case RoutesConstants.multiConnectSelectedCategoryScreen:
        return MaterialPageRoute(builder: (_) => MultiConnectSelectedCategoryScreen(args: settings.arguments as FilterArgs));
      case RoutesConstants.viewCalendarAppointment:
        return MaterialPageRoute(builder: (_) => UpcomingAppointmentScreen(role: settings.arguments as int));
      case RoutesConstants.ratingAndReviewScreen:
        return MaterialPageRoute(builder: (_) => RatingAndReviewScreen(id: settings.arguments as int));
      case RoutesConstants.earningReportScreen:
        return MaterialPageRoute(builder: (_) => EarningReportScreen());
      case RoutesConstants.cmsScreen:
        return MaterialPageRoute(builder: (_) => CmsScreen(args: settings.arguments as CmsArgs));
      case RoutesConstants.mirlConnectScreen:
        return MaterialPageRoute(builder: (_) => MirlConnectScreen());
      case RoutesConstants.helpAndTermsScreen:
        return MaterialPageRoute(builder: (_) => HelpAndTermsScreen());
        case RoutesConstants.notificationAndPreferencesScreen:
        return MaterialPageRoute(builder: (_) => NotificationAndPreferencesScreen());
        case RoutesConstants.reportAnIssueScreen:
        return MaterialPageRoute(builder: (_) => ReportAnIssueScreen());
        case RoutesConstants.paymentDetailsScreen:
        return MaterialPageRoute(builder: (_) => PaymentDetailsScreen());
        case RoutesConstants.seekerCallHistoryScreen:
        return MaterialPageRoute(builder: (_) => SeekerCallHistoryScreen());
      case RoutesConstants.thanksGivingScreen:
        return MaterialPageRoute(builder: (_) => const ThanksGivingScreen());
      case RoutesConstants.suggestNewExpertiseScreen:
        return MaterialPageRoute(builder: (_) => const SuggestNewExpertiseScreen());
        case RoutesConstants.editYourNameScreen:
        return MaterialPageRoute(builder: (_) => const EditYourNameScreen());
        case RoutesConstants.editYourEmailIdScreen:
        return MaterialPageRoute(builder: (_) => const EditYourEmailIdScreen());
        case RoutesConstants.editYourPhoneNumberScreen:
        return MaterialPageRoute(builder: (_) => const EditYourPhoneNumberScreen());
        case RoutesConstants.expertCallHistoryScreen:
        return MaterialPageRoute(builder: (_) => const ExpertCallHistoryScreen());
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
