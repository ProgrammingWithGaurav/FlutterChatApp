import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instance for auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // signup
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // logout
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
