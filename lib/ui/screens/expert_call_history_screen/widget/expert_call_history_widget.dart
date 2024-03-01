import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/call_history_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ExpertCallHistoryWidget extends ConsumerStatefulWidget {
  const ExpertCallHistoryWidget({
    super.key,
  });

  @override
  ConsumerState<ExpertCallHistoryWidget> createState() => _ExpertCallHistoryWidgetState();
}

class _ExpertCallHistoryWidgetState extends ConsumerState<ExpertCallHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: ColorConstants.categoryList,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                    title: '0',
                                    titleColor: ColorConstants.buttonTextColor,
                                    titleTextAlign: TextAlign.center,
                                    fontFamily: FontWeightEnum.w400.toInter,
                                  ),
                                ),
                              ),
                              14.0.spaceX,
                              Container(
                                  alignment: Alignment.center,
                                  decoration: ShapeDecoration(
                                    color: callHistoryEnumNotifier.value.callHistoryTypeNameColor,
                                    shadows: [
                                      BoxShadow(color: Colors.black, blurRadius: 1, spreadRadius: 0),
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 10,
                                        spreadRadius: 8,
                                        offset: Offset(1, 2),
                                      ),
                                    ],
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                        color: Color(0xFFCAC9C9),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30, left: 30, top: 5, bottom: 5),
                                    child: Center(
                                      child: BodySmallText(
                                        title: callHistoryEnumNotifier.value.callHistoryTypeName,
                                        titleColor: ColorConstants.buttonTextColor,
                                        titleTextAlign: TextAlign.center,
                                        fontFamily: FontWeightEnum.w600.toInter,
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          20.0.spaceY,
                          RichText(
                            softWrap: true,
                            text: TextSpan(
                              text: 'User: ',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter, fontSize: 12),
                              children: [
                                WidgetSpan(child: 2.0.spaceX),
                                TextSpan(
                                    text: 'vaidehi',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: ColorConstants.buttonTextColor,
                                        fontFamily: FontWeightEnum.w700.toInter,
                                        fontSize: 12))
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          10.0.spaceY,
                          RichText(
                            text: TextSpan(
                              text: LocaleKeys.feePerMinute.tr(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter, fontSize: 12),
                              children: [
                                WidgetSpan(child: 2.0.spaceX),
                                TextSpan(
                                    text: 'INR 500',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: ColorConstants.buttonTextColor,
                                        fontFamily: FontWeightEnum.w700.toInter,
                                        fontSize: 12))
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          10.0.spaceY,
                          RichText(
                            text: TextSpan(
                              text: LocaleKeys.durationCallHistory.tr(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter, fontSize: 12),
                              children: [
                                WidgetSpan(child: 2.0.spaceX),
                                TextSpan(
                                    text: '20 mins',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: ColorConstants.buttonTextColor,
                                        fontFamily: FontWeightEnum.w700.toInter,
                                        fontSize: 12))
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          10.0.spaceY,
                          RichText(
                            text: TextSpan(
                              text: LocaleKeys.totalPayment.tr(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter, fontSize: 12),
                              children: [
                                WidgetSpan(child: 2.0.spaceX),
                                TextSpan(
                                    text: 'INR 1000',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: ColorConstants.buttonTextColor,
                                        fontFamily: FontWeightEnum.w700.toInter,
                                        fontSize: 12))
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          10.0.spaceY,
                          Column(
                            children: List.generate(3, (index) {
                              return Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: '04:05PM',
                                      style: TextStyle(
                                          fontFamily: FontWeightEnum.w400.toInter,
                                          color: ColorConstants.buttonTextColor,
                                          fontSize: 12),
                                      children: <InlineSpan>[
                                        WidgetSpan(
                                            child: SizedBox(
                                          width: 14,
                                        )),
                                        TextSpan(
                                          text: "callTime",
                                          style: TextStyle(
                                              fontFamily: FontWeightEnum.w400.toInter,
                                              color: ColorConstants.buttonTextColor,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ).addMarginY(6);
                            }),
                          ),
                          10.0.spaceY,
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: LocaleKeys.status.tr(),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: ColorConstants.buttonTextColor,
                                      fontFamily: FontWeightEnum.w400.toInter,
                                      fontSize: 12),
                                  children: [
                                    WidgetSpan(child: 6.0.spaceX),
                                    TextSpan(
                                        text: "call completed".toUpperCase(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: ColorConstants.textGreenColor,
                                            fontFamily: FontWeightEnum.w700.toInter,
                                            fontSize: 12))
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            offset: Offset(2, 4),
                            color: ColorConstants.blackColor.withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 2),
                      ], shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: NetworkImageWidget(
                          imageURL:
                              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          boxFit: BoxFit.cover,
                          height: 75,
                          width: 75,
                        ),
                      ),
                    ),
                  ],
                ),
                18.0.spaceY,
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: BodySmallText(
                    title: LocaleKeys.blockAndReportUser.tr(),
                    fontFamily: FontWeightEnum.w400.toInter,
                    titleTextAlign: TextAlign.end,
                    titleColor: ColorConstants.darkRedColor,
                  ),
                ),
              ],
            ).addMarginXY(marginX: 20, marginY: 20)),
      ],
    );
  }
}
