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
        TitleMediumText(
            title: LocaleKeys.noWeeklyAvailability.tr(),
            fontSize: 18,
            fontWeight: FontWeight.w700,
            titleColor: ColorConstants.bottomTextColor),
        27.0.spaceY,
        Container(
          width: 332,
          decoration: BoxDecoration(
              color: ColorConstants.scheduleCallColor,
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
            ],),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BodyMediumText(
                title: LocaleKeys.notScheduleThisWeekAvailability.tr(),
                fontSize: 13,
                fontWeight: FontWeight.w700,
                titleTextAlign: TextAlign.center,
              ),
              17.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.canTryOneOfTwoThings.tr(),
                fontSize: 13,
                fontWeight: FontWeight.w300,
                titleTextAlign: TextAlign.center,
              ),
              17.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.checkAvailabilityAgain.tr(),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                titleTextAlign: TextAlign.center,
              ),
              17.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.or.tr(),
                fontSize: 13,
                fontWeight: FontWeight.w300,
                titleTextAlign: TextAlign.center,
              ),
              17.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.useMultipleConnect.tr(),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                titleTextAlign: TextAlign.center,
                maxLine: 5,
              )
            ],
          ).addPaddingXY(paddingX: 28, paddingY: 24),
        ),
        124.0.spaceY,
        PrimaryButton(
          title: LocaleKeys.visitMultipleConnect.tr(),
          onPressed: () {},
          titleColor: ColorConstants.blueColor,
        ).addPaddingXY(paddingX: 29, paddingY: 12),
      ],
    );
  }
}
