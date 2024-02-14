import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class CanceledAppointmentScreen extends ConsumerWidget {
  const CanceledAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleWatch = ref.watch(scheduleCallProvider);

    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
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
                title: LocaleKeys.expertNotify.tr(),
                titleColor: ColorConstants.buttonTextColor,
              ),
            ),
            20.0.spaceY,
            ShadowContainer(
              isShadow: false,
              borderColor: ColorConstants.borderColor,
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
                          text: '${LocaleKeys.expert.tr()}: ',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter),
                          children: [
                            TextSpan(
                                text: scheduleWatch.appointmentData?.expertDetail?.expertName ?? '',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
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
                                text:
                                    '${scheduleWatch.appointmentData?.startTime?.to12HourTimeFormat() ?? ''} - ${scheduleWatch.appointmentData?.endTime?.to12HourTimeFormat() ?? ''}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
                          ],
                        ),
                      ),
                      5.0.spaceY,
                      RichText(
                        softWrap: true,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: '${LocaleKeys.duration.tr()}: ',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter),
                          children: [
                            TextSpan(
                                text: ' ${scheduleWatch.appointmentData?.duration.toString()} ${LocaleKeys.minutes.tr()}',
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
                        imageURL:
                            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
              title: 'The reason for cancellation will be listed and written down here.',
              fontFamily: FontWeightEnum.w400.toInter,
              fontStyle: FontStyle.italic,
              maxLine: 10,
              titleColor: ColorConstants.buttonTextColor,
            ),
            20.0.spaceY,
            PrimaryButton(
              title: LocaleKeys.goTONotification.tr(),
              onPressed: () {
                context.toPushNamed(RoutesConstants.notificationScreen);
              },
              fontSize: 15,
            ),
            100.0.spaceY,
            Center(
              child: BodySmallText(
                title: LocaleKeys.refundStatus.tr(),
                titleColor: ColorConstants.buttonTextColor,
              ),
            ),
            10.0.spaceY,
            BodySmallText(
              title: LocaleKeys.refundDescription.tr(),
              fontFamily: FontWeightEnum.w400.toInter,
              titleColor: ColorConstants.buttonTextColor,
              maxLine: 3,
              titleTextAlign: TextAlign.center,
            ),
          ],
        ).addPaddingX(20),
      ),
    );
  }
}
