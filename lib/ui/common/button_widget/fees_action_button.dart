import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class FeesActionButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String icons;
  final bool isDisable;

  const FeesActionButtonWidget({super.key, required this.onTap, required this.icons, this.isDisable = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OnScaleTap(
        onPress: !isDisable ? onTap : () {},
        child: Container(
          height: 20,
          width: 20,
          child: Image.asset(
            icons,
          ),
          decoration: ShapeDecoration(
            color: isDisable ? ColorConstants.greyLightColor : ColorConstants.yellowButtonColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 2,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
