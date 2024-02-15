import 'package:flutter/material.dart';
import 'package:portifolio/src/features/courses/course_model.dart';
import 'package:portifolio/src/features/courses/widgets/course_item_widget.dart';

class WelcomeCertificatesWidget extends StatefulWidget {
  const WelcomeCertificatesWidget({
    super.key,
    required this.courses,
  });
  final List<CourseModel> courses;
  @override
  State<WelcomeCertificatesWidget> createState() =>
      _WelcomeCertificatesWidgetState();
}

class _WelcomeCertificatesWidgetState extends State<WelcomeCertificatesWidget> {
  late ValueNotifier _opacity;
  final Set<String> _coursesType = {};

  @override
  void initState() {
    super.initState();
    _opacity = ValueNotifier(0);
    for (var element in widget.courses) {
      _coursesType.add(element.title);
    }
    _animate();
  }

  void _animate() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _opacity.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _opacity,
      builder: (
        context,
        value,
        child,
      ) {
        return AnimatedOpacity(
          curve: Curves.easeInOutSine,
          opacity: value,
          duration: const Duration(seconds: 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Cursos e Certificados',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ExpansionTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Image.asset(
                          'assets/certificates/c#/c-sharp.png',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 16),
                        Text(widget.courses[index].title)
                      ]),
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => CourseItemWidget(
                          courseModel: widget.courses[index],
                        ),
                        itemCount: widget.courses.length,
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: _coursesType.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
