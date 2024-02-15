import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class UserOlderNotificationWidget extends StatefulWidget {
  const UserOlderNotificationWidget({super.key});

  @override
  State<UserOlderNotificationWidget> createState() => _UserOlderNotificationWidgetState();
}

class _UserOlderNotificationWidgetState extends State<UserOlderNotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Stack(
        children: [
          Container(
            color: Colors.amber,
            padding: EdgeInsets.only(left: 10),
            child: BodySmallText(
              title: 'NEW NOTIFICATIONS',
              titleColor: ColorConstants.blackColor,
              titleTextAlign: TextAlign.center,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
        ],
      ),
    );
  }
}
