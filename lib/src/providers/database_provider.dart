import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/utilities/export.dart';

class DatabaseProvider {
  final FirebaseFirestore db;
  late ExceptionsFactory exceptionsFactory;
  late UserModel userModel;

  DatabaseProvider({required this.db});

  late CollectionReference usersCollection = db.collection('users');

  Future<void> createNewUser({required String uid}) async {
    userModel = UserModel();
    await usersCollection.doc(uid).set(
          userModel.toMap(),
        );
  }

  Future<UserModel> getProfile({required String uid}) async {
    await usersCollection.doc(uid).get().then((value) {
      // ignore: cast_nullable_to_non_nullable
      userModel = UserModel.fromMap(value.data() as Map<String, dynamic>);
    });
    return userModel;
  }

  Future<void> updateProfile({required UserModel profileData, required String uid}) async {
    userModel = profileData;
    await usersCollection.doc(uid).update(userModel.toMap());
  }
}
