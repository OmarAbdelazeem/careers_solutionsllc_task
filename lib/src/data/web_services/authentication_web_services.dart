import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationWebServices {
  final FirebaseAuth _firebaseInstance = FirebaseAuth.instance;

  Future<User?> loginAnonymously() async {
    try {
      await _firebaseInstance.signInAnonymously();
      return _firebaseInstance.currentUser;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  User? getCurrentUser() {
    return _firebaseInstance.currentUser;
  }

  Future<void> logout() async {
    _firebaseInstance.signOut();
  }
}
