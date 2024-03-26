import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:portifolio/src/features/auth/bloc/events/auth_event.dart';
import 'package:portifolio/src/features/auth/bloc/states/auth_state.dart';
import 'package:portifolio/src/features/auth/data/auth_service.dart';
import 'package:portifolio/src/features/auth/domain/auth_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    super.initialState, {
    required AuthService authService,
  }) {
    _authService = authService;
    _mapEvents();
  }

  late final AuthService _authService;

  void _mapEvents() {
    on<RequestLogin>((RequestLogin event, emit) async {
      try {
        await _authService(event.authmodel);
        emit(LoggedState());
      } catch (e) {
        emit(ErrorAuthState(errorMessage: e.toString()));
        emit(UnloggedState(isLoading: false));
      }
    });
  }

  void requestLogin(String email, String password) =>
      add(RequestLogin(authmodel: AuthModel(email: email, password: password)));

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    log('event:[${transition.event}]\ncurrentState:[${transition.currentState}]\nnextState:[${transition.nextState}]');
    super.onTransition(transition);
  }
}
