import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class AllNotificationTypeNameWidget extends StatelessWidget {
  final String notificationName;
  final bool isSelectedShadow;
  final String imageURL;

  const AllNotificationTypeNameWidget({super.key, required this.notificationName, required this.isSelectedShadow, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShadowContainer(
          shadowColor: isSelectedShadow ? ColorConstants.primaryColor : ColorConstants.disableColor,
          offset: isSelectedShadow ? Offset(0, 1) : Offset(0, 2),
          spreadRadius: isSelectedShadow ? 1 : 0,
          blurRadius: isSelectedShadow ? 8 : 2,
          borderWidth: 1,
          borderColor: ColorConstants.greyLightColor,
          child: Column(
            children: [
              Image.asset(imageURL),
              4.0.spaceY,
              LabelSmallText(
                fontSize: 9,
                title: notificationName,
                titleColor: ColorConstants.blackColor,
                titleTextAlign: TextAlign.center,
                maxLine: 2,
              ),
            ],
          ),
          height: 95,
          width: 95,
          isShadow: true,
        ),
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: CircleAvatar(
            child: TitleMediumText(
              title: '0',
              fontFamily: FontWeightEnum.w600.toInter,
              titleColor: ColorConstants.blackColor,
            ),
            radius: 14,
            backgroundColor: ColorConstants.primaryColor,
          ),
        )
        // ]
      ],
    );
  }
}
