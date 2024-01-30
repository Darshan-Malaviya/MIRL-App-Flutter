import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ExpertDetail extends StatelessWidget {
  const ExpertDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      shadowColor: ColorConstants.borderColor,
      offset: Offset(2, 2),
      border: 15,
      child: Column(
        children: [
          Stack(
            children: [
              NetworkImageWidget(
                imageURL: 'https://via.placeholder.com/304x239',
                isNetworkImage: true,
                boxFit: BoxFit.cover,
              ),
            ],
          ),
          10.0.spaceY,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BodySmallText(
                    title: StringConstants.overallRatting,
                    fontFamily: FontWeightEnum.w400.toInter,
                  ),
                  HeadlineLargeText(title: '9', titleColor: ColorConstants.bottomTextColor)
                ],
              ),
              Row(
                children: [
                  BodySmallText(
                    title: StringConstants.overallRatting,
                    fontFamily: FontWeightEnum.w400.toInter,
                  ),
                  HeadlineLargeText(title: '9', titleColor: ColorConstants.bottomTextColor)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
