import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/time_extension.dart';

class NewNotificationWidget extends ConsumerStatefulWidget {
  const NewNotificationWidget({super.key});

  @override
  ConsumerState<NewNotificationWidget> createState() => _NewNotificationWidgetState();
}

class _NewNotificationWidgetState extends ConsumerState<NewNotificationWidget> {
  @override
  void initState() {
    super.initState();
    ref.read(notificationProvider).startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final notificationProviderWatch = ref.watch(notificationProvider);
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
                  BodySmallText(
                    title: Duration(seconds: notificationProviderWatch.secondsRemaining).toTimeString(),
                    fontSize: 10,
                  ),
                  // BodyMediumText(
                  //   title: '02:00',
                  //   titleColor: ColorConstants.notificationTimerColor,
                  //   titleTextAlign: TextAlign.center,
                  // ),
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
                                fontSize: 17,
                                titleTextAlign: TextAlign.center,
                              ),
                              InkWell(
                                onTap: () => context.toPop(),
                                child: BodyMediumText(
                                  title: 'Back',
                                  fontFamily: FontWeightEnum.w500.toInter,
                                  titleColor: ColorConstants.bottomTextColor,
                                  fontSize: 17,
                                  titleTextAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ).addPaddingX(10)
                        ],
                      ));
                },
                child: BodySmallText(
                  title: '02:04 PM',
                  titleColor: ColorConstants.notificationTimeColor,
                  titleTextAlign: TextAlign.center,
                  fontFamily: FontWeightEnum.w400.toInter,
                ),
              ),
            ],
          )
        ],
      ).addMarginXY(marginX: 20, marginY: 10),
    );
  }
}
