import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class AllNotificationTypeNameWidget extends ConsumerStatefulWidget {
  final String notificationName;

  // final int index;
  final bool isSelectedShadow;

  const AllNotificationTypeNameWidget({super.key, required this.notificationName, required this.isSelectedShadow});

  @override
  ConsumerState<AllNotificationTypeNameWidget> createState() => _AllNotificationTypeNameWidgetState();
}

class _AllNotificationTypeNameWidgetState extends ConsumerState<AllNotificationTypeNameWidget> {
  @override
  Widget build(BuildContext context) {
    final notificationProviderWatch = ref.watch(notificationProvider);
    final notificationProviderRead = ref.read(notificationProvider);

    return Stack(
      children: [
        InkWell(
          child: ShadowContainer(
            shadowColor: widget.isSelectedShadow ? ColorConstants.primaryColor : ColorConstants.blackColor.withOpacity(0.25),
            offset: widget.isSelectedShadow ? Offset(0, 1) : Offset(0, 0),
            spreadRadius: widget.isSelectedShadow ? 1 : 0,
            blurRadius: widget.isSelectedShadow ? 8 : 2,
            borderWidth: 1,
            borderColor: ColorConstants.greyLightColor,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: NetworkImageWidget(
                    boxFit: BoxFit.cover,
                    imageURL: ImageConstants.iconPath,
                    isNetworkImage: true,
                    height: 50,
                    width: 50,
                  ),
                ),
                4.0.spaceY,
                LabelSmallText(
                  fontSize: 9,
                  title: widget.notificationName,
                  titleColor: ColorConstants.blackColor,
                  titleTextAlign: TextAlign.center,
                  maxLine: 2,
                ),
              ],
            ),
            height: 100,
            width: 100,
            isShadow: true,
          ).addPaddingTop(5),
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
