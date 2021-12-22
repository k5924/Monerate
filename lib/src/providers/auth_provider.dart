import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential userCredential;
  late User? user;

  Future<void> verifyEmail(User? user) async {
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<String?> registerUser(String email, String password) async {
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = _auth.currentUser;
      verifyEmail(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    }
    return 'Please verify the email sent to the email address you provided';
  }
}
