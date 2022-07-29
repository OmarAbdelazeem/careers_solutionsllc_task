import 'package:careers_solutionsllc_task/src/data/web_services/authentication_web_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  final AuthenticationWebServices authenticationWebServices;

  AuthenticationRepository(this.authenticationWebServices);

  Future<User?> loginAnonymously() async {
    return await authenticationWebServices.loginAnonymously();
  }

  User? getCurrentUser() {
    return authenticationWebServices.getCurrentUser();
  }

  Future<void> logout() async {
    authenticationWebServices.logout();
  }
}
