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
        expertDetailWatch.userData?.areasOfExpertise?.isNotEmpty ?? false
            ? Align(
                alignment: AlignmentDirectional.centerStart,
                child: TitleMediumText(
                  title: StringConstants.areasExpertise,
                  fontFamily: FontWeightEnum.w700.toInter,
                  titleTextAlign: TextAlign.start,
                  titleColor: ColorConstants.blueColor,
                ),
              )
            : SizedBox.shrink(),
        Column(
          children: List.generate(expertDetailWatch.userData?.areasOfExpertise?.length ?? 0, (index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShadowContainer(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: NetworkImageWidget(
                          boxFit: BoxFit.cover,
                          imageURL: expertDetailWatch.userData?.areasOfExpertise?[index].image ?? '',
                          isNetworkImage: true,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      4.0.spaceY,
                      LabelSmallText(
                        fontSize: 9,
                        title: expertDetailWatch.userData?.areasOfExpertise?[index].parentName ?? '',
                        titleColor: ColorConstants.blackColor,
                        fontFamily: FontWeightEnum.w700.toInter,
                        titleTextAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  shadowColor: ColorConstants.blackColor.withOpacity(0.1),
                  height: 90,
                  width: 90,
                ).addMarginY(10),
                15.0.spaceX,
                Container(
                  width: MediaQuery.of(context).size.width - 200,
                  child: Wrap(
                      children: List.generate(expertDetailWatch.userData?.areasOfExpertise?[index].data?.length ?? 0, (i) {
                    return Container(
                      child: TitleSmallText(
                        title: expertDetailWatch.userData?.areasOfExpertise?[index].data?[i].name ?? '',
                        fontFamily: FontWeightEnum.w500.toInter,
                      ).addMarginXY(paddingX: 8, paddingY: 2),
                      decoration: ShapeDecoration(
                        //  color: Color(0x66D97CF0),
                        color: index % 2 == 0 ? Color(0x66D97CF0) : Color(0x66FFCF5A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ).addMarginY(6);
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
