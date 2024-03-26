import 'package:flutter_test/flutter_test.dart';
import 'package:portifolio/src/features/courses/data/remote/save_firebase_course_service.dart';
import 'package:portifolio/src/features/courses/domain/course_model.dart';

void main() {
  late SaveFirebaseCourseService saveFirebaseCourseService;

  setUp(() {
    saveFirebaseCourseService = SaveFirebaseCourseService();
  });
  test('Não deve retornar um erro ao salvar um curso', () async {
    final course = CourseModel(
      title: 'title',
      titlePath: 'titlePath',
      description: 'description',
      minister: 'minister',
      institution: 'institution',
      workload: 'workload',
      imagePath: 'imagePath',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 1)),
    );

    expectLater(() => saveFirebaseCourseService(course), completes);
  });
}
