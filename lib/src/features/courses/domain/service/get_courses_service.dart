import 'package:portifolio/src/features/courses/domain/course_model.dart';

abstract class IGetCoursesService {
  Future<List<CourseModel>> getCourses();
}
