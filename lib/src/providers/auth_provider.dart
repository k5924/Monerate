import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/utilities/export.dart';

/// This class lets us interact with firebase auth
class AuthProvider {
  /// This variable stores an instance of firebase auth
  final FirebaseAuth auth;

  /// This variable stores an instance of database provider
  final DatabaseProvider databaseProvider =
      DatabaseProvider(db: FirebaseFirestore.instance);

  /// This variable will store an instance of a user credential
  late UserCredential userCredential;

  /// This variable will store an instance of a user object
  late User? user;

  /// This variable will store an instance of the exceptions factory
  late ExceptionsFactory exceptionsFactory;

  /// This variable will store an instance of the user model
  late UserModel userModel;

  /// This constructor requires that we inject a firebase auth instance before using this class
  AuthProvider({required this.auth});

  /// This method lets us verify the email of an individual user
  Future<String> _verifyEmail({
    required User? user,
  }) async {
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

  /// This method registers a user based on their email and password
  Future<String?> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = auth.currentUser;
      await databaseProvider.createNewUser(uid: user!.uid);
      return _verifyEmail(user: user);
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  /// This method signs in a user based on their email and password
  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = auth.currentUser;
      return _verifyEmail(user: user);
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
  }

  /// This method sends a forgot password email to a user based on their email address
  Future<String?> forgotPassword({
    required String email,
  }) async {
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

  /// This method checks whether a users profile is complete in the cloud firestore users collection
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

  /// This method updates a users profile based on their name and user type
  Future<String?> updateUserProfile({
    required String firstName,
    required String lastName,
    required String userType,
  }) async {
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
    return null;
  }

  /// This method updates a financial advisors profile based on their name, user type and license id
  Future<String?> updateFinancialAdvisorProfile({
    required String firstName,
    required String lastName,
    required String userType,
    required String licenseID,
  }) async {
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
    return null;
  }

  /// This method logs a user out of the application
  Future<String?> logout() async {
    try {
      auth.signOut();
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
    return null;
  }

  /// This method returns the profile of a user
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

  /// This method lets a user change their email based on a new email and password
  Future<String?> changeEmail({
    required String newEmail,
    required String password,
  }) async {
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
    return null;
  }

  /// This method lets a user change their password based on their old password and new password
  Future<String?> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
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
    return null;
  }

  /// This method retrieves the users user type from cloud firestore
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

  /// This method lets a user add a finance account to the balances collection based on details of the financial account
  Future<String?> addFinanceAccount({
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
    return null;
  }

  /// This method lets a user update a financial account by supplying an instance of balancemodel, a new amount and a new price
  Future<String?> updateFinanceAccount({
    required BalanceModel balanceModel,
    required String newAmount,
    required String newPrice,
  }) async {
    try {
      final String documentID = await databaseProvider.getBalanceID(
        balanceModel: balanceModel,
      );
      await databaseProvider.updateBalance(
        documentID: documentID,
        oldBalance: balanceModel,
        amount: newAmount,
        price: newPrice,
      );
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
    return null;
  }

  /// This method lets a user remove a financial account from the balances collection
  Future<String?> removeFinanceAccount({
    required BalanceModel balanceModel,
  }) async {
    try {
      final String documentID = await databaseProvider.getBalanceID(
        balanceModel: balanceModel,
      );
      await databaseProvider.removeBalance(
        documentID: documentID,
      );
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
    return null;
  }

  /// This method lets a user remove multiple financial accounts from the balances collection
  Future<String?> removeMultipleFinanceAccounts({
    required BalanceModel balanceModel,
  }) async {
    try {
      final documentIDs = await databaseProvider.getMultipleBalanceIDs(
        balanceModel: balanceModel,
      );
      for (final String documentID in documentIDs) {
        await databaseProvider.removeBalance(
          documentID: documentID,
        );
      }
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
    return null;
  }

  /// This method retrieves a users uid from firebase
  Future<String> getUID() async {
    try {
      user = auth.currentUser;
      return user!.uid;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  /// This method lets a user delete their account
  Future<String?> deleteUserAccount() async {
    try {
      final userID = await getUID();
      final balanceIDs =
          await databaseProvider.getBalanceIDsForOneUser(userID: userID);
      for (final String balanceID in balanceIDs) {
        await databaseProvider.removeBalance(
          documentID: balanceID,
        );
      }
      await databaseProvider.deleteUser(userID: userID);
      await user!.delete();
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
    return null;
  }

  /// This method lets a user make a new chat
  Future<String> makeNewChat({
    required String chatType,
  }) async {
    try {
      final userID = await getUID();
      final Map<String, dynamic>? userDetails =
          await getProfile() as Map<String, dynamic>?;
      final ChatModel chatModel = ChatModel(
        userID: userID,
        firstName: userDetails!['firstName'].toString(),
        lastName: userDetails['lastName'].toString(),
        chatType: chatType,
        latestMessage: DateTime.now().toUtc(),
      );
      return await databaseProvider.makeNewChat(chatModel: chatModel);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  /// This method lets a user send a new message in a chat
  Future<String?> sendNewMessage({
    required String documentReferenceID,
    required String message,
  }) async {
    try {
      final userID = await getUID();
      final Map<String, dynamic>? userDetails =
          await getProfile() as Map<String, dynamic>?;
      final MessageModel messageModel = MessageModel(
        senderID: userID,
        firstName: userDetails!['firstName'].toString(),
        lastName: userDetails['lastName'].toString(),
        message: message,
        createdAt: DateTime.now().toUtc(),
      );
      await databaseProvider.sendMessage(
        documentReferenceID: documentReferenceID,
        messageModel: messageModel,
      );
    } on FirebaseAuthException catch (e) {
      exceptionsFactory = ExceptionsFactory(e.code);
      return exceptionsFactory.exceptionCaught()!;
    }
    return null;
  }

  /// This method retrieves the document reference id for a single chat instance
  Future<String> getChat({
    required ChatModel chatModel,
  }) async {
    try {
      final String documentReferenceID =
          await databaseProvider.getChat(chatModel: chatModel);
      return documentReferenceID;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
