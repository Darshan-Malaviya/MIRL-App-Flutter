import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/expert_older_notifications_widget.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/new_notification_widget.dart';

class ExpertNotificationWidget extends ConsumerStatefulWidget {
  const ExpertNotificationWidget({super.key});

  @override
  ConsumerState<ExpertNotificationWidget> createState() => _ExpertNotificationWidgetState();
}

class _ExpertNotificationWidgetState extends ConsumerState<ExpertNotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
