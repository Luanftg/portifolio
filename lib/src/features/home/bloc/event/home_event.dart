enum HomeView { training, initial, projects, contacts }

sealed class HomeEvent {}

class ChangeView implements HomeEvent {
  final HomeView view;

  ChangeView({required this.view});
}
