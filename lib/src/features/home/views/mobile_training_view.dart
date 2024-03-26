import 'package:flutter/material.dart';
import 'package:portifolio/src/features/courses/data/local/get_local_courses_service.dart';
import 'package:portifolio/src/features/courses/domain/course_model.dart';
import 'package:portifolio/src/features/home/widgets/welcome_certificates_widget.dart';

class MobileTrainingView extends StatefulWidget {
  const MobileTrainingView({super.key});

  @override
  State<MobileTrainingView> createState() => _MobileTrainingViewState();
}

class _MobileTrainingViewState extends State<MobileTrainingView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CourseModel>>(
      future: GetLocalCoursesService.instance.getCourses(),
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
              return Center(
                child: WelcomeCertificatesWidget(
                  courses: snapCourses.data!,
                ),
              );
            }
            return const SizedBox.shrink();
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
