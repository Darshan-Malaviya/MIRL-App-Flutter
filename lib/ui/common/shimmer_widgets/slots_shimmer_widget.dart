import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:shimmer/shimmer.dart';

class SlotsShimmer extends StatelessWidget {
  const SlotsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: ColorConstants.whiteColor
              ),
              child: SizedBox.shrink(),
            ),
            baseColor: ColorConstants.primaryColor.withOpacity(0.25),
            highlightColor: ColorConstants.grayLightColor,
          );
        },
        separatorBuilder: (BuildContext context, int index) => 20.0.spaceX,
        itemCount: 10);
  }
}
