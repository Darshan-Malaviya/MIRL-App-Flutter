import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ImagePlaceholderContainer extends StatelessWidget {
  final Color? backgroundColor;
  final double? placeholderImageSize;
  final double? height;
  final double? width;
  final double? borderRadius;

  const ImagePlaceholderContainer(
      {Key? key, this.backgroundColor, this.placeholderImageSize, this.height, this.width, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        color: backgroundColor ?? ColorConstants.whiteColor,
      ),
      child: Center(
        child: Icon(
          Icons.person_2_outlined,
          size: placeholderImageSize ?? 40,
        ),
      ),
    );
  }
}
