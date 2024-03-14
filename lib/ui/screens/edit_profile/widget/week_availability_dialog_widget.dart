import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class WeekAvailabilityDialog extends StatelessWidget {
  final String icon;
  final String description;

  const WeekAvailabilityDialog({super.key, required this.icon, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          icon,
          height: 50,
          width: 50,
          color: ColorConstants.primaryColor,
        ),
        20.0.spaceY,
        BodyMediumText(
          title: description,
          maxLine: 5,
          //fontFamily: FontWeightEnum.w400.toInter,
          titleTextAlign: TextAlign.center,
        ),
        10.0.spaceY,
        BodyMediumText(title: 'Would you like to change?')
      ],
    );
  }
}
