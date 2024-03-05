import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/notification_list_response_model.dart';
import 'package:mirl/ui/common/grouped_list_widget/grouped_list.dart';
import 'package:mirl/ui/screens/notifications_screen%20/widget/new_notification_widget.dart';

class ExpertNotificationWidget extends ConsumerStatefulWidget {
  const ExpertNotificationWidget({super.key});

  @override
  ConsumerState<ExpertNotificationWidget> createState() => _ExpertNotificationWidgetState();
}

class _ExpertNotificationWidgetState extends ConsumerState<ExpertNotificationWidget> {
  ScrollController scrollController = ScrollController();

/*  String value = '''
  <body>
    <p style="font-weight: 400; font-size: 16px;">Nice! You’ve just scheduled an appointment with [Mansi]. <span style="color: #6F50EA;">Click here to view the full details and schedule.</span></p>
  </body>''';*/

  String value = '''<!DOCTYPE html>
<html>
  <head>
  <title>Page Title</title>
  <style>
  *{
  margin:0;
  padding:0;
  box-sizing: border-box;
  }
      p {
          font-weight: 400;
          font-size: 16px;
          text-align: start;
      };
  </style>
  </head>
  <body>
  <p>Your appointment has been canceled as per your request. Your payment will be refunded in 2-4 working days.</p>
  </body>
  </html>''';

  @override
  void initState() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(reportReviewProvider).reachedLastPage;
        if (!isLoading) {
          ref.read(notificationProvider).getNotificationListApiCall(isFullScreenLoader: false, type: 1, pageLoading: true);
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
              /*      TitleMediumText(
          title: 'EXPERT NOTIFICATIONS',
          fontSize: 18,
          titleColor: ColorConstants.notificationTextColor,
          titleTextAlign: TextAlign.center,
        ),
        20.0.spaceY,
        Image.asset(ImageConstants.purpleLine),*/
              Expanded(
                child: notificationProviderWatch.notificationList.isNotEmpty
                    ? GroupedListView<NotificationDetails, dynamic>(
                        controller: scrollController,
                        reverse: false,
                        separator: 30.0.spaceY,
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
                          return NewNotificationWidget(
                            remainingSecond: notificationProviderWatch.secondsRemaining,
                            message: value,
                            title: element.notification?.title ?? '',
                            time: element.notification?.firstCreated ?? '',
                          );
                        },
                      )
                    : Container(),
              ),
              Visibility(visible: notificationProviderWatch.isPageLoading, child: CupertinoActivityIndicator(color: ColorConstants.primaryColor)),

              /*    TitleMediumText(
          title: 'NEW NOTIFICATIONS',
          titleColor: ColorConstants.notificationTextColor,
          titleTextAlign: TextAlign.center,
        ),
        30.0.spaceY,
        NewNotificationWidget(
          remainingSecond: notificationProviderWatch.secondsRemaining,
          message: '',
          time: '',
          title: '',
        ),
        20.0.spaceY,
        Image.asset(ImageConstants.purpleLine),
        20.0.spaceY,
        TitleMediumText(
          title: 'OLDER NOTIFICATIONS',
          titleColor: ColorConstants.notificationTextColor,
          titleTextAlign: TextAlign.center,
        ),
        20.0.spaceY,
        ExpertOlderNotificationWidget(),*/
            ],
          ).addAllPadding(20);
  }

  Widget messageSeparator(String value) {
    return Center(
      child: TitleMediumText(
        title: value.getChatHeaderDate(),
        titleColor: ColorConstants.notificationTextColor,
        titleTextAlign: TextAlign.center,
      ).addMarginY(30),
    );
  }
}
