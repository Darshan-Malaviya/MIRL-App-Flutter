import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:shimmer/shimmer.dart';

class AvailableTimeShimmer extends StatelessWidget {
  const AvailableTimeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        7,
        (index) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Shimmer.fromColors(
                child: Container(
                  height: 30,
                  width: 130,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: ColorConstants.whiteColor),
                  child: SizedBox.shrink(),
                ),
                baseColor: ColorConstants.primaryColor.withOpacity(0.25),
                highlightColor: ColorConstants.greyLightColor,
              ),
            ),
            10.0.spaceX,
            Expanded(
              child: Shimmer.fromColors(
                child: Container(
                  height: 30,
                  width: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: ColorConstants.whiteColor),
                  child: SizedBox.shrink(),
                ),
                baseColor: ColorConstants.primaryColor.withOpacity(0.25),
                highlightColor: ColorConstants.greyLightColor,
              ),
            ),
          ],
        ).addMarginY(10),
      ),
    );
  }
}
