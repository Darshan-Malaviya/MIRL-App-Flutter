import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/providers/add_your_area_expertise_provider.dart';
import 'package:mirl/infrastructure/providers/auth_provider.dart';
import 'package:mirl/infrastructure/providers/call_provider.dart';
import 'package:mirl/infrastructure/providers/cancel_appointment_provider.dart';
import 'package:mirl/infrastructure/providers/common_app_provider.dart';
import 'package:mirl/infrastructure/providers/dashboard_provider.dart';
import 'package:mirl/infrastructure/providers/edit_expert_provider.dart';
import 'package:mirl/infrastructure/providers/filter_provider.dart';
import 'package:mirl/infrastructure/providers/expert_detail_provider.dart';
import 'package:mirl/infrastructure/providers/home_provider.dart';
import 'package:mirl/infrastructure/providers/multi_connect_provider.dart';
import 'package:mirl/infrastructure/providers/report_review_provider.dart';
import 'package:mirl/infrastructure/providers/report_user_provider.dart';
import 'package:mirl/infrastructure/providers/schedule_call_provider.dart';
import 'package:mirl/infrastructure/providers/upcoming_appointment_provider.dart';

// final authProvider = ChangeNotifierProvider.autoDispose((ref) => AuthProvider());
final loginScreenProvider = ChangeNotifierProvider.autoDispose((_) => AuthProvider());
final homeProvider = ChangeNotifierProvider.autoDispose((_) => HomeProvider());
final dashboardProvider = ChangeNotifierProvider.autoDispose((_) => DashboardProvider());
final editExpertProvider = ChangeNotifierProvider.autoDispose((_) => EditExpertProvider());
final addYourAreaExpertiseProvider = ChangeNotifierProvider.autoDispose((_) => AddYourAreaExpertiseProvider());
final expertDetailProvider = ChangeNotifierProvider.autoDispose((_) => ExpertDetailProvider());
final filterProvider = ChangeNotifierProvider<FilterProvider>((ref) => FilterProvider(ref));
final scheduleCallProvider = ChangeNotifierProvider.autoDispose((_) => ScheduleCallProvider());
final commonAppProvider = ChangeNotifierProvider<CommonAppProvider>((_) => CommonAppProvider());
final reportUserProvider = ChangeNotifierProvider.autoDispose((_) => ReportUserProvider());
final callProvider = ChangeNotifierProvider.autoDispose((_) => CallProvider());
final multiConnectProvider = ChangeNotifierProvider.autoDispose((_) => MultiConnectProvider());
final upcomingAppointmentProvider = ChangeNotifierProvider.autoDispose((_) => UpcomingAppointmentProvider());
final cancelAppointmentProvider = ChangeNotifierProvider.autoDispose((_) => CancelAppointmentProvider());
final reportReviewProvider = ChangeNotifierProvider.autoDispose((_) => ReportReviewProvider());

