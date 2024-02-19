import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/general_new_notification_widget.dart';

class GeneralNotificationWidget extends ConsumerStatefulWidget {
  const GeneralNotificationWidget({super.key});

  @override
  ConsumerState<GeneralNotificationWidget> createState() => _GeneralNotificationWidgetState();
}

class _GeneralNotificationWidgetState extends ConsumerState<GeneralNotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleMediumText(
          title: 'GENERAL NOTIFICATIONS',
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
        GeneralNewNotificationWidget(),
        20.0.spaceY,
        Image.asset(ImageConstants.purpleLine),
        20.0.spaceY,
        TitleMediumText(
          title: 'OLDER NOTIFICATIONS',
          titleColor: ColorConstants.notificationTextColor,
          titleTextAlign: TextAlign.center,
        ),
        20.0.spaceY,
        GeneralNewNotificationWidget(bgColor: Colors.white, titleColor: ColorConstants.primaryColor),
      ],
    );
  }
}
