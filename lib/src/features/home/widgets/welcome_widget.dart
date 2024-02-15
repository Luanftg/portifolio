import 'package:flutter/material.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({
    super.key,
    required AnimationController animationController,
  }) : _animationController = animationController;

  final AnimationController _animationController;

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _textAnimationController;
  late Animation<double> _animation;
  final String _animatedText =
      ', desenvolvedor Flutter com foco no segmento mobile, engenheiro civil de formação e estudante de tecnologias voltadas ao desenvolvimento de softwares.';

  @override
  void initState() {
    super.initState();
    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animation =
        Tween<double>(begin: 0, end: _animatedText.length.toDouble()).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    widget._animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _textAnimationController.reset();
        _textAnimationController.forward();
      }
    });

    widget._animationController.addListener(() async {
      // await Future.delayed(const Duration(seconds: 2));
      if (widget._animationController.value == 0) {
        _textAnimationController.reset();
      }
    });
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final int substringIndex = _animation.value.round();
        final displayedText = substringIndex > _animatedText.length
            ? _animatedText
            : _animatedText.substring(0, substringIndex);
        return Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Luan Fonseca',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: displayedText,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
          textAlign: TextAlign.justify,
        );
      },
    );
  }
}
