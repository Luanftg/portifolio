import 'package:flutter/material.dart';
import 'package:portifolio/src/features/courses/course_model.dart';

class CourseItemWidget extends StatelessWidget {
  const CourseItemWidget({
    super.key,
    required this.courseModel,
  });
  final CourseModel courseModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              courseModel.imagePath,
              height: 300,
            ),
            const SizedBox(height: 8),
            Text('Titulo: ${courseModel.title}'),
            Text('Descrição: ${courseModel.description}'),
            Text('Orientador: ${courseModel.minister}'),
            Text('Carga Horária: ${courseModel.workload}'),
            Text('Instituição: ${courseModel.institution}'),
          ],
        ),
      ),
    );
  }
}
