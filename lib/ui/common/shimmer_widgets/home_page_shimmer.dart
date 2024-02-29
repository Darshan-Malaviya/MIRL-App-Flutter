import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/container_widgets/image_place_holder_widget.dart';
import 'package:shimmer/shimmer.dart';

class CategoryListShimmerWidget extends StatelessWidget {
  const CategoryListShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height : 120,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.7),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              4.0.spaceY,
              ShadowContainer(
                shadowColor: ColorConstants.blackColor.withOpacity(0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child:  Shimmer.fromColors(
                        baseColor: ColorConstants.whiteColor,
                        highlightColor: ColorConstants.greyLightColor,
                        child: const ShadowContainer(
                          height: 60,
                          width: 50,
                          isShadow: false,
                          border: 30,
                          child:
                          ImagePlaceholderContainer(height: 50, width: 50, borderRadius: 50, placeholderImageSize: 50),
                        ),
                      ),
                    ),
                    4.0.spaceY,
                  ],
                ),
                width: 90,
                isShadow: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
