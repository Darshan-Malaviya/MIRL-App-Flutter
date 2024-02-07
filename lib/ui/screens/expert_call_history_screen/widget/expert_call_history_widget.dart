import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/network_image/circle_netwrok_image.dart';

class ExpertCallHistoryWidget extends StatelessWidget {
  final String userTitle;
  final String? minutes;
  final String? callTime;
  final String callTitle;
  final String? durationTime;
  final String number;
  final String? status;

  final Color? statusColor;

  const ExpertCallHistoryWidget(
      {super.key,
      required this.userTitle,
      this.minutes,
      this.callTime,
      this.durationTime,
      this.status,
      this.statusColor,
      required this.callTitle,
      required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: ColorConstants.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0xffDDDDDD),
                  blurRadius: 6.0,
                  spreadRadius: 2.0,
                  offset: Offset(0.0, 0.0),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: ColorConstants.yellowButtonColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorConstants.dropDownBorderColor,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Center(
                                child: BodySmallText(
                                  title: number,
                                  titleColor: ColorConstants.buttonTextColor,
                                  titleTextAlign: TextAlign.center,
                                  fontFamily: FontWeightEnum.w400.toInter,
                                ),
                              ),
                            ),
                            14.0.spaceX,
                            ShadowContainer(
                                shadowColor: ColorConstants.dropDownBorderColor,
                                height: 25,
                                padding: EdgeInsets.zero,
                                // decoration: ShapeDecoration(
                                //   color: ColorConstants.greenColor,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(20),
                                //   ),
                                //   shadows: [
                                //     BoxShadow(
                                //       color: ColorConstants.dropDownBorderColor,
                                //       blurRadius: 5,
                                //       offset: Offset(1, 2),
                                //       spreadRadius: 0,
                                //     )
                                //   ],
                                // ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 40, left: 40),
                                  child: Center(
                                    child: BodySmallText(
                                      title: callTitle,
                                      titleColor: ColorConstants.buttonTextColor,
                                      titleTextAlign: TextAlign.center,
                                      fontFamily: FontWeightEnum.w600.toInter,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        20.0.spaceY,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(fontSize: 12),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'User: ',
                                      style: TextStyle(
                                        color: ColorConstants.buttonTextColor,
                                        fontFamily: FontWeightEnum.w400.toInter,
                                      )),
                                  TextSpan(
                                      text: userTitle,
                                      style: TextStyle(
                                        color: ColorConstants.buttonTextColor,
                                        fontFamily: FontWeightEnum.w700.toInter,
                                      ))
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        14.0.spaceY,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(fontSize: 12),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'DURATION: ',
                                      style: TextStyle(
                                        color: ColorConstants.buttonTextColor,
                                        fontFamily: FontWeightEnum.w400.toInter,
                                      )),
                                  TextSpan(
                                      text: durationTime,
                                      style: TextStyle(
                                        color: ColorConstants.buttonTextColor,
                                        fontFamily: FontWeightEnum.w700.toInter,
                                      ))
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        6.0.spaceY,
                        Column(
                          children: List.generate(3, (index) {
                            return Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: minutes,
                                    style: TextStyle(
                                        fontFamily: FontWeightEnum.w400.toInter,
                                        color: ColorConstants.buttonTextColor,
                                        fontSize: 12),
                                    children: <InlineSpan>[
                                      WidgetSpan(
                                          child: SizedBox(
                                        width: 20,
                                      )),
                                      TextSpan(
                                        text: callTime,
                                        style: TextStyle(
                                            fontFamily: FontWeightEnum.w400.toInter,
                                            color: ColorConstants.buttonTextColor,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ).addMarginY(4);
                          }),
                        ),
                        6.0.spaceY,
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'STATUS: ',
                                style: TextStyle(
                                    color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter, fontSize: 12),
                                children: <InlineSpan>[
                                  WidgetSpan(child: SizedBox(width: 20)),
                                  TextSpan(
                                      text: status,
                                      style: TextStyle(
                                        color: statusColor ?? ColorConstants.textGreenColor,
                                        fontFamily: FontWeightEnum.w700.toInter,
                                      ))
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    )),
                    Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.yellowButtonColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstants.dropDownBorderColor,
                              blurRadius: 2,
                              offset: Offset(2, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: CircleNetworkImageWidget(
                            imageURL: ImageConstants.expert, radius: 30, isNetworkImage: true, key: UniqueKey())),
                    //Image.asset(ImageConstants.expert,height: 70,width: 70,)
                  ],
                ),
                18.0.spaceY,
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: BodySmallText(
                    title: "Block / Report User",
                    fontFamily: FontWeightEnum.w400.toInter,
                    titleTextAlign: TextAlign.end,
                    titleColor: ColorConstants.redColor,
                  ),
                ),
              ],
            ).addMarginXY(paddingX: 14, paddingY: 18)),
      ],
    );
  }
}
