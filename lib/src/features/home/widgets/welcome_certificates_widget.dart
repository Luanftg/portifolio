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

  @override
  void initState() {
    super.initState();
    _opacity = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.2,
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: ValueListenableBuilder(
        valueListenable: _opacity,
        builder: (
          context,
          value,
          child,
        ) {
          return AnimatedOpacity(
            curve: Curves.easeInCirc,
            opacity: value,
            duration: const Duration(seconds: 1),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Cursos e Certificados'),
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          CourseItemWidget(courseModel: widget.courses[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemCount: widget.courses.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
