import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class TimeOutWidget extends ConsumerWidget {
  const TimeOutWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        20.0.spaceY,
        PrimaryButton(
          height: 55,
          title: LocaleKeys.callTimeOut.tr(),
          margin: EdgeInsets.symmetric(horizontal: 10),
          fontSize: 15,
          onPressed: () {},
        ),
        10.0.spaceY,
        BodyMediumText(
          title: LocaleKeys.unAbleToTake.tr(),
          fontFamily: FontWeightEnum.w500.toInter,
          titleColor: ColorConstants.buttonTextColor,
          titleTextAlign: TextAlign.center,
        ),
        20.0.spaceY,
        LabelSmallText(
          title: LocaleKeys.yourPaymentRefunded.tr(),
          fontFamily: FontWeightEnum.w500.toInter,
          titleColor: ColorConstants.buttonTextColor,
          titleTextAlign: TextAlign.center,
          fontSize: 10,
        ),
        10.0.spaceY,
        InkWell(
          onTap: () {},
          child: BodyMediumText(
            title: LocaleKeys.checkNotification.tr(),
            fontFamily: FontWeightEnum.w500.toInter,
            titleColor: ColorConstants.primaryColor,
          ),
        ),
      ],
    );
    ;
  }
}
