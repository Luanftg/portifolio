import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:portifolio/src/features/home/widgets/welcome_card_widget.dart';

class InitialHomeView extends StatefulWidget {
  const InitialHomeView({super.key});

  @override
  State<InitialHomeView> createState() => _InitialHomeViewState();
}

class _InitialHomeViewState extends State<InitialHomeView>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<double> _opacity = ValueNotifier<double>(0);
  late AnimationController _opacityController;
  late ScrollController _scrollController;
  double _previousScrolOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityController.forward();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _opacityController.dispose();
    _opacity.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_opacity.value == 1 &&
        _scrollController.offset < _previousScrolOffset) {
      _opacity.value = 0;
      _opacityController.reset();
      _opacityController.forward();
    } else if (_opacity.value == 0) {
      _opacity.value = 1;
    }
    _previousScrolOffset = _scrollController.offset;
  }

  void _changeOpacity() async {
    final direction = (_opacity.value == 1)
        ? ScrollDirection.reverse
        : ScrollDirection.forward;
    final scrollAnimation = _scrollController.animateTo(
      500,
      duration: const Duration(seconds: 2),
      curve:
          direction == ScrollDirection.reverse ? Curves.easeIn : Curves.easeOut,
    );
    final fadeAnimation = _opacityController.forward();

    scrollAnimation.whenComplete(() => fadeAnimation.catchError((_) => null));
    fadeAnimation.whenComplete(() => scrollAnimation.catchError((_) => null));

    _opacity.value = (_opacity.value == 1) ? 0 : 1;
    _opacityController.reset();
    _opacityController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: InkWell(
            onTap: _changeOpacity,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                backgroundBlendMode: BlendMode.lighten,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white70, width: 0.5),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Luan Fonseca',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.italic,
                      fontSize: 64,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              child: ValueListenableBuilder(
                valueListenable: _opacity,
                builder: (
                  context,
                  opacity,
                  child,
                ) {
                  return AnimatedOpacity(
                    curve: Curves.easeInCirc,
                    opacity: opacity,
                    duration: const Duration(seconds: 1),
                    child: WelcomeCardWidget(
                      animationController: _opacityController,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
