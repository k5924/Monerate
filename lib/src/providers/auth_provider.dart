import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/utilities/export.dart';

class AuthProvider {
  final FirebaseAuth auth;
  final DatabaseProvider databaseProvider =
      DatabaseProvider(db: FirebaseFirestore.instance);

  late UserCredential userCredential;
  late User? user;
  late ExceptionsFactory exceptionsFactory;
  late UserModel userModel;

  AuthProvider({required this.auth});

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
      userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = auth.currentUser;
      await databaseProvider.createNewUser(uid: user!.uid);
      return verifyEmail(user);
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = auth.currentUser;
      return verifyEmail(user);
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  Future<String?> forgotPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(
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
      user = auth.currentUser;
      userModel = await databaseProvider.getProfile(uid: user!.uid);
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
      user = auth.currentUser;
      userModel = UserModel(
        firstName: firstName,
        lastName: lastName,
        userType: userType,
      );
      await databaseProvider.updateProfile(
        profileData: userModel,
        uid: user!.uid,
      );
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
      user = auth.currentUser;
      userModel = FinancialAdvisorModel(
        firstName: firstName,
        lastName: lastName,
        userType: userType,
        licenseID: licenseID,
      );
      await databaseProvider.updateProfile(
        profileData: userModel,
        uid: user!.uid,
      );
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  Future<String?> logout() async {
    try {
      auth.signOut();
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  Future<Object> getProfile() async {
    try {
      user = auth.currentUser;
      userModel = await databaseProvider.getProfile(uid: user!.uid);
      return userModel.toMap();
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  Future<String?> changeEmail(String newEmail, String password) async {
    try {
      user = auth.currentUser;
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
      user = auth.currentUser;
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

  Future<String?> getUserType() async {
    try {
      user = auth.currentUser;
      userModel = await databaseProvider.getProfile(uid: user!.uid);
      return userModel.userType;
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  Future<String?> addInvestment({
    required String name,
    required String symbol,
    required String type,
    required String amount,
    required String price,
  }) async {
    try {
      user = auth.currentUser;
      final userID = user!.uid;
      await databaseProvider.addBalance(
        name: name,
        symbol: symbol,
        type: type,
        amount: amount,
        price: price,
        uid: userID,
      );
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  Future<String> getUID() async {
    try {
      user = auth.currentUser;
      return user!.uid;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
