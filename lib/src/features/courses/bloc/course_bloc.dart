import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portifolio/src/core/constants/firebase_constants.dart';
import 'package:portifolio/src/core/services/file_picker_service.dart';
import 'package:portifolio/src/core/services/upload_file/upload_file_service.dart';

import 'package:portifolio/src/features/courses/bloc/event/course_event.dart';
import 'package:portifolio/src/features/courses/bloc/state/course_satate.dart';
import 'package:portifolio/src/features/courses/domain/service/get_courses_service.dart';
import 'package:portifolio/src/features/courses/domain/service/save_course_service.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc(
    super.initialState, {
    required ISaveCourseService iSaveCourseService,
    required IGetCoursesService iGetCoursesService,
    required FilePickerService filePickerService,
    required UploadFileService uploadFileService,
  }) {
    _iSaveCourseService = iSaveCourseService;
    _iGetCoursesService = iGetCoursesService;
    _filePickerService = filePickerService;
    _uploadFileService = uploadFileService;
    _mapEvents();
  }

  late final ISaveCourseService _iSaveCourseService;
  late final IGetCoursesService _iGetCoursesService;
  late final FilePickerService _filePickerService;
  late final UploadFileService _uploadFileService;

  FilePickerService get filePickerService => _filePickerService;
  UploadFileService get uploadFileService => _uploadFileService;

  void _mapEvents() {
    on<FetchCourses>((event, emit) => _handleFetchCourses(event, emit));
    on<SaveCourse>((event, emit) => _handleSaveCourse(event, emit));
  }

  _handleFetchCourses(FetchCourses event, Emitter<CourseState> emit) async {
    try {
      emit(LoadingCourseState());
      final courses = await _iGetCoursesService.getCourses();
      emit(LoadedCourseState(courses: courses));
    } catch (e) {
      emit(ErrorCourseState(message: e.toString()));
    }
  }

  _handleSaveCourse(SaveCourse event, Emitter<CourseState> emit) async {
    try {
      emit(LoadingCourseState());
      final course = event.course;
      await _iSaveCourseService.call(course);
      if (event.certificateFile != null) {
        await _uploadFileService.call(
          fileName: '${event.course.title} - ${event.course.titlePath}',
          fileBytes: event.certificateFile!,
          bucketName: FireBaseConstants.coursesStorage,
        );
      }
      if (event.titleFile != null) {
        await _uploadFileService.call(
          fileName: '${event.course.title} - ${event.course.imagePath}',
          fileBytes: event.titleFile!,
          bucketName: FireBaseConstants.coursesStorage,
        );
      }
      emit(SavedCourseState());
    } catch (e) {
      emit(ErrorCourseState(message: e.toString()));
    }
  }
}
