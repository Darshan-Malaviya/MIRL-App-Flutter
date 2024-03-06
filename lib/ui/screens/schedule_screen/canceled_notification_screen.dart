import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';

class CanceledNotificationScreen extends StatelessWidget {
  final CancelArgs args;

  const CanceledNotificationScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  title: args.role == 1 ? LocaleKeys.expertHasCanceled.tr() : LocaleKeys.userHasCanceled.tr(),
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
                            text: '${args.role == 1 ? LocaleKeys.expert.tr() : LocaleKeys.user.tr().toUpperCase()}: ',
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
                            text: '${LocaleKeys.date.tr()}: ',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter),
                            children: [
                              TextSpan(
                                  text: '${args.cancelDate?.toLocalFullDateWithoutSuffix() ?? ''}',
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
              PrimaryButton(
                title: LocaleKeys.goTONotification.tr(),
                onPressed: () => context.toPop(),
                fontSize: 15,
              )
            ],
          ).addPaddingX(20),
        ));
  }
}
