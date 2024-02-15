import 'package:portifolio/src/features/projects/project_model.dart';

sealed class HomeState {}

class InitialHomeState implements HomeState {}

class TrainingHomeState implements HomeState {}

class ProjectsHomeState implements HomeState {
  final List<ProjectModel> projects;

  ProjectsHomeState({required this.projects});
}

class ContactsHomeState implements HomeState {}
