import 'package:flutter/material.dart';
import 'package:portifolio/src/features/courses/domain/course_model.dart';
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
  late ValueNotifier<double> _opacity;
  late Map<String, List<CourseModel>> _cursosPorTitulo;

  @override
  void initState() {
    super.initState();
    _opacity = ValueNotifier(0);
    _cursosPorTitulo = _organizeCoursesByTitle();
    _animate();
  }

  Map<String, List<CourseModel>> _organizeCoursesByTitle() {
    Map<String, List<CourseModel>> cursosPorTitulo = {};
    for (var curso in widget.courses) {
      if (cursosPorTitulo.containsKey(curso.title)) {
        cursosPorTitulo[curso.title]!.add(curso);
      } else {
        cursosPorTitulo[curso.title] = [curso];
      }
    }
    return cursosPorTitulo;
  }

  void _animate() async {
    await Future.delayed(const Duration(milliseconds: 800));
    _opacity.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _opacity,
      builder: (context, value, child) {
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
                child: ListView.builder(
                  itemCount: _cursosPorTitulo.length,
                  itemBuilder: (context, index) {
                    String title = _cursosPorTitulo.keys.elementAt(index);
                    List<CourseModel> cursos = _cursosPorTitulo[title]!;
                    return ExpansionTile(
                      title: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          children: [
                            Image.asset(
                              cursos[0].titlePath,
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(width: 8),
                            Text(title),
                          ],
                        ),
                      ),
                      children: cursos
                          .map(
                            (curso) => CourseItemWidget(courseModel: curso),
                          )
                          .toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
