import 'package:flutter/material.dart';
import 'package:portifolio/src/features/home/widgets/welcome_widget.dart';

class WelcomeCardWidget extends StatelessWidget {
  const WelcomeCardWidget({
    super.key,
    required this.animationController,
  });
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipOval(
              child: Image.asset(
                'assets/luan.jpg',
                colorBlendMode: BlendMode.darken,
                height: MediaQuery.sizeOf(context).height * 0.35,
                width: MediaQuery.sizeOf(context).width * 0.4,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: WelcomeWidget(
              animationController: animationController,
            ),
          ),
        ],
      ),
    );
  }
}
