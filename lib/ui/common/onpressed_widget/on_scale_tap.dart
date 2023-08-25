import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_may_2023/ui/common/animations/scale_tap_animation.dart';

class OnScaleTap extends StatelessWidget {
  final Widget child;
  final VoidCallback onPress;
  final VoidCallback? onLongPress;

  const OnScaleTap({super.key, required this.child, required this.onPress, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ScaleTap(onPressed: onPress, onLongPress: onLongPress, duration: const Duration(milliseconds: 100), child: child);
  }
}
