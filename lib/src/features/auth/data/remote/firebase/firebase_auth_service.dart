import 'package:firebase_auth/firebase_auth.dart';
import 'package:portifolio/src/features/auth/data/auth_service.dart';
import 'package:portifolio/src/features/auth/domain/auth_model.dart';

class FirebaseAuthService implements AuthService {
  late final FirebaseAuth _firebaseAuth;

  FirebaseAuthService() : _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> call(AuthModel authModel) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: authModel.email,
        password: authModel.password,
      );
    } catch (e) {
      rethrow;
    }
  }
}
