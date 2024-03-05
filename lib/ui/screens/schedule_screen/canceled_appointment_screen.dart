import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';

class CanceledAppointmentScreen extends ConsumerWidget {
  final CancelArgs args;

  const CanceledAppointmentScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBarWidget(
          preferSize: 40,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.0.spaceY,
              Center(
                child: TitleLargeText(
                  title: LocaleKeys.appointmentCanceled.tr(),
                  titleColor: ColorConstants.bottomTextColor,
                  titleTextAlign: TextAlign.center,
                ),
              ),
              32.0.spaceY,
              Center(
                child: BodyMediumText(
                  title: args.role == 1 ? LocaleKeys.expertNotify.tr() : LocaleKeys.userNotify.tr(),
                  titleColor: ColorConstants.buttonTextColor,
                ),
              ),
              20.0.spaceY,
              ShadowContainer(
                isShadow: false,
                borderColor: ColorConstants.dropDownBorderColor,
                backgroundColor: ColorConstants.yellowButtonColor,
                border: 5,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          softWrap: true,
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '${args.fromScheduled ?? false ? LocaleKeys.expert.tr() : LocaleKeys.user.tr().toUpperCase()}: ',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter),
                            children: [
                              TextSpan(text: args.cancelData?.name ?? 'Anonymous', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
                            ],
                          ),
                        ),
                        5.0.spaceY,
                        RichText(
                          softWrap: true,
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '${LocaleKeys.time.tr()}: ',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter),
                            children: [
                              TextSpan(
                                  text: '${args.cancelData?.startTime?.to12HourTimeFormat() ?? ''} - ${args.cancelData?.endTime?.to12HourTimeFormat() ?? ''}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
                            ],
                          ),
                        ),
                        5.0.spaceY,
                        RichText(
                          softWrap: true,
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '${LocaleKeys.duration.tr().toUpperCase()}: ',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter),
                            children: [
                              TextSpan(
                                  text: '${args.cancelData?.duration.toString()} ${LocaleKeys.minutes.tr()}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(offset: Offset(2, 5), color: ColorConstants.blackColor.withOpacity(0.3), spreadRadius: 2, blurRadius: 2),
                      ], shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: NetworkImageWidget(
                          imageURL: args.cancelData?.profileImage ?? '',
                          boxFit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              16.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.reasonForCanceledAppointment.tr(),
                titleColor: ColorConstants.buttonTextColor,
              ),
              10.0.spaceY,
              BodyMediumText(
                title: args.cancelData?.reason ?? '',
                fontFamily: FontWeightEnum.w400.toInter,
                fontStyle: FontStyle.italic,
                maxLine: 10,
                titleColor: ColorConstants.buttonTextColor,
              ),
              20.0.spaceY,
              if (args.fromScheduled ?? false) ...[
                PrimaryButton(
                  title: LocaleKeys.goTONotification.tr(),
                  onPressed: () => context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 2),
                  fontSize: 15,
                ),
                100.0.spaceY,
                Center(
                  child: BodySmallText(
                    title: LocaleKeys.refundStatus.tr(),
                    titleColor: ColorConstants.buttonTextColor,
                  ),
                ),
                5.0.spaceY,
                BodySmallText(
                  title: LocaleKeys.refundDescription.tr(),
                  fontFamily: FontWeightEnum.w400.toInter,
                  titleColor: ColorConstants.buttonTextColor,
                  maxLine: 3,
                  titleTextAlign: TextAlign.center,
                ).addMarginX(20),
              ] else ...[
                PrimaryButton(
                  title: LocaleKeys.backCalenderAppointment.tr(),
                  onPressed: () {
                    context.toPop();
                    context.toPop();
                    context.toPushReplacementNamed(RoutesConstants.viewCalendarAppointment, args: AppointmentArgs(role: args.role ?? 1));
                  },
                  fontSize: 15,
                  titleColor: ColorConstants.textColor,
                ),
                30.0.spaceY,
                Center(
                  child: InkWell(
                    onTap: () => context.toPushNamed(RoutesConstants.blockUserScreen,
                        args: BlockUserArgs(
                          userName: args.cancelData?.name ?? 'Anonymous',
                          imageURL: args.cancelData?.profileImage ?? '',
                          userId: args.cancelData?.id,
                          userRole: 2,
                          reportName: '',
                        )),
                    child: BodySmallText(
                      title: LocaleKeys.blockedUser.tr(),
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleColor: ColorConstants.callsPausedColor,
                      titleTextAlign: TextAlign.center,
                    ),
                  ),
                ),
              ]
            ],
          ).addPaddingX(20),
        ),
      ),
    );
  }
}
