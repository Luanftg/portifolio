import 'package:animations_package/animations_package.dart';
import 'package:flutter/material.dart';
import 'package:portifolio/src/features/projects/project_model.dart';

sealed class HomeState {}

class InitialHomeState implements HomeState {
  final Color endColor;
  final String title;

  InitialHomeState(
      {this.endColor = Colors.white70, this.title = 'Luan Fonseca'});
}

class TrainingHomeState implements HomeState {}

class ProjectsHomeState implements HomeState {
  final List<ProjectModel> projects;

  ProjectsHomeState({required this.projects});
}

class ContactsHomeState implements HomeState {}

class TimeLineHomeState implements HomeState {
  final DataCard dataCard;

  TimeLineHomeState({required this.dataCard});
}

class AuthenticationHomeState implements HomeState {}
