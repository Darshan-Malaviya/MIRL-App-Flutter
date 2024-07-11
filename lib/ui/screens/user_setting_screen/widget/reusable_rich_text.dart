import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ReusableRichText extends StatelessWidget {
  final String labelText;
  final String valueText;

  const ReusableRichText({
    Key? key,
    required this.labelText,
    required this.valueText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 13,
          color: ColorConstants.buttonTextColor,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '$labelText',
            style: TextStyle(
              fontFamily: FontWeightEnum.w400.toString(),
            ),
          ),
          TextSpan(
            text: valueText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: FontWeightEnum.w600.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
