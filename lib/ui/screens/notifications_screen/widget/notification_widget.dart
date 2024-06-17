import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/enums/notification_color_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/time_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';

class NotificationWidget extends ConsumerStatefulWidget {
  final String title, message, time,notificationKey;
  final VoidCallback onTap;
  final bool newNotification;

  const NotificationWidget({super.key,required this.title, required this.message, required this.time, required this.onTap,required this.notificationKey,required this.newNotification});

  @override
  ConsumerState<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends ConsumerState<NotificationWidget> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    if(widget.notificationKey == NotificationTypeEnum.multiConnectRequestUser.name || widget.notificationKey == NotificationTypeEnum.multipleConnectRequestExpert.name){
      if(widget.newNotification) {
        ref.read(notificationProvider).startTimer(widget.time);
      }
    }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        decoration: BoxDecoration(
          color: widget.newNotification ? Colors.amber : ColorConstants.whiteColor,
          border: Border.all(color: ColorConstants.dropDownBorderColor),
          boxShadow: [
            BoxShadow(offset: Offset(0, 0), color: ColorConstants.whiteColor.withOpacity(0.25), spreadRadius: 1, blurRadius: 1),
          ],
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BodySmallText(
              title: widget.title,
              titleColor: ColorConstants.blackColor,
              titleTextAlign: TextAlign.center,
            ),
            Html(
              data: widget.message,
              shrinkWrap: true,
              style: {
                'html': Style(
                  textAlign: TextAlign.start,
                  maxLines: 30,
                  fontFamily: FontWeightEnum.w400.toInter,
                  color: ColorConstants.blackColor,
                  fontSize: FontSize.medium,
                  alignment: Alignment.centerLeft,
                  lineHeight: LineHeight.normal,
                  padding: HtmlPaddings.zero,
                  margin: Margins.zero,
                )
              },
            ),
            20.0.spaceY,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ImageConstants.timer),
                    6.0.spaceX,
                    BodyMediumText(
                      title: Duration(seconds: ref.watch(notificationProvider).secondsRemaining).toTimeString(),
                      titleColor: ColorConstants.notificationTimerColor,
                    ),
                  ],
                ).addVisibility(ref.watch(notificationProvider).timer?.isActive ?? false),
                BodySmallText(
                  title: widget.time.timeAgo(),
                  titleColor: ColorConstants.notificationTimeColor,
                  titleTextAlign: TextAlign.center,
                  fontFamily: FontWeightEnum.w400.toInter,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
