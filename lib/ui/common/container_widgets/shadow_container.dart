import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ShadowContainer extends StatefulWidget {
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
  State<ShadowContainer> createState() => _ShadowContainerState();
}

class _ShadowContainerState extends State<ShadowContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: widget.alignment,
        margin: widget.margin,
        height: widget.height,
        width: widget.width,
        padding: widget.padding ?? const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.border ?? 20),
          color: widget.backgroundColor ?? ColorConstants.whiteColor,
          boxShadow: (widget.isShadow ?? false)
              ? [BoxShadow(color: ColorConstants.categoryListBorder, blurRadius: 8, spreadRadius: 1, offset: const Offset(0, 0))]
              : [],
        ),
        child: widget.child,
      )
    ]);
  }
}
