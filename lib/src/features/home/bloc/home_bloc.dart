import 'package:animations_package/animations_package.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portifolio/src/features/courses/course_model.dart';
import 'package:portifolio/src/features/courses/course_service.dart';
import 'package:portifolio/src/features/home/bloc/event/home_event.dart';
import 'package:portifolio/src/features/home/bloc/state/home_state.dart';
import 'package:portifolio/src/features/projects/project_service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IProjectService _iProjectService;
  final ICourseService iCourseService;
  List<CourseModel> _courses = [];

  HomeBloc(
      {required IProjectService iProjectService, required this.iCourseService})
      : _iProjectService = iProjectService,
        super(InitialHomeState()) {
    on<ChangeView>(((event, emit) => _handleChangePageEvent(event, emit)));
    on<ChangeColorEvent>(
        ((event, emit) => _handleChangeColorEvent(event: event, emit: emit)));
  }

  Future<void> _handleChangePageEvent(
      ChangeView event, Emitter<HomeState> emit) async {
    switch (event.view) {
      case HomeView.initial:
        emit(InitialHomeState());
        break;
      case HomeView.contacts:
        emit(ContactsHomeState());
        break;
      case HomeView.training:
        emit(TrainingHomeState());
        break;
      case HomeView.timeline:
        await _handleCourseState(emit);
        // emit(TimeLineHomeState());
        break;
      case HomeView.projects:
        _handleProjectState(emit);
        break;
      default:
        break;
    }
  }

  void _handleChangeColorEvent({
    required ChangeColorEvent event,
    required Emitter emit,
  }) {
    emit(InitialHomeState(endColor: event.endColor, title: event.title));
  }

  Future<void> _handleProjectState(Emitter<HomeState> emit) async {
    final projects = await _iProjectService.getAll();
    emit(ProjectsHomeState(projects: projects));
  }

  Future<void> _handleCourseState(Emitter<HomeState> emit) async {
    if (_courses.isEmpty) {
      _courses = await iCourseService.getCourses();
    }

    List<DataSeries> _series = [];
    for (final CourseModel course in _courses) {
      final DataItem startItem = DataItem(timestamp: course.startDate);
      final DataItem endItem = DataItem(timestamp: course.endDate);
      DataSeries dateSerie = DataSeries(
        name: course.title,
        description: course.description,
        items: [startItem, endItem],
        plotType: PlotType.timePeriod,
      );
      _series.add(dateSerie);
    }

    DataCard dataCard = DataCard(
      name: 'Cursos',
      serie: _series,
      startDate: DateTime(2022, 08, 01),
      endDate: DateTime(2024, 02, 01),
    );

    emit(TimeLineHomeState(dataCard: dataCard));
  }
}
