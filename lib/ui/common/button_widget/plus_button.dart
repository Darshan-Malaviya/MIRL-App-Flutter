import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class PlusButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  const PlusButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 20,
          width: 20,
          child: Image.asset(ImageConstants.plus),
          decoration: BoxDecoration(
            color: ColorConstants.yellowButtonColor,
            borderRadius: BorderRadius.all(Radius.circular(4)),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.borderColor,
                //spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
