import 'package:flutter_html/flutter_html.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class UserOlderNotificationWidget extends StatelessWidget {
  final Color? titleBgColor;
  final String title, message, time;
  final VoidCallback onTap;

  const UserOlderNotificationWidget({super.key, this.titleBgColor, required this.title, required this.message, required this.time, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorConstants.whiteColor,
          boxShadow: [
            BoxShadow(offset: Offset(0, 2), color: ColorConstants.blackColor.withOpacity(0.25), spreadRadius: 0, blurRadius: 2),
          ],
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Stack(
          children: [
            Container(
              color: titleBgColor,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: BodySmallText(
                title: title,
                titleColor: ColorConstants.blackColor,
                titleTextAlign: TextAlign.center,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.0.spaceY,
                Html(
                  data: message,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BodySmallText(
                      title: time.timeAgo(),
                      titleColor: ColorConstants.notificationTimeColor,
                      titleTextAlign: TextAlign.center,
                      fontFamily: FontWeightEnum.w400.toInter,
                    ),
                  ],
                ),
                10.0.spaceY,
              ],
            ).addMarginX(20),
          ],
        ),
      ),
    );
  }
}
