import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential userCredential;
  late User? user;
  late String caughtException;

  String? exceptionCaught(String code) {
    if (code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    } else if (code == 'too-many-requests') {
      return 'Too many requests, please try again later';
    } else if (code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (code == 'wrong-password') {
      return 'Wrong password provided for that user.';
    }
    return code;
  }

  Future<String> verifyEmail(User? user) async {
    try {
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return 'Please verify the email sent to the email address you provided';
      }
    } on FirebaseAuthException catch (e) {
      return caughtException = exceptionCaught(e.code)!;
    }
    return 'Email Verified';
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
      return caughtException = exceptionCaught(e.code)!;
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
      return caughtException = exceptionCaught(e.code)!;
    }
  }

  Future<String?> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
      return "Password reset email sent";
    } on FirebaseAuthException catch (e) {
      return caughtException = exceptionCaught(e.code)!;
    }
  }
}
