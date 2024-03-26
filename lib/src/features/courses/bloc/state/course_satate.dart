import 'package:portifolio/src/features/courses/domain/course_model.dart';

sealed class CourseState {}

class InitialCourseState extends CourseState {
  final List<CourseModel> courses;

  InitialCourseState({this.courses = const []});
}

class LoadingCourseState extends CourseState {}

class LoadedCourseState extends CourseState {
  final List<CourseModel> courses;

  LoadedCourseState({required this.courses});
}

class ErrorCourseState extends CourseState {
  final String message;

  ErrorCourseState({required this.message});
}

class SavedCourseState extends CourseState {
  final String message;

  SavedCourseState({this.message = 'Curso salvo com sucesso!'});
}
