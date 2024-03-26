import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portifolio/src/core/constants/firebase_constants.dart';
import 'package:portifolio/src/features/courses/domain/course_model.dart';
import 'package:portifolio/src/features/courses/domain/service/get_courses_service.dart';

class GetFirebaseCoursesService implements IGetCoursesService {
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
  final String courseCollection = FireBaseConstants.coursesCollection;

  @override
  Future<List<CourseModel>> getCourses() async {
    try {
      final response = await firebase.collection(courseCollection).get();
      final docs = response.docs;
      final List<CourseModel> courses =
          docs.map((e) => CourseModel.fromMap(e.data())).toList();
      return courses;
    } catch (e) {
      return [];
    }
  }
}
