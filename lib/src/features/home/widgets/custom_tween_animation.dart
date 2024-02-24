import 'package:flutter/material.dart';

class CustomTweenAnimation extends StatefulWidget {
  const CustomTweenAnimation(
      {super.key, required this.child, required this.duration});
  final Widget child;
  final Duration duration;

  @override
  State<CustomTweenAnimation> createState() => _CustomTweenAnimationState();
}

class _CustomTweenAnimationState extends State<CustomTweenAnimation> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeInOut,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: child,
      ),
      duration: widget.duration,
    );
  }
}
