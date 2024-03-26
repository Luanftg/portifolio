import 'package:portifolio/src/features/courses/domain/course_model.dart';

abstract class ISaveCourseService {
  Future<void> call(CourseModel course);
}
