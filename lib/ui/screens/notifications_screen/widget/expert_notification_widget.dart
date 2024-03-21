import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/notification_color_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';
import 'package:mirl/infrastructure/models/common/notification_data_model.dart';
import 'package:mirl/infrastructure/models/response/cancel_appointment_response_model.dart';
import 'package:mirl/infrastructure/models/response/notification_list_response_model.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
import 'package:mirl/ui/common/grouped_list_widget/grouped_list.dart';
import 'package:mirl/ui/screens/notifications_screen/widget/notification_widget.dart';

class ExpertNotificationWidget extends ConsumerStatefulWidget {
  const ExpertNotificationWidget({super.key});

  @override
  ConsumerState<ExpertNotificationWidget> createState() => _ExpertNotificationWidgetState();
}

class _ExpertNotificationWidgetState extends ConsumerState<ExpertNotificationWidget> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(notificationProvider).reachedLastPage;
        if (!isLoading) {
          ref.read(notificationProvider).getNotificationListApiCall(isFullScreenLoader: false, type: NotificationType.expert, pageLoading: true);
        } else {
          log('reach last page on expert notification list api');
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notificationProviderWatch = ref.watch(notificationProvider);
    final notificationProviderRead = ref.read(notificationProvider);

    return notificationProviderWatch.isLoading
        ? CupertinoActivityIndicator(color: ColorConstants.primaryColor)
        : Column(
            children: [
              Expanded(
                child: notificationProviderWatch.notificationList.isNotEmpty
                    ? GroupedListView<NotificationDetails, dynamic>(
                        controller: scrollController,
                        reverse: false,
                        separator: 30.0.spaceY,
                        padding: EdgeInsets.zero,
                        elements: notificationProviderWatch.notificationList,
                        groupBy: (element) {
                          return DateTime(DateTime.parse(element.notification?.firstCreated ?? '').year, DateTime.parse(element.notification?.firstCreated ?? '').month,
                                  DateTime.parse(element.notification?.firstCreated ?? '').day)
                              .toString();
                        },
                        groupComparator: (value1, value2) => value2.compareTo(value1),
                        shrinkWrap: true,
                        sort: false,
                        groupSeparatorBuilder: (value) {
                          return messageSeparator(value);
                        },
                        itemBuilder: (_, element) {
                          return NotificationWidget(
                            remainingSecond: notificationProviderWatch.secondsRemaining,
                            message: element.notification?.message ?? '',
                            title: element.notification?.title ?? '',
                            time: element.notification?.firstCreated ?? '',
                            onTap: () {
                              CommonMethods.onTapNotification(element.notification?.data ?? '', context);
                            },
                          );
                        },
                      )
                    : Center(
                        child: TitleMediumText(
                          title: LocaleKeys.emptyNotification.tr(),
                          titleColor: ColorConstants.notificationTextColor,
                          fontFamily: FontWeightEnum.w400.toInter,
                          titleTextAlign: TextAlign.center,
                        ),
                      ),
              ),
              notificationProviderWatch.isPageLoading ? 20.0.spaceY : 0.0.spaceY,
              Visibility(visible: notificationProviderWatch.isPageLoading, child: CupertinoActivityIndicator(color: ColorConstants.primaryColor)),
            ],
          ).addMarginX(20);
  }

  Widget messageSeparator(String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Image.asset(ImageConstants.purpleLine),
        ).addVisibility(value.getHeaderTitle() == LocaleKeys.oldNotifications.tr()),
        TitleMediumText(
          title: value.getHeaderTitle(),
          titleColor: ColorConstants.notificationTextColor,
          titleTextAlign: TextAlign.center,
        ).addMarginY(20),
      ],
    );
  }
}
