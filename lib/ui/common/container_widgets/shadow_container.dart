import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

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
  final Color? shadowColor;
  final Offset? offset;

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
    this.shadowColor,
    this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: alignment,
          margin: margin,
          height: height,
          width: width,
          padding: padding ?? const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(border ?? 20),
            border: Border.all(color: borderColor ?? ColorConstants.transparentColor),
            color: backgroundColor ?? ColorConstants.whiteColor,
            boxShadow:
                (isShadow ?? false) ? [BoxShadow(color: shadowColor ?? ColorConstants.categoryListBorder, blurRadius: 6, offset: offset ?? Offset(0, 0), spreadRadius: -1)] : [],
          ),
          child: child,
        )
      ],
    );
  }
}
