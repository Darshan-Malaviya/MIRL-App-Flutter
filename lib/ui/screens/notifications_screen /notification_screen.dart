import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/expert_older_notifications_widget.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/new_notification_widget.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/notification_type_name_widget.dart';

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
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.whiteColor,
                //border: Border.all(color: ColorConstants.dropDownBorderColor),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 2), color: ColorConstants.blackColor.withOpacity(0.25), spreadRadius: 0, blurRadius: 2),
                ],
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      BodySmallText(
                        title: 'NEW NOTIFICATIONS',
                        titleColor: ColorConstants.blackColor,
                        titleTextAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  20.0.spaceY,
                  TitleMediumText(
                    title:
                        'Yay! A user has picked you among others for a Multiple Connect Call! Click here to be the chosen one or decline the request now.',
                    titleColor: ColorConstants.blackColor,
                    maxLine: 10,
                    titleTextAlign: TextAlign.start,
                    fontFamily: FontWeightEnum.w400.toInter,
                  ),
                  20.0.spaceY,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BodySmallText(
                        title: 'Yesterday',
                        titleColor: ColorConstants.notificationTimeColor,
                        titleTextAlign: TextAlign.center,
                        fontFamily: FontWeightEnum.w400.toInter,
                      ),
                    ],
                  )
                ],
              ).addMarginXY(paddingX: 20, paddingY: 10),
            )
          ],
        ).addAllPadding(20),
      ),
    );
  }
}
