import 'dart:typed_data';

import 'package:portifolio/src/features/courses/domain/course_model.dart';

sealed class CourseEvent {}

class FetchCourses extends CourseEvent {
  final int totalItens;
  final int offset;

  FetchCourses({this.totalItens = 20, this.offset = 0});
}

class SaveCourse extends CourseEvent {
  final CourseModel course;
  final Uint8List? titleFile;
  final Uint8List? certificateFile;

  SaveCourse(
      {required this.course,
      required this.titleFile,
      required this.certificateFile});
}
