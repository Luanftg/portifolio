import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:portifolio/src/features/courses/domain/course_model.dart';
import 'package:portifolio/src/features/courses/domain/service/get_courses_service.dart';

class GetLocalCoursesService implements IGetCoursesService {
  GetLocalCoursesService._();
  static GetLocalCoursesService get instance => GetLocalCoursesService._();

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
