import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portifolio/src/features/courses/course_model.dart';
import 'package:portifolio/src/features/courses/course_service.dart';

class CourseFirebaseService implements ICourseService {
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
  final String courseCollection = 'courses';

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
