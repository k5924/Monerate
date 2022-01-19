import 'package:firebase_auth/firebase_auth.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/utilities/export.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential userCredential;
  late User? user;
  late ExceptionsFactory exceptionsFactory;
  late UserModel userModel;

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
      await DatabaseProvider(uid: user!.uid).createNewUser();
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

  Future<Object> checkProfile() async {
    try {
      user = _auth.currentUser;
      userModel = await DatabaseProvider(uid: user!.uid).getProfile();
      if (userModel.getUserType() == null ||
          userModel.getUserType() == 'null') {
        return false;
      } else {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  Future<String?> updateUserProfile(
    String firstName,
    String lastName,
    String userType,
  ) async {
    try {
      user = _auth.currentUser;
      userModel = UserModel(
        firstName: firstName,
        lastName: lastName,
        userType: userType,
      );
      await DatabaseProvider(uid: user!.uid).updateProfile(userModel);
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  Future<String?> updateFinancialAdvisorProfile(
    String firstName,
    String lastName,
    String userType,
    String licenseID,
  ) async {
    try {
      user = _auth.currentUser;
      userModel = FinancialAdvisorModel(
        firstName: firstName,
        lastName: lastName,
        userType: userType,
        licenseID: licenseID,
      );
      await DatabaseProvider(uid: user!.uid).updateProfile(userModel);
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  Future<String?> logout() async {
    try {
      _auth.signOut();
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  Future<Object> getProfile() async {
    try {
      user = _auth.currentUser;
      userModel = await DatabaseProvider(uid: user!.uid).getProfile();
      return userModel.toMap();
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  Future<String?> changeEmail(String newEmail, String password) async {
    try {
      user = _auth.currentUser;
      final currentEmail = user!.email;
      final credential = EmailAuthProvider.credential(
        email: currentEmail!,
        password: password,
      );
      await user!
          .reauthenticateWithCredential(credential)
          .then((value) => user!.updateEmail(newEmail));
      await user!.sendEmailVerification();
      logout();
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  Future<String?> changePassword(String oldPassword, String newPassword) async {
    try {
      user = _auth.currentUser;
      final currentEmail = user!.email;
      final credential = EmailAuthProvider.credential(
        email: currentEmail!,
        password: oldPassword,
      );
      await user!
          .reauthenticateWithCredential(credential)
          .then((value) => user!.updatePassword(newPassword));
      logout();
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }
}
