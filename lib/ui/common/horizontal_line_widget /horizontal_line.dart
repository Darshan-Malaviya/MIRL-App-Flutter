import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 5.0,
          color: ColorConstants.lineColor,
        )
      ],
    ).addAllPadding(20);
  }
}
