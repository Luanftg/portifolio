import 'package:portifolio/src/features/auth/domain/auth_model.dart';

sealed class AuthEvent {}

class RequestLogin implements AuthEvent {
  final AuthModel authmodel;

  RequestLogin({required this.authmodel});
}
