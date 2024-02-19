import 'package:extended_image/extended_image.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/loader/three_bounce.dart';

class CircleNetworkImageWidget extends StatelessWidget {
  final String imageURL;
  final BoxFit? boxFit;
  final bool? isNetworkImage;
  final Widget? emptyImageWidget;
  final double? radius;

  const CircleNetworkImageWidget({Key? key, required this.imageURL, this.radius, this.boxFit, this.isNetworkImage = true, this.emptyImageWidget}) : super(key: key);

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
          fit: boxFit,
          cache: false,
          loadStateChanged: (ExtendedImageState state) {
            return switch (state.extendedImageLoadState) {
              LoadState.loading => CircleAvatar(
                  radius: radius ?? 37.5,
                  child: Center(child: SpinKitThreeBounce(color: ColorConstants.primaryColor, size: 20)),
                ),
              LoadState.completed => CircleAvatar(radius: radius ?? 37.5, backgroundImage: NetworkImage(imageURL), backgroundColor: ColorConstants.greyLightColor),
              LoadState.failed => CircleAvatar(radius: radius ?? 37.5, child: Center(child: Icon(Icons.person_2_outlined))),
            };
          },
        );
      } else {
        return ExtendedImage.file(
          File(imageURL),
          key: UniqueKey(),
          fit: boxFit,
          loadStateChanged: (ExtendedImageState state) {
            return switch (state.extendedImageLoadState) {
              LoadState.loading => CircleAvatar(
                  radius: radius ?? 37.5,
                  child: Center(child: SpinKitThreeBounce(color: ColorConstants.primaryColor, size: 20)),
                ),
              LoadState.completed => CircleAvatar(radius: radius ?? 37.5, backgroundImage: FileImage(File(imageURL)), backgroundColor: ColorConstants.greyLightColor),
              LoadState.failed => CircleAvatar(radius: radius ?? 37.5, child: Icon(Icons.person_2_outlined)),
            };
          },
        );
      }
    } else {
      return emptyImageWidget ?? CircleAvatar(radius: radius ?? 37.5, child: Center(child: Icon(Icons.person_2_outlined)));
    }
  }
}
