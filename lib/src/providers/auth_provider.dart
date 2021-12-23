import 'package:firebase_auth/firebase_auth.dart';
import 'package:monerate/src/utilities/export.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential userCredential;
  late User? user;
  late ExceptionsFactory exceptionsFactory;

  Future<String> verifyEmail(User? user) async {
    try {
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return 'Please verify the email sent to the email address you provided';
      }
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
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
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
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
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  Future<String?> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
      return "Password reset email sent";
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }
}
