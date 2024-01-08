import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';

class ShadowContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? border;
  final Color? backgroundColor;
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final bool? isShadow;
  final Color? borderColor;

  const ShadowContainer({
    Key? key,
    this.height,
    this.width,
    this.border,
    this.backgroundColor,
    required this.child,
    this.padding,
    this.alignment,
    this.margin,
    this.isShadow = true,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      //Column(
     // children: [
        Container(
          alignment: alignment,
          margin: margin,
          height: height,
          width: width,
          padding: padding ?? const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(border ?? 20),
            color: backgroundColor ?? ColorConstants.whiteColor,
            boxShadow: (isShadow ?? false)
                ? [
                    BoxShadow(
                        color: ColorConstants.categoryListBorder, blurRadius: 8, spreadRadius: 1, offset: const Offset(0, 0))
                  ]
                : [],
          ),
          child: child,
        );
       // 30.0.spaceY,
        // Container(
        //     height: 150,
        //     width: double.infinity,
        //     color: ColorConstants.categoryList,
        //     child: Column(
        //       children: [
        //         20.0.spaceY,
        //         Container(constraints: BoxConstraints(
        //           maxWidth: 150
        //         ),
        //           decoration: ShapeDecoration(
        //             color: Colors.white,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(10),
        //             ),
        //             shadows: [
        //               BoxShadow(
        //                 color: Color(0x19000000),
        //                 blurRadius: 2,
        //                 offset: Offset(0, 2),
        //                 spreadRadius: 0,
        //               )
        //             ],
        //           ),
        //           child: Align(alignment: AlignmentDirectional.center, child: TitleSmallText(
        //             title: "Buddy - All Topics",
        //             titleColor: ColorConstants.bottomTextColor,
        //             fontFamily: FontWeightEnum.w700.toInter,
        //           ),),
        //         )
        //       ],
        //     ))
     // ],
 //   );
  }
}
