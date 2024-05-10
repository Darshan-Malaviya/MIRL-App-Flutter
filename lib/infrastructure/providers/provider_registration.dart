import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/providers/add_your_area_expertise_provider.dart';
import 'package:mirl/infrastructure/providers/auth_provider.dart';
import 'package:mirl/infrastructure/providers/block_provider.dart';
import 'package:mirl/infrastructure/providers/call_history_provider.dart';
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
import 'package:mirl/infrastructure/providers/notification_provider.dart';
import 'package:mirl/infrastructure/providers/report_user_provider.dart';
import 'package:mirl/infrastructure/providers/schedule_call_provider.dart';
import 'package:mirl/infrastructure/providers/selected_topic_provider.dart';
import 'package:mirl/infrastructure/providers/suggest_new_experties_provider.dart';
import 'package:mirl/infrastructure/providers/socket_provider.dart';
import 'package:mirl/infrastructure/providers/upcoming_appointment_provider.dart';
import 'package:mirl/infrastructure/providers/user_setting_provider.dart';

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
final callProvider = ChangeNotifierProvider<CallProvider>((ref) => CallProvider(ref));
final socketProvider = ChangeNotifierProvider<SocketProvider>((ref) => SocketProvider(ref));
final blockUserProvider = ChangeNotifierProvider.autoDispose((_) => BlockProvider());
final multiConnectProvider = ChangeNotifierProvider.autoDispose((_) => MultiConnectProvider());
final upcomingAppointmentProvider = ChangeNotifierProvider.autoDispose((_) => UpcomingAppointmentProvider());
final cancelAppointmentProvider = ChangeNotifierProvider.autoDispose((_) => CancelAppointmentProvider());
final reportReviewProvider = ChangeNotifierProvider.autoDispose((_) => ReportReviewProvider());
final notificationProvider = ChangeNotifierProvider.autoDispose((_) => NotificationProvider());
final userSettingProvider = ChangeNotifierProvider.autoDispose((_) => UserSettingProvider());
final suggestNewExpertiseProvider = ChangeNotifierProvider.autoDispose((_) => SuggestNewExpertiseProvider());
final callHistoryProvider = ChangeNotifierProvider.autoDispose((_) => CallHistoryProvider());
final selectedTopicProvider = ChangeNotifierProvider.autoDispose((_) => SelectedTopicProvider());

