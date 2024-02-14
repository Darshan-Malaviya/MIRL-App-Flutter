import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/margin_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/infrastructure/providers/provider_registration.dart';
import 'package:mirl/ui/common/container_widgets/shadow_container.dart';
import 'package:mirl/ui/common/network_image/network_image.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';

class AreaOfExpertiseWidget extends ConsumerStatefulWidget {
  const AreaOfExpertiseWidget({super.key});

  @override
  ConsumerState<AreaOfExpertiseWidget> createState() => _AreaOfExpertiseWidgetState();
}

class _AreaOfExpertiseWidgetState extends ConsumerState<AreaOfExpertiseWidget> {
  @override
  Widget build(BuildContext context) {
    final expertDetailWatch = ref.watch(expertDetailProvider);
    return Column(
      children: [
        expertDetailWatch.userData?.areaOfExpertise?.isNotEmpty ?? false
            ? Align(
                alignment: AlignmentDirectional.centerStart,
                child: TitleMediumText(
                  title: StringConstants.areasExpertise,
                  titleTextAlign: TextAlign.start,
                  titleColor: ColorConstants.blueColor,
                ),
              )
            : SizedBox.shrink(),
        Column(
          children: List.generate(expertDetailWatch.userData?.areaOfExpertise?.length ?? 0, (index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShadowContainer(
                  shadowColor: ColorConstants.blackColor.withOpacity(0.1),
                  offset: Offset(0,2),
                  blurRadius: 2,
                  spreadRadius: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: NetworkImageWidget(
                          boxFit: BoxFit.cover,
                          imageURL: expertDetailWatch.userData?.areaOfExpertise?[index].image ?? '',
                          isNetworkImage: true,
                          height: 60,
                          width: 55,
                        ),
                      ),
                      4.0.spaceY,
                      LabelSmallText(
                        fontSize: 9,
                        title: expertDetailWatch.userData?.areaOfExpertise?[index].name ?? '',
                        maxLine: 2,
                        titleColor: ColorConstants.blackColor,
                        titleTextAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  width: 90,
                  isShadow: true,
                ),
                15.0.spaceX,
                Expanded(
                  child: Wrap(
                      children: List.generate(expertDetailWatch.userData?.areaOfExpertise?[index].topic?.length ?? 0, (i) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 14,right: 4),
                      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 3),
                      child: TitleMediumText(
                        maxLine: 3,
                        title: expertDetailWatch.userData?.areaOfExpertise?[index].topic?[i].name ?? '',
                        fontFamily: FontWeightEnum.w500.toInter,
                        titleTextAlign: TextAlign.center,
                      ),
                      decoration: ShapeDecoration(
                        color: index % 2 == 0 ? ColorConstants.primaryColor.withOpacity(0.40) : ColorConstants.yellowButtonColor.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: [
                          BoxShadow(
                            color: ColorConstants.topicShoeColorColor,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    );
                  })),
                )
              ],
            ).addMarginY(20);
          }),
        ),
      ],
    );
  }
}
