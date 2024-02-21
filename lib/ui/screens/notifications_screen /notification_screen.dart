import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/expert_notification_widget.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/general_notification_widget.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/all_notification.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/user_notification_widget.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            50.0.spaceY,
            TitleLargeText(
              title: 'ALL NOTIFICATIONS',
              fontSize: 20,
              titleColor: ColorConstants.notificationTextColor,
              titleTextAlign: TextAlign.center,
            ),
            20.0.spaceY,
            AllNotificationTypeNameWidget(),
            10.0.spaceY,
            ExpertNotificationWidget(),
            20.0.spaceY,
            UserNotificationWidget(),
            40.0.spaceY,
            GeneralNotificationWidget()
          ],
        ).addAllPadding(20),
      ),
    );
  }
}
