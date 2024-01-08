import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class MinusButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 20,
        width: 20,
        child: const Icon(
          Icons.remove,
          size: 18,
        ),
        decoration: ShapeDecoration(
          color:ColorConstants.yellowButtonColor,
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
        // decoration: BoxDecoration(
        //   color: ColorConstants.yellowButtonColor,
        //   borderRadius: BorderRadius.all(Radius.circular(4)),
        //   boxShadow: [
        //     BoxShadow(
        //       color: ColorConstants.borderColor,
        //       //spreadRadius: 2,
        //       blurRadius: 2,
        //       offset: Offset(0, 1),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
