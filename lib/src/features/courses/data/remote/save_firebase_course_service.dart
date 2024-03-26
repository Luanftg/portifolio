import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portifolio/src/core/constants/firebase_constants.dart';
import 'package:portifolio/src/features/courses/domain/course_model.dart';
import 'package:portifolio/src/features/courses/domain/exceptions/firebase_exception.dart';
import 'package:portifolio/src/features/courses/domain/service/save_course_service.dart';

class SaveFirebaseCourseService implements ISaveCourseService {
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
  final String courseCollection = FireBaseConstants.coursesCollection;
  @override
  Future<void> call(CourseModel course) async {
    try {
      await firebase.collection(courseCollection).add(course.toMap());
    } catch (e) {
      throw CustomFirebaseException(message: e.toString());
    }
  }
}
