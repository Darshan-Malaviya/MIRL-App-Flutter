import 'package:flutter/material.dart';
//zoom animation to show dialogs
class ZoomInAnimation extends StatefulWidget {

  final Widget child;

  const ZoomInAnimation({Key? key,required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ZoomInAnimationState();
}

class ZoomInAnimationState extends State<ZoomInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: widget.child,
    );
  }
}