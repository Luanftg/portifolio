import 'package:flutter/material.dart';
import 'package:portifolio/src/core/layout/mobile/mobile_layout.dart';
import 'package:portifolio/src/features/courses/course_model.dart';
import 'package:portifolio/src/features/courses/course_service.dart';
import 'package:portifolio/src/core/layout/responsive_layout.dart';
import 'package:portifolio/src/features/home/widgets/welcome_card_widget.dart';
import 'package:portifolio/src/features/home/widgets/welcome_certificates_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<double> _opacity = ValueNotifier<double>(0);
  late AnimationController _opacityController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityController.forward();
  }

  @override
  void dispose() {
    _opacityController.dispose();
    _opacity.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _changeOpacity() async {
    _scrollController.animateTo((_opacity.value == 1) ? -500 : 500,
        duration: const Duration(seconds: 2), curve: Curves.easeInOut);
    _opacity.value == 0
        ? await Future.delayed(const Duration(seconds: 1))
        : null;
    _opacity.value = (_opacity.value == 1) ? 0 : 1;
    _opacityController.reset();
    _opacityController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: const MobileLayout(),
      desktop: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, actions: [
          TextButton(onPressed: () {}, child: const Text('Tudo sobre mim')),
          TextButton(onPressed: () {}, child: const Text('Projetos')),
          TextButton(onPressed: () {}, child: const Text('Formação')),
          TextButton(onPressed: () {}, child: const Text('Contato')),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: _changeOpacity, child: const Icon(Icons.person)),
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  height: MediaQuery.sizeOf(context).height * 0.6,
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
          ],
          body: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.2,
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
              FutureBuilder<List<CourseModel>>(
                future: CourseService.instance.getCourses(),
                builder: (context, snapCourses) {
                  switch (snapCourses.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.done:
                    case ConnectionState.active:
                      if (snapCourses.hasData && snapCourses.data != null) {
                        return WelcomeCertificatesWidget(
                          courses: snapCourses.data!,
                        );
                      }
                      return const SizedBox.shrink();
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
