import 'package:flutter/material.dart';

class SlideFadeAnimation extends StatefulWidget {
  final Widget child;

  const SlideFadeAnimation({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SlideFadeAnimationState();
}

class SlideFadeAnimationState extends State<SlideFadeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> _slideTransition;
  late Animation<double> _fadeAnimation;


  @override
  void initState() {
    super.initState();

    animationController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _slideTransition = Tween<Offset>(
      begin: const Offset(0.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideTransition,
        child: widget.child,
        // child: const Icon(Icons.ac_unit_sharp),
      ),
    );
  }
}
