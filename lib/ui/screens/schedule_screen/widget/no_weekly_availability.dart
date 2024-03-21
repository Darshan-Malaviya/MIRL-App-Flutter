import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class NoWeeklyAvailability extends StatelessWidget {
  const NoWeeklyAvailability({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TitleMediumText(title: LocaleKeys.noWeeklyAvailability.tr(), fontSize: 18, titleColor: ColorConstants.bottomTextColor),
        27.0.spaceY,
        Container(
          width: 332,
          decoration: BoxDecoration(
            color: ColorConstants.yellowButtonColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: ColorConstants.dropDownBorderColor),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
              ),
              BoxShadow(
                color: ColorConstants.lightPurpleColor,
                spreadRadius: 0.0,
                blurRadius: 4.0,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BodyMediumText(
                title: LocaleKeys.notScheduleThisWeekAvailability.tr(),
                fontSize: 13,
                titleTextAlign: TextAlign.center,
                titleColor: ColorConstants.buttonTextColor,
              ),
              17.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.canTryOneOfTwoThings.tr(),
                fontSize: 13,
                fontFamily: FontWeightEnum.w400.toInter,
                titleColor: ColorConstants.buttonTextColor,
                titleTextAlign: TextAlign.center,
              ),
              17.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.checkAvailabilityAgain.tr(),
                fontSize: 13,
                fontFamily: FontWeightEnum.w600.toInter,
                titleTextAlign: TextAlign.center,
                titleColor: ColorConstants.buttonTextColor,
              ),
              17.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.or.tr(),
                fontSize: 13,
                fontFamily: FontWeightEnum.w400.toInter,
                titleTextAlign: TextAlign.center,
                titleColor: ColorConstants.buttonTextColor,
              ),
              17.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.useMultipleConnect.tr(),
                fontSize: 13,
                fontFamily: FontWeightEnum.w600.toInter,
                titleTextAlign: TextAlign.center,
                titleColor: ColorConstants.buttonTextColor,
                maxLine: 10,
              )
            ],
          ).addPaddingXY(paddingX: 28, paddingY: 24),
        ),
        124.0.spaceY,
        PrimaryButton(
          title: LocaleKeys.visitMultipleConnect.tr(),
          onPressed: () => context.toPushNamed(RoutesConstants.multiConnectScreen),
          fontSize: 15,
        ).addPaddingXY(paddingX: 30, paddingY: 12),
      ],
    );
  }
}
