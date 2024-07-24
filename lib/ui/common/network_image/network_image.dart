import 'package:extended_image/extended_image.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/loader/three_bounce.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageURL;
  final double? borderRadiusTopLeft;
  final double? borderRadiusBottomLeft;
  final double? borderRadiusBottomRight;
  final double? borderRadiusTopRight;
  final double? borderRadiusAll;
  final double? height;
  final double? width;
  final Color? errorImageColor;
  final double? placeholderImageSize;
  final BoxFit? boxFit;
  final bool? isNetworkImage;
  final Widget? emptyImageWidget;

  const NetworkImageWidget(
      {Key? key,
      required this.imageURL,
      this.borderRadiusTopLeft,
      this.borderRadiusBottomLeft,
      this.borderRadiusBottomRight,
      this.borderRadiusTopRight,
      this.borderRadiusAll,
      this.height,
      this.width,
      this.errorImageColor,
      this.placeholderImageSize,
      this.boxFit,
      this.isNetworkImage = true,
      this.emptyImageWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildChild(context);
  }

  Widget buildChild(BuildContext context) {
    if (imageURL.isNotEmpty) {
      if (isNetworkImage ?? false) {
        return ExtendedImage.network(
          imageURL,
          key: UniqueKey(),
          width: width,
          height: height,
          fit: boxFit,
          cache: true,
          loadStateChanged: (ExtendedImageState state) {
            return switch (state.extendedImageLoadState) {
              LoadState.loading => SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: SpinKitThreeBounce(color: ColorConstants.primaryColor, size: 20)),
                ),
              LoadState.completed => null,
              LoadState.failed => emptyImageWidget ?? Icon(Icons.person_2_outlined),
            };
          },
        );
      } else {
        return ExtendedImage.file(
          File(imageURL),
          key: UniqueKey(),
          width: width,
          height: height,
          fit: boxFit,
          loadStateChanged: (ExtendedImageState state) {
            return switch (state.extendedImageLoadState) {
              LoadState.loading => SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: SpinKitThreeBounce(color: ColorConstants.scaffoldColor, size: 28)),
                ),
              LoadState.completed => null,
              LoadState.failed => emptyImageWidget ?? Icon(Icons.person_2_outlined),
            };
          },
        );
      }
    } else {
      return emptyImageWidget ??
          SizedBox(
            height: height ?? 0,
            width: width ?? 80,
            child: Center(child: Icon(Icons.person_2_outlined)),
          );
    }
  }
}
