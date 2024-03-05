import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class AllNotificationTypeNameWidget extends ConsumerStatefulWidget {
  final String notificationName;
  final bool isSelectedShadow;
  final String imageURL;

  const AllNotificationTypeNameWidget(
      {super.key, required this.notificationName, required this.isSelectedShadow, required this.imageURL});

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
            shadowColor: widget.isSelectedShadow ? ColorConstants.primaryColor : ColorConstants.disableColor,
            offset: widget.isSelectedShadow ? Offset(0, 1) : Offset(0, 2),
            spreadRadius: widget.isSelectedShadow ? 1 : 0,
            blurRadius: widget.isSelectedShadow ? 8 : 2,
            borderWidth: 1,
            borderColor: ColorConstants.greyLightColor,
            child: Column(
              children: [
                Image.asset(widget.imageURL),
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
            height: 96,
            width: 96,
            isShadow: true,
          ),
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
