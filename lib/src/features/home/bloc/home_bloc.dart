import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portifolio/src/features/home/bloc/event/home_event.dart';
import 'package:portifolio/src/features/home/bloc/state/home_state.dart';
import 'package:portifolio/src/features/projects/project_service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IProjectService _iProjectService;
  HomeBloc({required IProjectService iProjectService})
      : _iProjectService = iProjectService,
        super(InitialHomeState()) {
    on<ChangeView>(((event, emit) => _handleChangePageEvent(event, emit)));
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
      case HomeView.projects:
        _handleProjectState(emit);
        break;
      default:
        break;
    }
  }

  Future<void> _handleProjectState(Emitter<HomeState> emit) async {
    final projects = await _iProjectService.getAll();
    emit(ProjectsHomeState(projects: projects));
  }
}
