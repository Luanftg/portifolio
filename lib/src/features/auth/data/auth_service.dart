import 'package:portifolio/src/features/auth/domain/auth_model.dart';

abstract class AuthService {
  Future<void> call(AuthModel authModel);
}
