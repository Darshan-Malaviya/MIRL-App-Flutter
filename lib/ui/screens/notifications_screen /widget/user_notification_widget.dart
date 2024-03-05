import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/new_notification_widget.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/user_older_notification_widget.dart';

class UserNotificationWidget extends ConsumerStatefulWidget {
  const UserNotificationWidget({super.key});

  @override
  ConsumerState<UserNotificationWidget> createState() => _UserNotificationWidgetState();
}

class _UserNotificationWidgetState extends ConsumerState<UserNotificationWidget> {
  @override
  Widget build(BuildContext context) {
    final notificationProviderWatch = ref.watch(notificationProvider);
    final notificationProviderRead = ref.read(notificationProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          TitleMediumText(
            title: 'USER NOTIFICATIONS',
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
          NewNotificationWidget(remainingSecond: notificationProviderWatch.secondsRemaining,message: '',time: '',title: '', ),
          20.0.spaceY,
          Image.asset(ImageConstants.purpleLine),
          20.0.spaceY,
          TitleMediumText(
            title: 'OLDER NOTIFICATIONS',
            titleColor: ColorConstants.notificationTextColor,
            titleTextAlign: TextAlign.center,
          ),
          20.0.spaceY,
          UserOlderNotificationWidget(),
        ],
      ).addAllPadding(20),
    );
  }
}
