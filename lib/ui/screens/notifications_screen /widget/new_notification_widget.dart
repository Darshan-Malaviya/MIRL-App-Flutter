import 'package:flutter_html/flutter_html.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/time_extension.dart';

class NewNotificationWidget extends StatelessWidget {
  final int remainingSecond;
  final String title, message, time;

  const NewNotificationWidget({super.key, required this.remainingSecond, required this.title, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.amber,
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
          10.0.spaceY,
          BodySmallText(
            title: title,
            titleColor: ColorConstants.blackColor,
            titleTextAlign: TextAlign.center,
          ),
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
                  alignment: Alignment.centerLeft,lineHeight: LineHeight.normal,padding: HtmlPaddings.zero,margin: Margins.zero,)
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
                    title: Duration(seconds: remainingSecond).toTimeString(),
                    titleColor: ColorConstants.notificationTimerColor,
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  CommonAlertDialog.dialog(
                      context: context,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BodyLargeText(
                            title: 'Notification Timed Out!',
                            fontFamily: FontWeightEnum.w600.toInter,
                            titleColor: ColorConstants.bottomTextColor,
                            fontSize: 17,
                            titleTextAlign: TextAlign.center,
                          ),
                          20.0.spaceY,
                          BodyLargeText(
                            title: 'Boo!\nThis notification is now a ghost.\nSpooky how time flies!',
                            maxLine: 4,
                            fontFamily: FontWeightEnum.w400.toInter,
                            titleColor: ColorConstants.blackColor,
                            titleTextAlign: TextAlign.center,
                          ),
                          30.0.spaceY,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodyMediumText(
                                title: 'Learn more',
                                fontFamily: FontWeightEnum.w500.toInter,
                                titleColor: ColorConstants.bottomTextColor,
                                titleTextAlign: TextAlign.center,
                              ),
                              InkWell(
                                onTap: () => context.toPop(),
                                child: BodyMediumText(
                                  title: 'Back',
                                  fontFamily: FontWeightEnum.w500.toInter,
                                  titleColor: ColorConstants.bottomTextColor,
                                  titleTextAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ).addPaddingX(10)
                        ],
                      ));
                },
                child: BodySmallText(
                  title: time.to12HourTimeFormat().toUpperCase(),
                  titleColor: ColorConstants.notificationTimeColor,
                  titleTextAlign: TextAlign.center,
                  fontFamily: FontWeightEnum.w400.toInter,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
