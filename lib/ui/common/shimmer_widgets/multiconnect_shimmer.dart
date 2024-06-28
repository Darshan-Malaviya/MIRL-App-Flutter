import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:shimmer/shimmer.dart';

class MultiConnectShimmerWidget extends StatelessWidget {
  const MultiConnectShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.7),
        itemBuilder: (BuildContext context, int index) {
          return ShadowContainer(
            shadowColor: ColorConstants.blackColor.withOpacity(0.1),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Shimmer.fromColors(
                baseColor: ColorConstants.whiteColor,
                highlightColor: ColorConstants.greyLightColor,
                child: ShadowContainer(
                  height: 70,
                  width: 60,
                  isShadow: false,
                  border: 30,
                  child: Container(),
                ),
              ),
            ),
            width: 90,
            isShadow: true,
          );
        },
      ),
    );
  }
}
