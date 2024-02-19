import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class NewNotificationWidget extends StatefulWidget {
  const NewNotificationWidget({super.key});

  @override
  State<NewNotificationWidget> createState() => _NewNotificationWidgetState();
}

class _NewNotificationWidgetState extends State<NewNotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amber,
        border: Border.all(color: ColorConstants.dropDownBorderColor),
        boxShadow: [
          BoxShadow(offset: Offset(0, 0), color: ColorConstants.whiteColor.withOpacity(0.25), spreadRadius: 1, blurRadius: 1),
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
          BodySmallText(
            title: 'NEW NOTIFICATIONS',
            titleColor: ColorConstants.blackColor,
            titleTextAlign: TextAlign.center,
          ).addMarginTop(10),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(ImageConstants.star),
                  6.0.spaceX,
                  BodyMediumText(
                    title: '02:00',
                    titleColor: ColorConstants.notificationTimerColor,
                    titleTextAlign: TextAlign.center,
                  ),
                ],
              ),
              BodySmallText(
                title: '02:04 PM',
                titleColor: ColorConstants.notificationTimeColor,
                titleTextAlign: TextAlign.center,
                fontFamily: FontWeightEnum.w400.toInter,
              ),
            ],
          )
        ],
      ).addMarginXY(marginX: 20, marginY: 10),
    );
  }
}
