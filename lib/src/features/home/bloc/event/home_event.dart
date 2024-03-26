import 'package:flutter/material.dart';

enum HomeView { training, initial, projects, contacts, timeline, authHomeView }

sealed class HomeEvent {}

class ChangeView implements HomeEvent {
  final HomeView view;

  ChangeView({required this.view});
}

class ChangeColorEvent implements HomeEvent {
  final Color endColor;
  final String title;

  ChangeColorEvent(this.endColor, {this.title = 'Luan Fonseca'});
}
