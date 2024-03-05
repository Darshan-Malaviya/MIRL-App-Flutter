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

class _NotificationScreenState extends ConsumerState<NotificationScreen> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController?.addListener(_handleTabSelection);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(notificationProvider).getNotificationListApiCall(isFullScreenLoader: true, type: 1,pageLoading: false);
    });

    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final notificationProviderWatch = ref.watch(notificationProvider);
    final notificationProviderRead = ref.read(notificationProvider);

    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          40.0.spaceY,
          TitleLargeText(
            title: 'ALL NOTIFICATIONS',
            fontSize: 20,
            titleColor: ColorConstants.notificationTextColor,
            titleTextAlign: TextAlign.center,
          ),
          30.0.spaceY,
          TabBar(
            overlayColor: MaterialStatePropertyAll(Colors.transparent),
            indicatorColor: ColorConstants.transparentColor,
            dividerColor: ColorConstants.transparentColor,
            tabs: [
              AllNotificationTypeNameWidget(notificationName: "EXPERT", isSelectedShadow: tabController?.index == 0 ? true : false, imageURL: ImageConstants.expertNotifications),
              AllNotificationTypeNameWidget(notificationName: "USER", isSelectedShadow: tabController?.index == 1 ? true : false, imageURL: ImageConstants.userNotifications),
              AllNotificationTypeNameWidget(notificationName: "GENERAL", isSelectedShadow: tabController?.index == 2 ? true : false, imageURL: ImageConstants.generalNotifications),
            ],
            controller: tabController,
          ),
          20.0.spaceY,
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const [ExpertNotificationWidget(), UserNotificationWidget(), GeneralNotificationWidget()],
            ),
          ),
        ],
      ),
    );
  }
}
