import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential userCredential;
  late User? user;

  Future<String> verifyEmail(User? user) async {
    try {
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return 'Please verify the email sent to the email address you provided';
      }
      return 'Email Verified';
    } on FirebaseAuthException catch (e) {
      return 'Too many requests, please try again later';
    }
  }

  Future<String?> registerUser(String email, String password) async {
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = _auth.currentUser;
      return verifyEmail(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else if (e.code == 'too-many-requests') {
        return 'Too many requests, please try again later';
      }
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = _auth.currentUser;
      return verifyEmail(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else if (e.code == 'too-many-requests') {
        return 'Too many requests, please try again later';
      }
    }
  }
}
