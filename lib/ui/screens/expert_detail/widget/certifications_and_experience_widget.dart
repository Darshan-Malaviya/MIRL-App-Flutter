import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkwell/linkwell.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/margin_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';

class CertificationAndExperienceWidget extends ConsumerStatefulWidget {
  final   List<CertificationData> certification;

  const CertificationAndExperienceWidget({super.key,required this.certification});

  @override
  ConsumerState<CertificationAndExperienceWidget> createState() => _CertificationAndExperienceWidgetState();
}

class _CertificationAndExperienceWidgetState extends ConsumerState<CertificationAndExperienceWidget> {
  @override
  Widget build(BuildContext context) {
    //final expertDetailWatch = ref.watch(expertDetailProvider);
    return Column(
      children: [
        widget.certification.isNotEmpty ?? false
            ? Align(
                alignment: AlignmentDirectional.centerStart,
                child: TitleMediumText(
                  title: StringConstants.certificationsAndExperience,
                  titleTextAlign: TextAlign.start,
                  titleColor: ColorConstants.blueColor,
                ),
              )
            : SizedBox.shrink(),
        Column(
          children: List.generate(widget.certification.length ?? 0, (index) {
            return Column(
              children: [
                30.0.spaceY,
                Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: ColorConstants.certificatedBgColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: ColorConstants.certificatedBorderColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    shadows: [
                      BoxShadow(
                        color: ColorConstants.certificatedBoxShadowColor,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TitleMediumText(
                        title: widget.certification[index].title ?? '',
                        fontFamily: FontWeightEnum.w600.toInter,
                        titleTextAlign: TextAlign.start,
                        titleColor: ColorConstants.blackColor,maxLine: 3,
                      ),
                      8.0.spaceY,
                      LinkWell(widget.certification[index].url ?? '',
                          maxLines: 100,
                          style: TextStyle(
                            color: ColorConstants.blackColor,
                            fontFamily: FontWeightEnum.w400.toInter,
                            fontSize: 14,
                          ),
                          linkStyle: TextStyle(
                            color: ColorConstants.bottomTextColor,
                            fontFamily: FontWeightEnum.w400.toInter,
                            fontSize: 14,
                          )),
                      // TitleSmallText(
                      //   title: expertDetailWatch.userData?.certification?[index].url ?? '',
                      //   fontFamily: FontWeightEnum.w400.toInter,
                      //   titleTextAlign: TextAlign.start,
                      //   titleColor: ColorConstants.bottomTextColor,
                      // ),
                      8.0.spaceY,
                      TitleSmallText(
                        maxLine: 10,
                        title: widget.certification[index].description ?? '',
                        fontFamily: FontWeightEnum.w400.toInter,
                        titleTextAlign: TextAlign.start,
                        titleColor: ColorConstants.blueColor,
                      ),
                    ],
                  ).addMarginXY(marginX: 24, marginY: 18),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
