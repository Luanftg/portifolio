sealed class AuthState {}

class UnloggedState implements AuthState {
  final bool isLoading;

  UnloggedState({this.isLoading = false});

  UnloggedState copyWith({
    bool? isLoading,
  }) {
    return UnloggedState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LoggedState implements AuthState {}

class ErrorAuthState implements AuthState {
  final String errorMessage;

  ErrorAuthState({required this.errorMessage});
}
