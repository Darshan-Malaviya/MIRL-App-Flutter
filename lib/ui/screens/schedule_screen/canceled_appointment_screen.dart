import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class CanceledAppointmentScreen extends ConsumerWidget {
  const CanceledAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleLargeText(
              title: LocaleKeys.appointmentCanceled.tr(),
              titleColor: ColorConstants.bottomTextColor,
              titleTextAlign: TextAlign.center,
            ),
            32.0.spaceY,
            BodyMediumText(
              title: LocaleKeys.expertNotify.tr(),
              titleColor: ColorConstants.buttonTextColor,
            ),
            20.0.spaceY,
            ShadowContainer(
                isShadow: false,
                borderColor: ColorConstants.borderColor,
                backgroundColor: ColorConstants.yellowButtonColor,
                height: 130,
                border: 5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              TextSpan(text: 'PREETI', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
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
                              TextSpan(text: '03:30PM - 03:50PM', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
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
                              TextSpan(text: '20 minutes', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
