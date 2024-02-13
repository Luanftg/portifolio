import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:portifolio/src/features/courses/course_model.dart';

abstract class ICourseService {
  Future<List<CourseModel>> getCourses();
}

class CourseService implements ICourseService {
  CourseService._();
  static CourseService get instance => CourseService._();

  @override
  Future<List<CourseModel>> getCourses() async {
    try {
      String conteudoJson = await rootBundle.loadString('assets/db.json');

      Map<String, dynamic> response = json.decode(conteudoJson);

      List<dynamic> list = response['cursos'];

      List<CourseModel> courses =
          list.map((e) => CourseModel.fromMap(e)).toList();

      return courses;
    } catch (e) {
      return [];
    }
  }
}
