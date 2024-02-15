import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class GeneralNotificationWidget extends StatefulWidget {
  final Color? titleColor;
  final Color? bgColor;

  const GeneralNotificationWidget({super.key, this.titleColor, this.bgColor});

  @override
  State<GeneralNotificationWidget> createState() => _GeneralNotificationWidgetState();
}

class _GeneralNotificationWidgetState extends State<GeneralNotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.bgColor ?? ColorConstants.notificationBgColor,
        boxShadow: [
          BoxShadow(offset: Offset(0, 0), color: ColorConstants.blackColor.withOpacity(0.25), spreadRadius: 1, blurRadius: 1),
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
            title: 'EXPERT TIP!',
            titleColor: widget.titleColor ?? ColorConstants.blackColor,
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
        ],
      ).addMarginXY(paddingX: 20, paddingY: 10),
    );
  }
}
