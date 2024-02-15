import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/expert_older_notifications_widget.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/general_notification_widget.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/new_notification_widget.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/notification_type_name_widget.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/user_older_notification_widget.dart';

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
            NotificationTypeNameWidget(),
            10.0.spaceY,
            TitleMediumText(
              title: 'EXPERT NOTIFICATIONS',
              fontSize: 18,
              titleColor: ColorConstants.notificationTextColor,
              titleTextAlign: TextAlign.center,
            ),
            20.0.spaceY,
            Image.asset(ImageConstants.purpleLine),
            20.0.spaceY,
            TitleMediumText(
              title: 'NEW NOTIFICATIONS',
              titleColor: ColorConstants.notificationTextColor,
              titleTextAlign: TextAlign.center,
            ),
            30.0.spaceY,
            NewNotificationWidget(),
            20.0.spaceY,
            Image.asset(ImageConstants.purpleLine),
            20.0.spaceY,
            TitleMediumText(
              title: 'OLDER NOTIFICATIONS',
              titleColor: ColorConstants.notificationTextColor,
              titleTextAlign: TextAlign.center,
            ),
            20.0.spaceY,
            ExpertOlderNotificationWidget(),
            20.0.spaceY,
            UserOlderNotificationWidget(),
            40.0.spaceY,
            GeneralNotificationWidget()
          ],
        ).addAllPadding(20),
      ),
    );
  }
}
